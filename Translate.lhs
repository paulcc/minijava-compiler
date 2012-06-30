> module Translate (trans, MethodTranslation(..)) where

> import Data.IORef(IORef(..), newIORef, readIORef, writeIORef)
> import Control.Monad.Reader 
> import List(nubBy)

> import SymbolTable
> import Temp
> import IR 
> import PrintIR 
> import Syntax hiding (args, value)
> import TransBasics

%---------------------------------------
Translate - two parts
  - chg ST into var refs
  - translate code into IR

> trans :: SymbolTable a b 
>	-> Program 
>	-> IO (LabelSupply, [MethodTranslation Stm], AllocTable SymbolTable)
> trans t p
>  = do
>	labels <- newLabelSupply
>	t' <- stVars t
>	ls <- runReaderT (translate p) (labels,t')
>	return (labels, ls, t')

%---------------------------------------
Variable storage - translation
 * params to stack offsets
 * vars treated appropriately
 * add "this" 

> methodVars :: Id -> (Int, Method a b) -> IO (AllocTable Method)
> methodVars class_name (index, Method name method_info params locals)
>  = do
>	let ps = [ Var v (TEMP $ InFrame (i * wordSize)) 
>		 | (Var v _, i) <- zip (thisVar : params) [0..]] -- positive
>	let ls = [ Var v (TEMP $ InFrame (- i * wordSize)) 
>		 | (Var v _, i) <- zip locals  [1..]] -- negative
>	ref <- newIORef (1 + length ls)
>	let full_name = if name == mainLabel then name else class_name ++ "_" ++ name
>	return $ Method name ((index,full_name), ref) ps ls 

> thisVar = Var "this" (error "this-type")

EXERCISE: decide how to return things - var or stack or reg?
	NB can probably over-write "this" at end, since no longer reqd.
	Currently returning via separate register (retval)

> returnTemp = NAME "retval"

> classVars :: SymbolTable a b -> Class a b -> IO (AllocTable Class)
> classVars s (Class c_name ext vars methods) 
>  = do
>	let vs = [ Var v (MEM $ BINOP ADD (TEMP $ InFrame 0) 
>	                                  (CONST $ i * heapCellSize))
>	         | (i, Var v _) <- zip [vstart ..] vars ]
>	ms <- mapM (methodVars c_name) $ allocate_indices methods
>	return $ Class c_name ext vs ms
>    where
>	vstart = case ext of
>	          Nothing -> 0
>	          Just p  -> classSize p s
>	indices 
>	 = zip [0..] ms		-- name alloc sweeps downwards from base
>	   where
>		cs = case ext of
>		       Nothing -> []
>		       Just p  -> reverse $ class_and_parents s p
>		ms = nubBy (\a b -> name a == name b) $ concatMap class_mthds cs
>	allocate_indices ms
>	 = [ (i,m) 			-- overridden
>	   | m <- methods
>	   , (i,_) <- [ im | im <- indices, name m == name (snd im) ] ]
>	   ++ 
>	   zip [ length indices .. ]	-- fresh
>	       [ m | m <- methods, name m `notElem` map (name.snd) indices ]


> heapCellSize = 4 :: Int

> stVars :: SymbolTable a b -> IO (AllocTable SymbolTable)
> stVars s@(SymbolTable cs Nothing) 
>  = do
>	cs' <- mapM (classVars s) cs
>	return $ SymbolTable cs' Nothing


%---------------------------------------
Translation of Program

> class Translate s i where
>	translate :: s -> M i

> instance Translate s [i] => Translate [s] [i] where
>	-- translate xs = fmap (foldr SEQ null_stm) $ mapM translate xs
>	translate xs = fmap concat $ mapM translate xs


%---------------------------------------

> instance Translate Program [MethodTranslation Stm] where 
>	translate (Program (MainClass nm _ body) class_decls)
>	 = local (\(r,t) -> (r, setMethod mainLabel $ setClass nm t))
>	 $ do
>	        (mi :: AllocTable Method) <- look_ mainLabel
>		body' <- translate body
>		decls' <- mapM translate class_decls
>		let exitpt = mainLabel ++ "_exit"
>		return $ MethodTranslation (0,mainLabel) (snd $ method_info mi)
>	                           (toSEQ $ LABEL mainLabel
>		                          : body'
>		                          ++ [JUMP (NAME exitpt) [exitpt]])
>	               : concat decls'

Class decl
 - NB vars already allocated

> instance Translate ClassDecl [MethodTranslation Stm] where
>	translate (ClassDecl class_name _ vars methods)
>	 = local (\(r,t) -> (r, setClass class_name t))
>	 $ mapM translate methods

> instance Translate MethodDecl (MethodTranslation Stm) where
>	translate (MethodDecl m_type m_name m_args decls body m_return)
>	 = local (\(r,t) -> (r, setMethod m_name t))
>	 $ do
>	     (mi :: AllocTable Method) <- look_ m_name 
>	     b <- translate body
>	     r <- translate m_return
>	     let info = method_info mi
>	     let exitpt = snd (fst info) ++ "_exit"
>	     let ret = [ MOVE returnTemp r
>	               , JUMP (NAME exitpt) [exitpt]]
>	     return $ MethodTranslation (fst info) (snd info) 
>	                                (toSEQ $ {-LABEL (fst info) :-} b ++ ret)

%-------------------

> instance Translate Statement [Stm] where
>	translate (S_Block statements) 
>	 = translate statements

>	translate (S_If cond then_arm else_arm) 
>	 = do
>		cond' <- translate cond
>		l_true  <- getNewLabel
>		then_arm' <- translate then_arm
>		l_false <- getNewLabel
>		else_arm' <- translate else_arm
>		l_end   <- getNewLabel
>		return $  [CJUMP EQ_ cond' trueIR l_true l_false]
>		       ++ (LABEL l_true  : then_arm' ++ [jump l_end])
>		       ++ (LABEL l_false : else_arm' ++ [jump l_end])
>		       ++ [LABEL l_end]


>	translate (S_While cond body) 
>	 =  do
>		l_test  <- getNewLabel
>		cond' <- translate cond
>		l_body  <- getNewLabel
>		body' <- translate body
>		l_end   <- getNewLabel
>		return $  [LABEL l_test] 
>		       ++ [CJUMP EQ_ cond' falseIR l_end l_body]
>		       ++ [LABEL l_body]
>		       ++ body'
>		       ++ [jump l_test]
>		       ++ [LABEL l_end]

>	translate (S_Print exp) 
>	 = do
>		exp' <- translate exp
>		fmap (\s -> [EXP s])
>		 $ canonicalCall $ CALL (NAME "print") [exp']

>	translate (S_Assign var value) 
>	 =  do
>		tmp <- getVar var
>		value' <- translate value
>		return [ MOVE tmp value' ]

>	translate (S_ArrayAssign var arr_index value) 
>	 =  do
>		tmp <- getVar var
>		(check, loc) <- arrayLookup tmp arr_index
>		value' <- translate value
>		return $ check ++ [MOVE loc value']

%---------------------------------------

> instance Translate Syntax.Exp IR.Exp where
>	translate E_false   = return $ falseIR
>	translate E_true    = return $ trueIR

>	translate E_this    = getVar "this"		-- magic var

>	translate (E_Int i) = return $ CONST i
>	translate (E_Id n)  = getVar n

---
Bool AND mapped to multiplication - this works, but not efficient

EXERCISE: change BoolAnd treatment to be short-cutting.

>	translate (B_Op op l r) 
>	 = do
>		l' <- translate l
>		r' <- translate r
>		let op' = case op of
>		            Add      -> ADD		-- check iso of types
>			    Subtract -> SUBTRACT
>			    Multiply -> TIMES
>			    LessThan -> TEST LT
>			    BoolAnd  -> TIMES
>		return $ BINOP op' l' r'




>	translate (Length exp)
>	 = do
>		exp' <- translate exp
>		return $ MEM(exp')		-- first slot of the mem block

>	translate (E_Not exp)			-- by (x == false)
>	 = do
>		exp' <- translate exp
>		false <- translate E_false
>		return $ BINOP (TEST EQ) exp' false

>	translate (E_Index array_exp index_exp) 
>	 = do
>		array <- translate array_exp
>		(check, loc) <- arrayLookup array index_exp
>		return $ ESEQ (stms check) loc

---
Look up method relative to class of callee

>	translate (Call class_ callee method args)
>	 = do
>		what  <- translate callee
>		label <- findMethod class_ method
>		args' <- mapM translate args
>		canonicalCall 
>			$ CALL (LCONST (class_ ++ "." ++ method) (fst label)) 
>		               (what:args')



%---------------------------------------

Assume malloc clears - can't be bothered...

>	translate (E_NewObj class_name)
>	 = do
>		c_sz <- asks (classSize class_name . snd)
>		let size = c_sz * heapCellSize
>		canonicalCall $ CALL (NAME "obj_alloc") 
>				     [CONST size, NAME $ "jump" ++ class_name]

EXERCISE - add checking for positive size!

>	translate (E_NewArray size_exp)
>	 = do
>		elems <- translate size_exp
>		size_tmp <- fmap TEMP newTemp
>		let size = BINOP TIMES (BINOP ADD (CONST 1) size_tmp) 
>		                       (CONST heapCellSize)
>		ESEQ call heap <- canonicalCall $ CALL (NAME "malloc") [size]
>		return $ ESEQ (SEQ (MOVE size_tmp elems) 
>		                   (SEQ call 
>		                        (MOVE (MEM heap) size_tmp)))
>		              heap

%-------------------------------------------------------------------------------
Find loc of array element, if ok
 - via continuation

> arrayLookup :: IR.Exp -> Syntax.Exp -> M ([Stm], IR.Exp)
> arrayLookup array arr_index 
>  = do
>	index <- translate arr_index
>	l_test2 <- getNewLabel
>	l_fetch <- getNewLabel
>	tmp     <- fmap TEMP newTemp	-- to avoid re-computation each time!
>	l_crash <- getNewLabel
>	crash   <- canonicalCall $ CALL (NAME crash_array) []
>	return ([ MOVE tmp index
>		, CJUMP LT_ tmp (CONST 0) l_crash l_test2
>	        , LABEL l_test2
>	        , CJUMP LT_ tmp (MEM array) l_fetch l_crash
>		, LABEL l_crash
>		, EXP crash 
>	        , LABEL l_fetch ]
>	       , MEM $ BINOP ADD array 
>                    $ BINOP TIMES (CONST heapCellSize)
>	             $ BINOP ADD tmp (CONST 1))


> -- some routine defined for crashing (NB requires longjmp?)
> crash_array = "crash_array"
	

%---------------------------------------
finding methods
 - temporarily chg locale to callee's class
 - look for first match in class chain (done in ST lookup)

> findMethod :: Id -> Id -> M MethodLabel
> findMethod class_ mthd
>  = local (\(r,t) -> (r, setClass class_ t))
>  $ do
>	-- mi <- look_ mthd :: M (Method IR.Exp (Label,IORef Frame))
>	mi <- look_ mthd :: M (AllocTable Method) 
>	return $ fst $ method_info mi


%---------------------------------------
Produce calls in canonical form

> canonicalCall call@(CALL f _)
>  = do
>	tmp   <- newTemp
>	return $ ESEQ (MOVE (TEMP tmp) call) (TEMP tmp)

---
