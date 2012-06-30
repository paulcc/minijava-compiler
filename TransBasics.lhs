> module TransBasics where

> import Data.IORef
> import Control.Monad.Reader

> import Temp
> import SymbolTable
> import IR(Exp(..), Stm)

> wordSize = 1 :: Int 	
>  -- this is because I'm using Int arrays underneath

> type AllocTable t = t Exp (MethodLabel, IORef Frame)

> type MethodLabel = (Int,Label)	-- full name and jump table offset
> type Frame       = Int		-- number of vars used

----

> data MethodTranslation s
>  = MethodTranslation MethodLabel (IORef Frame) s


----

> type M a = ReaderT (LabelSupply, AllocTable SymbolTable) IO a

%---------------------------------------

> type LabelSupply = IO Label

> newLabelSupply :: IO LabelSupply
> newLabelSupply
>  = do
>	r <- newIORef 0
>	return (newLabel r)

> getNewLabel :: M Label
> getNewLabel
>  = do
>	(ls, _) <- ask
>	l <- lift ls
>	return l

> newLabel :: IORef Int -> LabelSupply
> newLabel r
>  = do
>	j <- readIORef r
>	writeIORef r (j + 1)
>	return $ "L_" ++ show j

%---------------------------------------

> newTemp :: M Temp
> newTemp
>  = do
>	(_,t) <- ask
>	let m = getMethod t
>	(mi :: AllocTable Method) <- look_ m 
>	let r = snd $ method_info mi
>	j <- lift $ readIORef r
>	lift $ writeIORef r (j + 1)
>	return $ InFrame (- j * wordSize)

<>	return $ Extra $ "zz_" ++ show j 


> -- look_ :: Tabular (AllocTable SymbolTable) i => Id -> M i
> -- ghc objects to this - to follow up some time
> look_ n
>  = do
>	(_,t) <- ask
> 	case look t n of
>	  Just i  -> return i
>	  Nothing -> error $ "Couldn't find: " ++ n

> getVar :: Id -> M IR.Exp
> getVar n
>  = do
>	Var v t <- look_ n
>	return t

