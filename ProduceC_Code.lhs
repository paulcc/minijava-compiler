> module ProduceC_Code (produceTables, generate) where

> import Data.IORef
> import Text.PrettyPrint.HughesPJ
> import List(nubBy,sortBy)

> import IR
> import PrintIR
> import TransBasics
> import SymbolTable

Input = frame info, plus [[block]]

> produceTables :: AllocTable SymbolTable -> (String, String)
> produceTables s 
>  = (unlines es, unlines ts)
>    where
>	(es, ts) = unzip $ map (classTable s . class_nm) $ info s

> classTable :: AllocTable SymbolTable -> Label -> (String,String)
> classTable s c0
>  = ( "extern Ptr jump" ++ c0 ++ "[];"
>    , render
>    $ text ("static Ptr jump" ++ c0 ++ "[] =") 
>      <+> (vcat $ zipWith (<+>) (text "{" : repeat comma) (map text ptrs))
>          $$ text "};"
>    )
>    where
>	indx = fst . fst . method_info	
>	name = snd . fst . method_info
>	ptrs = [ "&" ++ name m
>	       | let cs = class_and_parents s c0
>	       , let ms = nubBy (\a b -> indx a == indx b) 
>	                        $ concatMap class_mthds cs 
>	       , m <- sortBy (\a b -> indx a `compare` indx b) ms
>	       ]



%---------------------------------------


> generate :: MethodTranslation [Stm] -> IO String
> generate (MethodTranslation name frame ss)
>  = do
>	frame_size <- readIORef frame
>	return $ pretty_print (function name frame_size ss)

> indent = 4 :: Int


> function (ref,name) size ss
>  = text "int" <+> text name <+> text "(int *fp) {" 
>    $$ nest indent ( text "grab" <> parens (text $ show size) <> semi
>		      $$ vcat (map gen ss) 
>		      $$ gen (LABEL $ name ++ "_exit")
>		      $$ text "pop" <> parens (text $ show size) <> semi
>		      $$ text "return" <+> text "retval" <>  semi
>		      )
>    $$ text "}"

NB has to exit via single point, to do pops properly.


> class CodeGen a where
>	gen :: a -> Doc 

> instance CodeGen Stm where
>	gen (EXP e) = gen e <> semi
>	gen (LABEL l) = text (l ++ ":") 

>	gen (JUMP j _) 
>	 = text "goto" <+> gen j <> semi

>	gen (CJUMP relop jleft jright iftrue iffalse)
>	 = text "if" <+> parens (gen jleft <+> pp relop <+> gen jright) 
>	   <+> text ("goto " ++ iftrue ++ ";")

<>	   --$$ nest 2 (text ("else { goto " ++ iffalse ++ "; }"))
<> 	   -- not needed - should be in this form already


>	gen (MOVE d@TEMP{} (CALL (NAME "malloc") [a]))	-- malloc call
>	 = gen d <+> text "=" <+> text "(int)malloc" <> parens (gen a) <> semi

>	gen (MOVE d@TEMP{} (CALL (NAME "obj_alloc") [a,b]))	-- malloc call
>	 = gen d <+> text "=" <+> text "obj_alloc" 
>	                       <> parens (gen a <> comma <> gen b) <> semi

>	gen (MOVE d@TEMP{} (CALL (NAME "print") [a]))	-- malloc call
>	 = gen d <+> text "=" <+> 
>			text "printf(\"%d\\n\"," <> gen a <> text ")" <> semi

>	gen (MOVE d@TEMP{} (CALL (NAME "crash_array") []))-- array over-run
>	 = text "crash_array();"

>	gen (MOVE d@TEMP{} (CALL func args))	-- canonical fn call
> 	 = vcat [ text "push" <> parens (gen a) <> semi | a <- reverse args ]
>	   $$ 
>	   gen d <+> text "=" <+> call func <> semi
>	   $$ 
>	   text "pop" <> parens (text $ show $ length args) <> semi
>	   where
>		call (NAME n)  = text n <> parens (text "sp")
>		call (LCONST n j)
>		 = text $ "DEREF(/*" ++ n ++ "*/" ++ show j ++ ",sp)"
>		-- call (CONST j) = text $ "DEREF(" ++ show j ++ ",sp)"

>	gen (MOVE d s) 				-- any other move
>	 = gen d <+> text "=" <+> gen s <> semi



> instance CodeGen Exp where
>	gen (CONST v) = text $ show v
>	gen (NAME n)  = text n
>	gen (TEMP (InFrame o)) = text "fp[" <> text (show o) <> text "]"
>	gen (TEMP (Extra n)) = text n
>	gen (MEM e) = text "*(int *)" <> parens (gen e)
>	gen (BINOP binop left right) 
>	 = parens $ gen left <+> pp binop <+> gen right

