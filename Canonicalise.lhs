> module Canonicalise (linearize, rwE, rwS) where

> import Maybe (fromMaybe)
> import Control.Monad.Reader
> import Data.IORef

> import Temp
> import TransBasics hiding (M, newTemp)
> import IR
> import PrintIR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Second part: canonicalisation

> class Canonical s where
>	canonical :: s -> Bool

> instance Canonical Stm where
>	canonical SEQ{} = False
>	canonical LABEL{} = True
>	canonical (JUMP jexp _) = canonical jexp
>	canonical cj@CJUMP{} = canonical (jleft cj) && canonical (jright cj)

>	-- call cases - only these two allowed.
>	canonical (EXP (CALL f as))           = canonical f && all canonical as 
>	canonical (MOVE (TEMP _) (CALL f as)) = canonical f && all canonical as

>	-- simple cases
>	canonical (MOVE dst src) = canonical dst && canonical src
>	canonical (EXP e) = canonical e

> instance Canonical Exp where
>	canonical CONST{} = True
>	canonical LCONST{} = True
>	canonical NAME{}  = True
>	canonical TEMP{}  = True
>	canonical CALL{}  = False	-- calls caught above
>	canonical ESEQ{}  = False	-- just not allowed
>	canonical (MEM e) = canonical e
>	canonical (BINOP _ left right) = canonical left && canonical right


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Put trees in canonical form, as specified above.

NOTE: fn calls translated to canonical form anyway. 


> type M a = ReaderT (IORef Int) IO a
>	-- frame vars	(labels not reqd)

> class RW c where
>	rw    :: c -> M (Maybe c)
>	apply :: c -> M (Maybe c)


%-------------------------------------------------------------------------------
Loop until failure, collecting results

> linearize :: MethodTranslation Stm -> IO (MethodTranslation [Stm])
> linearize (MethodTranslation l f s)
>  = do
>	s' <- rewrite_sequence f s
>	let which = if null s' then s else last s'
>	let ls = filter not_simple_Exp $ deSEQ which
>	if all canonical ls
>	  then return (MethodTranslation l f ls)
>	  else do
>		 let msg = "Couldn't linearize: " ++ show l ++ "\n" ++ show_seq s s'
>		 writeFile "out" msg
>		 error msg

---
for filtering out no-ops.

> not_simple_Exp (EXP NAME{})  = False
> not_simple_Exp (EXP CONST{}) = False
> not_simple_Exp (EXP TEMP{})  = False
> not_simple_Exp _             = True


---

> rewrite_sequence f s
>  = do
>	runReaderT (loop s) f
>    where
>	loop s = do
>	            r <- apply s
>	            case r of
>	              Nothing -> return []
>	              Just s' -> fmap (s':) $ loop s'


%---------------------------------------

Version 1: single rewrite per pass - inefficient but simpler

> try_rw_ :: RW c => c -> M (Maybe c)
> try_rw_ s
>  = rw s

> try_rw :: (RW a, RW b) => (a -> b) -> a -> M (Maybe b)
> try_rw cf s
>  = do
>	mr <- rw (cf s)
>	case mr of
>	  Just _  -> return mr
>	  Nothing -> do
>			ms <- apply s
>			return $ fmap cf ms

> try_rw2 :: (RW a, RW b, RW c) => (a -> b -> c) -> a -> b -> M (Maybe c)
> try_rw2 cf l r
>  = do
>	x <- rw (cf l r)
>	case x of
>	  Just x' -> return $ Just x'
>	  Nothing -> do 
>			ml <- apply l
>			case ml of
>			  Just l' -> return $ Just $ cf l' r
>			  Nothing -> do
>					mr <- apply r
>					case mr of
>					  Just r' -> return $ Just $ cf l r'
>					  Nothing -> return Nothing

try rewrite all
catch all-nothing case
l-r pass

%---------------------------------------


%---------------------------------------

> instance RW Stm where
>	rw = rwS

>	apply (MOVE dst src)
>	 = try_rw2 MOVE dst src

>	apply (EXP e)
>	 = try_rw EXP e

>	apply (JUMP jexp targets)
>	 = try_rw (\e -> JUMP e targets) jexp

>	apply (CJUMP relop jleft jright iftrue iffalse)
>	 = try_rw2 (\jl jr -> CJUMP relop jl jr iftrue iffalse) jleft jright

>	apply (SEQ sleft sright)
>	 = try_rw2 SEQ sleft sright

>	apply l@(LABEL _) 
>	 = try_rw_ l


> instance RW Exp where
>	rw = rwE

>	apply e@(CONST _) = try_rw_ e
>	apply e@LCONST{}  = try_rw_ e
>	apply e@(NAME  _) = try_rw_ e
>	apply e@(TEMP  _) = try_rw_ e

>	apply (MEM exp)
>	 = try_rw MEM exp

>	apply (ESEQ stm exp) 
>	 = try_rw2 ESEQ stm exp

>	apply (BINOP binop left right)
>	 = try_rw2 (BINOP binop) left right

>	apply (CALL func [arg])
>	 = do
>		try_rw2 (\f a -> CALL f [a]) func arg

