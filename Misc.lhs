> module Misc where

> --import Trace(trace)
> import Control.Exception(Exception(..), throw)


%-------------------------------------------------------------------------------
A type for representing errors.

> data OkF a = Ok a | Fail String deriving Show

> instance Functor OkF where
>	fmap f (Ok a)   = Ok (f a)
>	fmap f (Fail s) = Fail s

> instance Monad OkF where
>	return = Ok
>	fail = Fail
>	(Ok a)   >>= k = k a
>	(Fail s) >>= k = Fail s


%-------------------------------------------------------------------------------
A type for handling updateable state

> newtype ST s a = ST (s -> (a,s))

> instance Functor (ST s) where
>	fmap f (ST sf) = ST $ \s -> case (sf s) of (a, s2) -> (f a, s2) 

> instance Monad (ST s) where
>	return a = ST $ \s -> (a, s)
>	(ST sf) >>= k = ST $ \s -> let (a,s2) = sf s 
>				   in case (k a) of ST sf2 -> sf2 s2

> runST :: s -> ST s a -> (a,s)
> runST s (ST sf) = sf s

> getST :: ST s s 
> getST = ST $ \s -> (s,s)

> setST :: s -> ST s ()
> setST s = ST $ \_ -> ((), s)

---
simple assertion facility

> assert True  m x = x
> assert False m _ = throw (AssertionFailed m)

> assert_ :: Monad m => Bool -> String -> m ()
> assert_ b m = assert b m $ return ()

