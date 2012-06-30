> module Printer (module Printer, pretty_print, pp) where

> import Text.PrettyPrint.HughesPJ 
> import PrintBasics 
> import Syntax 


%-------------------------------------------------------------------------------
Now consider each category in turn, saying how to treat each.

> instance PrettyPrintable Program where
>	pp (Program main classes) = pp main $$ pp classes

---

> instance PrettyPrintable MainClass where
>	pp (MainClass name pars body) 
>	 = text "class" <+> text name <+> char '{'
>	   $$ nest 3 
>	      (text ("public static void main (String[] " ++ pars ++ ") {")
>	       $$ nest 3 (pp body)
>	       $$ char '}'
>	      )
>	   $$ rbrace

---

> instance PrettyPrintable ClassDecl where
>	pp (ClassDecl name ext vars mthds)
>	 = text "class" <+> text name <+> extends_part <+> char '{'
>          $$ nest 3 (   vcat [ pp d <> char ';' | d <- vars ]
>                     $$ pp mthds)
>	   $$ char '}'
>	   where
>	      extends_part = case ext of Nothing -> empty
>	                                 Just id -> text "extends" <+> text id

---

> instance PrettyPrintable VarDecl where
>	pp (VarDecl typ id) = pp typ <+> text id 

---

> instance PrettyPrintable MethodDecl where
>	pp (MethodDecl typ name args decls body retval)
>	 = text "public" <+> pp typ <+> text name <+> args_list args 
>	   <+> char '{'
>          $$ nest 3 (   vcat [ pp d <> char ';' | d <- decls ]
>                     $$ pp body
>                     $$ text "return" <+> pp retval <+> char ';')
>	   $$ char '}'


---


> instance PrettyPrintable Type where
>	pp T_IntArray = text "int []"
>	pp T_Boolean  = text "boolean"
>	pp T_Int      = text "int"
>	pp (T_Id i)   = text i    



---

> instance PrettyPrintable Statement where
>	pp (S_Block ss) = pp ss

>	pp (S_If cond then_ else_) 
>	 = text "if" <+> parens (pp cond) <+> char '{'
>	   $$ nest 3 (pp then_)
>	   $$ char '}' <+> text "else" <+> char '{'
>	   $$ nest 3 (pp else_)
>	   $$ char '}' 

>	pp (S_While cond body) 
>	 = text "while" <+> parens (pp cond) <+> char '{'
>	   $$ nest 3 (pp body)
>	   $$ char '}' 

>	pp (S_Print e) = text "System.out.println" <> parens (pp e) <> char ';'

>	pp (S_Assign var val) 
>	 = text var <+> char '=' <+> pp val <> char ';'

>	pp (S_ArrayAssign var idx val) 
>	 = text var <+> char '[' <> pp idx <> char ']'
>	                                <+> char '=' <+> pp val <> char ';'

%-------------------------------------------------------------------------------
Expressions are a bit more interesting, because of P & A
 - technique: assign each op a level of precedence, from 0 up to highest
 - then add an argument to 'pp', which is the prec of the parent
 - we need ( ) if the operator's level is not higher than the current level
   (NB with spine trick, this catches same operator in contra-assoc posn)
 - then at each binary op use, collect all sub-exprs on the left or right 
   spine, depending on which way it associates (ie '+' is left spine)
 - these spine nodes can be laid out without parentheses

> instance PrettyPrintable Op where
> 	pp BoolAnd  = text "&&"
>	pp LessThan = text "<"
>	pp Add      = text "+"
>	pp Subtract = text "-"
>	pp Multiply = text "*"

> instance PrettyPrintable Exp where
>	pp e = pp (0::Int,e)		-- default start at zero (low) prec

> instance PrettyPrintable (Int,Exp) where
>	pp (_,E_false) = text "false"
>	pp (_,E_true)  = text "true"
>	pp (_,E_this)  = text "this"
>	pp (_,E_Id i)  = text i
>	pp (_,E_Int j) = text (show j)

>	pp (_,E_NewArray e)  = text "new int" <+> char '[' <> pp e <> char ']'
>	pp (_,E_NewObj   i)  = text "new" <+> text i <> text "()"

>	pp (_,E_Index v i) = pp v <> char '[' <> pp i <> char ']'
>	pp (_,Length e)    = pp e <> char '.' <> text "length"
>	-- pp (_,Call _ whom what args) = pp whom <> char '.' <> (text what <> args_list args)
>	pp (_,Call _ whom what args) = pp whom <> char '.' <> text what <> args_list args

>	pp (p, E_Not e) = let my_level = 1 + level Multiply 
>	                  in showParens (p > my_level) $ char '!' <> pp (my_level, e)

>	pp (p, e@(B_Op op l r))
>	 = let my_level = level op 
>	   in showParens (p >= my_level)
>	    $ foldr1 (\l r -> l <+> pp op <+> r) 
>	      [ pp (my_level, e) | e <- spine op e ] 

---

> level :: Op -> Int
> level BoolAnd  = 3
> level LessThan = 4		-- NB leave space for (==)
> level Add      = 6
> level Subtract = 6
> level Multiply = 7 

> spine :: Op -> Exp -> [Exp]
> spine BoolAnd  (B_Op op l r) | op == BoolAnd  = spine op l ++ [r]
> spine LessThan (B_Op op l r) | op == LessThan = spine op l ++ [r]
> spine Add      (B_Op op l r) | op == Add      = spine op l ++ [r]
> spine Subtract (B_Op op l r) | op == Subtract = spine op l ++ [r]
> spine Multiply (B_Op op l r) | op == Multiply = spine op l ++ [r]
> spine _        (B_Op op l r)                  = [l,r]
> spine _        e                              = [e]


%-------------------------------------------------------------------------------





> showParens    :: Bool -> Doc -> Doc
> showParens b p = if b then char '(' <> p <> char ')' else p

> args_list [] = text "()"
> args_list xs = sep $ zipWith (<+>) (char '(' : repeat (char ','))
>				     (map pp xs)
>	               ++ [char ')']
