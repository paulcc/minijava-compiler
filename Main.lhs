> import Text.PrettyPrint.HughesPJ
> import Misc(OkF(..))
> import System.IO.Unsafe(unsafePerformIO)
> import System(getArgs)

> import Lexer(all_tokens)
> import MiniJava	-- syntax and parser
> import Printer
> import Syntax

> import BuildTable	-- type checking and symbol table
> import TypeCheck
> import SymbolTable

> import Translate	-- semantics
> import Canonicalise
> import PrintIR
> import FormTraces

> import ProduceC_Code	-- back end

%---------------------------------------

> -- tf = "f.java"
> -- tf = "t.java"
> tf = "QuickSort.java"
> -- tf = "BinaryTree.java"
> -- tf = "Factorial.java"

%---------------------------------------

> compile f
>  = do
>	let base = basename f
>	let save_trace s = writeFile (base ++ "." ++ s)
>	prog <- readFile f

>	case all_tokens prog of
>		  Ok ts  -> save_trace "1-lex" $ unlines $ map show ts
>	          Fail m -> error $ "Failed lexing: " ++ m

>	tree <- case parse prog of
>		  Ok t -> return t
>	          Fail m -> error $ "Failed Parsing: " ++ m
>	save_trace "2-tree" $ pretty_print tree

>	let table = buildTable tree
>	save_trace "3-table" $ pretty_print table

>	case classesNonCyclic table of
>	  True  -> return ()
>	  False -> error $ "Cycles in subclassing"

>	tree' <- case type_check tree table of
>			Just t  -> return t 
>			Nothing -> error "didn't type check" 

>	(labels, trs, newtable) <- trans table tree'
>	let o = unlines [ pretty_print $ text (snd l) $$ nest 2 (pp ss)
>                       | MethodTranslation l _ ss <- trs ]
>	save_trace "4-trans" o

>	ls <- mapM linearize trs
>	let o = unlines [ pretty_print $ text (snd l) $$ nest 2 (vcat $ map pp ss) 
>                       | MethodTranslation l _ ss <- ls ]
>	save_trace "5-lin" o

>	fs_os <- mapM (do_traces labels) ls
>	let (fs,os) = unzip fs_os
>	save_trace "6-traces" $ unlines os

>	let (externs,tables) = produceTables newtable
>	cs <- mapM generate fs
>	writeFile (basename f ++ ".c")
>	  $ unlines [ divide ++ l | l <- include : externs : cs ++ [tables] ]

> divide = "\n\n" ++ "//" ++ replicate 78 '-' ++ "\n"
> include = "#include \"rts.h\""
> basename = reverse . dropWhile (=='.') . dropWhile (/='.') . reverse

> main 
>  = do
>	as <- getArgs
>	if length as /= 1 
>	  then error "Just give one filename!"
>	  else compile (head as)



