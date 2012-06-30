> module TypeCheck where

> --import Trace		-- hugs only
> import Control.Monad.Reader

> import Misc(assert_)
> import Syntax
> import SymbolTable
> import Printer

%---------------------------------------

> type_check :: Program -> SymbolTable Type Type -> Maybe Program
> type_check t st
>  = fmap (\(p,()) -> p)
>  $ runReaderT (typeCheck t) st 

> type M a = ReaderT (SymbolTable Type Type) Maybe a

> class TypeCheck s t where
>	typeCheck :: s -> M (s,t)

> -- getType :: Tabular (SymbolTable Type Type) t => Id -> M t
> -- ghc objects to this - see TransBasics too
> getType n
>  = do
>	s <- ask 
>	lift (look s n)

---

> getHierarchy :: Id -> M [Id]
> getHierarchy n 
>  = do
>	s <- ask 
>	return (map class_nm $ class_and_parents s n)

---

> typeCompatible val_type hole msg
>  = case val_type of
>      T_Id vt -> do
>		    vt_and_parents <- fmap (map T_Id) $ getHierarchy vt
>		    assert_ (hole `elem` vt_and_parents) (type_err $ T_Id vt)
>      _       -> assert_ (hole == val_type) (type_err val_type)
>    where
>	type_err vt 
>	  = msg ++ ": got " 
>	     ++ pretty_print vt ++ ", expected " 
>	     ++ pretty_print hole

---
Hack: using trace for warnings/errors, and not stopping comp after TC.

> handle :: String -> a -> M a -> M a
> handle msg ty action
>  = do
>	s <- ask
>	action `mplus` (show_err s $ return ty)
>    where
>	show_err s = trace ("(In " ++ show (cur_place s) ++ "):" ++ msg ++ "\n")

<> tr m = trace (m ++ "\n") $ return ()

> trace s a = a

%---------------------------------------

