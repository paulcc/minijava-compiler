> module IR (module IR, Label(..), Temp(..)) where

> -- import Syntax(Id(..))
> import Temp


> data Stm
>  = MOVE  { dst :: Exp, src :: Exp }
>  | EXP   Exp 
>  | JUMP  { jexp :: Exp, targets :: [Label] }
>  | CJUMP { relop :: RelOp, jleft :: Exp, jright :: Exp
>          , iftrue :: Label, iffalse :: Label }
>  | SEQ { sleft :: Stm, sright :: Stm }
>  | LABEL { slabel :: Label }

> data BinOp = ADD | TIMES | SUBTRACT | TEST Ordering 
> data RelOp = LT_ | LE_ | EQ_ | NE_ | GE_ | GT_ 

> data Exp
>  = CONST { value :: Int }
>  | LCONST { label :: Label, value :: Int }	-- for jump entries
>  | NAME  { label :: Label }
>  | TEMP  { temp  :: Temp }
>  | BINOP { binop :: BinOp, left :: Exp, right :: Exp }
>  | MEM   Exp 
>  | CALL  { func :: Exp, args :: [Exp] }
>  | ESEQ  { stm :: Stm, eexp :: Exp }

%---------------------------------------
Abbreviations

> null_stm :: Stm
> null_stm = EXP (CONST 0)	-- dummy

> stms :: [Stm] -> Stm		-- list to `tree'
> stms [] = null_stm
> stms xs = foldr1 SEQ xs

> falseIR = CONST 0	:: Exp
> trueIR  = CONST 1	:: Exp

> jump :: Label -> Stm
> jump l = JUMP (NAME l) [l]

> toSEQ :: [Stm] -> Stm
> toSEQ [] = null_stm
> toSEQ ss = foldr1 SEQ ss

> deSEQ :: Stm -> [Stm]
> deSEQ (SEQ l r) = deSEQ l ++ deSEQ r
> deSEQ s         = [s]

