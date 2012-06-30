> module PrintIR (module PrintIR, pretty_print, pp) where

> import Text.PrettyPrint.HughesPJ
> import PrintBasics

> import IR


> instance PrettyPrintable Stm where
>	pp (MOVE e@ESEQ{} src) = text "MOVE" <+> (pp e $$ pp src)
>	pp (MOVE dst src) = text "MOVE" <+> sep [pp dst, pp src]
>	pp (EXP exp) = text "EXP" <+> pp exp
>	pp (SEQ sleft sright) = pp sleft $$ pp sright
>	pp (LABEL slabel) = text "LABEL" <+> text slabel
>	pp (JUMP  jexp  targets) = text "JUMP" <+> pp jexp
>	pp (CJUMP relop jleft jright iftrue iffalse)
>	 = text "CJUMP" <+> parens (pp jleft <+> pp relop <+> pp jright) 
>		<+> text iftrue <+> text "else" <+> text iffalse

> instance PrettyPrintable BinOp where
>	pp ADD       = text "+"
>	pp TIMES     = text "*"
>	pp SUBTRACT  = text "-"
>	pp (TEST op) = pp op

> instance PrettyPrintable RelOp where
>	pp LT_ = text "<"
>	pp LE_ = text "<="
>	pp EQ_ = text "=="
>	pp NE_ = text "!="
>	pp GE_ = text ">="
>	pp GT_ = text ">"

> instance PrettyPrintable Ordering where
>	pp LT = text "<"
>	pp EQ = text "=="
>	pp GT = text ">"

> instance PrettyPrintable Exp where
>	pp (CONST value) = text (show value)
>	pp (LCONST n v)  = text ("/*" ++ n ++ "*/" ++ show v)
>	pp (NAME  label) = text label
>	pp (TEMP  temp)  = pp temp
>	pp (MEM   exp)   = parens $ text "MEM" <+> pp exp
>	pp (BINOP binop left right) 
>	 = parens $ pp left <+> pp binop <+> pp right

>	pp (CALL  func []) 
>	 = text "<<" <> pp func <> text ">>" <> text "()"
>	pp (CALL  func args) 
>	 = pp func <> parens (foldr1 (\l r -> l <> comma <+> r) $ map pp args)

>	pp (ESEQ  stm eexp)
>	 = parens $ text "ESEQ" $$ nest 4 (pp stm) $$ nest 2 (pp eexp)