>	apply (CALL func args)
>	 = do
>		mr <- rw (CALL func args)
>		case mr of
>		  Just _  -> return mr
>		  Nothing -> do
>				(func':args') <- mapM apply $ func : args
>				case [ n | n@Just{} <- func':args' ] of
>		  		  [] -> return Nothing
>		  		  js -> return 
>				      $ Just 
>				      $ CALL (fromMaybe func func') 
>		                             (zipWith fromMaybe args args')

if all nothings, then try rewrite original
else pick the rewrites and continue
NEED MORE WORK HERE.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Canonicalisation of calls done previously, once only.
NOTES REQD

> rwE (ESEQ s1 (ESEQ s2 e)) 
>  = chg $ ESEQ (SEQ s1 s2) e

> rwE (MEM (ESEQ s1 e)) 
>  = chg $ ESEQ s1 (MEM e)

> rwE (CALL nm (ESEQ s e:as))	-- first special case
>  = chg $ ESEQ s (CALL nm (e:as))

> rwE (CALL nm (a:ESEQ s e:as))	-- second special case
>  | commutes s a
>  = chg $ ESEQ s (CALL nm (a:e:as))

> rwE e@(CALL nm as)		-- general case, "sledgehammer"
>  | all simple_val as
>  = return $ Nothing
>  | not $ canonical e 
>  = do
>	ts <- mapM (const newTemp) as	-- fresh var for each
>	let ms = [ MOVE (TEMP t) a | (t,a) <- zip ts as ]
>	chg $ foldr ESEQ (CALL nm $ map TEMP ts) ms
>    where
>	simple_val TEMP{}  = True
>	simple_val NAME{}  = True
>	simple_val CONST{} = True
>	simple_val (MEM v) = simple_val v
>	simple_val _       = False


> rwE (BINOP op (ESEQ s l) r) 
>  = chg $ ESEQ s (BINOP op l r)

> rwE (BINOP op l (ESEQ s r))
>  | commutes s l
>  = chg $ ESEQ s (BINOP op l r)
>  | otherwise
>  = do
>	t <- newTemp
>	chg $ ESEQ (MOVE (TEMP t) l)
>	           (ESEQ s
>	                 (BINOP op (TEMP t) r))

> rwE (BINOP ADD   (CONST 0) r)         = chg r
> rwE (BINOP ADD   l         (CONST 0)) = chg l
> rwE (BINOP TIMES (CONST 1) r)         = chg r
> rwE (BINOP TIMES l         (CONST 1)) = chg l

> rwE _ 
>  = return $ Nothing

%---------------------------------------

> chg :: a -> M (Maybe a)
> chg = return . Just 

> rwS (EXP (ESEQ s e)) = chg $ SEQ s (EXP e)

> rwS (MOVE (ESEQ s dst) src) 
>  = chg $ SEQ s (MOVE dst src)

> rwS (MOVE dst (ESEQ s src))
>  | commutes s dst
>  = chg $ SEQ s (MOVE dst src)		-- ok for simple vars

> rwS (MOVE (MEM dst) (ESEQ s src))	-- save ptr in mem refs
>  = do
>	t <- newTemp
>	chg $ SEQ (MOVE (TEMP t) dst)
>	          (SEQ s 
>	               (MOVE (MEM $ TEMP t) src))
>	-- Note: MEM.TEMP is needed, so correct deref is done

> rwS (CJUMP op (ESEQ s e) r jl jr)
>  = chg $ SEQ s (CJUMP op e r jl jr)

> rwS _ 
>  = return $ Nothing

%---------------------------------------

> commutes :: Stm -> Exp -> Bool
> commutes (EXP (CONST _)) _         = True
> commutes _               (NAME  _) = True
> commutes _               (CONST _) = True
> commutes _               (TEMP _)  = True
> commutes _               _         = False


%-------------------------------------------------------------------------------

> t1 = SEQ (MOVE (ESEQ (LABEL "fred") (NAME "bill")) (CONST 4))
>          (SEQ (EXP (NAME "john"))
>               (MOVE (MEM (ESEQ (LABEL "dave") (NAME "dora"))) (CONST 3)))

> t2 = SEQ (MOVE (ESEQ (LABEL "fred") (NAME "bill")) (CONST 4))
>          (SEQ (EXP (NAME "john"))
>               (MOVE (MEM (ESEQ (LABEL "dave") (NAME "dora"))) 
>                     (CALL (NAME "foo") [NAME "a", NAME "b", ESEQ (LABEL "mike") (CONST 10)])))

> test :: Stm -> IO ()
> test s
>  = do
>	x <- newIORef 0
>	r <- rewrite_sequence x s
>	case r of 
>	  [] -> putStrLn "No rewrite"
>	  ss -> putStrLn 
>	      $ show_seq s ss

> show_seq s ss
>  = unlines
>  $ [ "\n----Version: " ++ show i ++ "\n" ++ pretty_print t 
>    | (i,t) <- zip [0..] (s:ss) ]
>    ++ [ "\n-- Canonical?: " ++ show (map canonical (deSEQ $ last ss)) ]


---
copied from TransBasics - same idea, different value in reader monad.

> newTemp :: M Temp
> newTemp
>  = do
>	r <- ask
>	j <- lift $ readIORef r
>	lift $ writeIORef r (j + 1)
>	return $ InFrame (- j * wordSize) 