> instance TypeCheck Program () where 
>	typeCheck (Program main class_decls)
>	 = do
>		(m',()) <- typeCheck main
>		(cs,_) <- fmap unzip $ mapM typeCheck class_decls 
>				:: M ([ClassDecl],[()])
>		return $ (Program m' cs, ())

> instance TypeCheck MainClass () where
>	typeCheck mc@(MainClass main_class_name pars_name main_body)
>	 = do
>	      (m',()) <- typeCheck main_body
>	      return (mc{main_body = m'}, ())

> instance TypeCheck ClassDecl () where
>	typeCheck c@(ClassDecl class_name sc vars methods)
>	 = local (setClass class_name)
>	 $ do
>		ms <- mapM typeCheck methods :: M [(MethodDecl,())]
>		return (c{methods = map fst ms}, ())


> instance TypeCheck MethodDecl () where
>	typeCheck md@(MethodDecl m_type m_name m_args decls body m_return)
>	 = local (setMethod m_name)
>	 $ do
>		bs <- mapM typeCheck body :: M [(Statement,())]
>		(re,rt) <- typeCheck m_return
>		typeCompatible rt m_type "Return type doesn't match"
>		return (md{body=map fst bs, m_return = re}, ())

%---------------------------------------

> instance TypeCheck Statement () where
>	typeCheck (S_Block statements) 
>	 = do
>		ss <- mapM typeCheck statements :: M [(Statement,())]
>		return (S_Block $ map fst ss, ())

>	typeCheck s@(S_If cond then_arm else_arm) 
>	 = handle ("problem in if-statement\n" ++ pretty_print s) (s,()) 
>	 $ do
>		(cond',T_Boolean) <- typeCheck cond
>	        (then_arm',()) <- typeCheck then_arm
>	        (else_arm',()) <- typeCheck else_arm
>		return (S_If cond' then_arm' else_arm', ())

>	typeCheck s@(S_While cond while_body) 
>	 = handle "problem in while-statement" (s,()) 
>	 $ do
>		(cond', T_Boolean) <- typeCheck cond
>	        (body', ()) <- typeCheck while_body
>		return (S_While cond' body',())

>	typeCheck (S_Print exp) 	-- can print anything
>	 = do
>		(exp', ty) <- typeCheck exp :: M (Exp,Type)
>		assert_ (ty == T_Int) "Print expects an Int[]"
>		return (S_Print exp', ())

>	typeCheck (S_Assign var value)
>	 = do
>		s <- ask
>		Var _ lhs <- getType var
> 		(value', rhs :: Type) <- typeCheck value
>		typeCompatible rhs lhs "Assign types don't match"
>		return (S_Assign var value',())

>	typeCheck (S_ArrayAssign var arr_index value)
>	 = do
>		Var _ lhs <- getType var
>		assert_ (lhs == T_IntArray) "Array assign needs Int[]"

> 		(ix',ix_ty) <- typeCheck arr_index
>		assert_ (ix_ty == T_Int) "Array index should be Int type"

> 		(value',rhs :: Type) <- typeCheck value
>		assert_ (rhs == T_Int)
>	                ("Array assign requires Int value")
>		return (S_ArrayAssign var ix' value', ())

%---------------------------------------

> instance TypeCheck Exp Type where
>	typeCheck e@E_false   = return (e,T_Boolean)
>	typeCheck e@E_true    = return (e,T_Boolean)
>	typeCheck e@E_this    = do s <- ask		-- using scope marker
>	                           c <- lift (getClass s)
>	                           return (e,T_Id c)
>	typeCheck e@(E_Int i) = return (e,T_Int)

>	typeCheck e@(E_Id n)  = handle ("No such id: " ++ show n) (e,T_Int)
>	                      $ do { Var _ t <- getType n; return (e,t) }

>	typeCheck e@(Length exp)
>	 = handle ("length arg not an array") (e,T_Int)
>	 $ do (exp',T_IntArray) <- typeCheck exp
>	      return (exp',T_Int)

>	typeCheck e@(E_Not exp)   
>	 = handle ("Not arg not boolean") (e,T_Boolean)
>	 $ do (exp',T_Boolean) <- typeCheck exp
>	      return (E_Not exp',T_Boolean)

>	typeCheck (B_Op op l r) 
>	 = do
>	      (l',lt) <- typeCheck l
>	      (r',rt) <- typeCheck r
>	      fmap (\ty -> (B_Op op l' r', ty)) $ check op lt rt
>          where
>		check BoolAnd  T_Boolean T_Boolean = return T_Boolean
>		check LessThan T_Int     T_Int     = return T_Boolean
>		check Add      T_Int     T_Int     = return T_Int
>		check Subtract T_Int     T_Int     = return T_Int
>		check Multiply T_Int     T_Int     = return T_Int
>		check op       lt        rt        
>		 = handle ("Type error: " ++ show (op, lt, rt)) (default_ret op)
>		 $ fail (error "not used")
>		default_ret BoolAnd = T_Boolean
>		default_ret _       = T_Int

>	typeCheck e@(E_NewArray size_exp)         
>	 = handle ("Array size not Int") (e,T_IntArray)
>	 $ do
>	      (size',T_Int) <- typeCheck size_exp
>	      return (E_NewArray size',T_IntArray)

>	typeCheck e@(E_Index array_exp index_exp)
>	 = handle ("Bad array indexing") (e,T_Int)
>	 $ do
>	      (arr',T_IntArray) <- typeCheck array_exp
>	      (ix', T_Int)      <- typeCheck index_exp
>	      return (E_Index arr' ix', T_Int)

>	-- check that class name is known
>	typeCheck e@(E_NewObj class_name)		
>	 = do
>	      (c :: Class Type Type) <- getType class_name
>	      return (e,T_Id class_name)

>	typeCheck (Call _ callee method args)
>	 = do
>             (val',~val_t@(T_Id val_c)) <- typeCheck callee

>	      let isClass (T_Id _) = True
>	          isClass _        = False
>	      assert_ (isClass val_t) "callee has to be instance of some class"

>	      (mi :: Method Type Type) 
>	         <- handle ("unknown method: " ++ show method)
>	                            (Method method T_Int [] [])
>	          $ local (setClass val_c) 
>	          $ getType method 

>	      assert_ (length args == length (params mi))
>	              $ "Wrong number of arguments for the method" ++ show (length args, length (params mi))

>	      arg_tys <- mapM typeCheck args
>             sequence [ typeCompatible at pt "Arg type doesn't match"
>	               | (Var _ pt, (_,at)) <- zip (params mi) arg_tys ]

>	      return (Call val_c val' method (map fst arg_tys), method_info mi)

