> module Temp (module Temp, Id(..)) where

> import Text.PrettyPrint.HughesPJ(text, parens, (<>))
> import PrintBasics
> import Syntax (Id(..))

> type Label = String

> data Temp
>  = InFrame { offset :: Int }
>  | InReg RegName 
>  | Extra Id
>    deriving Eq

> data RegName = RegName deriving (Show, Eq)

> instance PrettyPrintable Temp where
>	pp (InFrame o) = text "Fr" <> parens (text $ show o)
>	pp (InReg n)   = text "REG" <> error "NYI"
>	pp (Extra id)  = text id
