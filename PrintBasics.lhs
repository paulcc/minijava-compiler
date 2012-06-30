> module PrintBasics where

> import Text.PrettyPrint.HughesPJ (Doc, render, ($$), empty)

%-------------------------------------------------------------------------------
We want to pretty-print at varying levels of syntax, so overload

> class PrettyPrintable a where
>	pp :: a -> Doc

---
useful instance
 - lists of pretty-printable things get horizontally stacked, by default

> instance PrettyPrintable a => PrettyPrintable [a] where
>	pp = foldr ($$) empty . map pp

---
Main entry-point 
 - convert object to String, by pretty-printing on default settings

> pretty_print :: PrettyPrintable a => a -> String
> pretty_print = render . pp 



---

> instance PrettyPrintable Doc where
>	pp = id
