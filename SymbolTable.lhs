
> module SymbolTable where

follow type str but give nice interface

overload per contents

> --import Trace
> import Monad(MonadPlus(..))
> import Text.PrettyPrint.HughesPJ (($$), (<+>), (<>), vcat, text, nest, parens, empty)

> import Syntax(Type(..), Id(..))

> import PrintBasics

%---------------------------------------

> mainLabel :: String
> mainLabel = "main_"   -- special name

%---------------------------------------

> data SymbolTable var_info method_info
>  = SymbolTable { info :: [Class var_info method_info]
>                , cur_place :: Maybe (Id, Maybe Id) }

> data Class var_info method_info
>  = Class { class_nm :: Id 
>          , superclass :: Maybe Id
>          , class_vars :: [Var var_info] 
>          , class_mthds :: [Method var_info method_info]
>          }

> data Var var_info
>  = Var Id var_info


> data Method var_info method_info
>  = Method { name :: Id 
>           , method_info :: method_info
>           , params :: [Var var_info]
>           , locals :: [Var var_info]
>           }

%---------------------------------------

<> instance PrettyPrintable Type where
<>	pp ty = text $ show ty

> instance PrettyPrintable a => PrettyPrintable (Var a) where
>	pp (Var id info) = text id <+> pp info

> instance (PrettyPrintable a, PrettyPrintable b)
>			 => PrettyPrintable (Method a b) where
>	pp m = (text "Method" <+> text (name m))
>	       <+> vcat [parens $ text "type: " <+> pp (method_info m)
>                       , text "params:"
>                       , nest 2 $ pp $ params m
>                       , text "locals:"
>                       , nest 2 $ pp $ locals m]

> instance (PrettyPrintable a, PrettyPrintable b)
>			 => PrettyPrintable (Class a b) where
>	pp (Class nm sc vs ms)
>	 = (text "Class" <+> text nm <> superclass sc)
>	       <+> vcat [ text "vars:"
>                       , nest 2 $ pp vs
>                       , text "methods:"
>                       , nest 2 $ pp ms]
>	    where
>		superclass Nothing  = empty
>		superclass (Just c) = text $ " <= " ++ c

> instance (PrettyPrintable a, PrettyPrintable b)
>			 => PrettyPrintable (SymbolTable a b) where
>	pp (SymbolTable is place)
>	 = vcat [ text $ "Symbol Table (at " ++ show place ++ ")"
>               , pp is]


%---------------------------------------

> t1 :: SymbolTable Int Int
> t1
>  = SymbolTable [Class "x" Nothing [Var "a" 1] [Method "f" 2 [Var "b" 3] []]]
>                Nothing
 
> t2 :: SymbolTable Int Int
> t2
>  = SymbolTable [Class "x" (Just "y") [Var "a" 1] [Method "f" 2 [Var "b" 3] []]
>                ,Class "y" Nothing    [Var "x" 1] [Method "g" 2 [Var "b" 3] []]
>                ]
>                (Just ("x", Nothing))

> t2x v = look t2 v :: Maybe (Var Int)

%---------------------------------------

want
 * name str, but differentiating what info stored for each thing
    -> different for vars (names) and methods
 * could use Either - but we know that it is separate for  


%---------------------------------------
changing current scope

> setClass :: Id -> SymbolTable v m -> SymbolTable v m
> setClass c st 
>  = st {cur_place = Just (c, Nothing)}

> getClass :: SymbolTable v m -> Maybe Id
> getClass st = fmap fst $ cur_place st


> setMethod :: Id -> SymbolTable v m -> SymbolTable v m
> setMethod m st@(SymbolTable{cur_place=Just (c,_)})
>  = st {cur_place = Just (c, Just m)} 
> setMethod m _  
>  = error $ "need to set class before setting method: " ++ show m

> getMethod :: SymbolTable v m -> Id
> getMethod st
>  = case cur_place st of
>	Just (c, Just m) -> m


%---------------------------------------
Finding things

---
Using CtxtItems type to get proper sequence in lookups
 - :> represents order of blocks to try, and inside each block we have
   to look from the end (ie from the most recent declared)

> data CtxtItems a
>  = Decls [a]			-- in time-decl order, and should be reversed
>  | CtxtItems a :> CtxtItems a	-- sequence of such items, arbitrary nesting

> findInList :: (a -> Bool) -> CtxtItems a -> Maybe a
> findInList tst (Decls xs)
>  = case [ x | x <- reverse xs, tst x ] of 
>                   []  -> Nothing
>                   [x] -> Just x
>                   _   -> error $ "Multiple declarations: " ++ show (map tst $ reverse xs)
>	-- NOTE: using reverse, since most recent is the correct one
> findInList tst (fst :> snd) 
>  = findInList tst fst `mplus` findInList tst snd

---

> class_and_parents :: SymbolTable v m -> Id -> [Class v m]
> class_and_parents s n
>  = case look s n of
>	Nothing -> []
>	Just c  -> c : case superclass c of Nothing -> []
>	                                    Just c' -> class_and_parents s c'

> classSize :: Id -> SymbolTable v m -> Int
> classSize i st
>  = sum [ length $ class_vars c | c <- class_and_parents st i ]

---

> classesNonCyclic :: SymbolTable v m -> Bool
> classesNonCyclic st
>  = and [ no_cycle (class_nm c) | c <- info st ]
>    where
>	no_cycle c = c `notElem` parents c
>	parents c  = map class_nm $ tail $ class_and_parents st c


%---------------------------------------
How to look up Ids in "st" to get an "i"


> class Tabular st i where
>     look :: st -> Id -> Maybe i


> instance Tabular (SymbolTable v m) (Class v m) where  
>     look (SymbolTable cs _) n
>      = findInList (\c -> class_nm c == n) $ Decls cs 

> instance Tabular (SymbolTable v m) (Method v m) where  
>     look (SymbolTable cs Nothing) n
>      = Nothing
>     look s@(SymbolTable cs (Just (cn, _))) n
>      = do 
>           let cs = class_and_parents s cn
>	    findInList (\m -> name m == n) 
>		$ foldr1 (:>) $ map (Decls. class_mthds) cs

> instance Tabular (SymbolTable v m) (Var v) where
>	--look (SymbolTable cs Nothing) n
>	-- = Nothing

>	look s@(SymbolTable cs (Just (cn, Nothing))) n		-- not in mthd
>	 = do 
>           let cs = class_and_parents s cn
>           findInList (\(Var m _) -> m == n) 
>		$ foldr1 (:>) $ map (Decls. class_vars) cs

>	look s@(SymbolTable (cs :: [Class v m]) (Just (cn, Just mn))) n
>	 = do 
>           let cs = class_and_parents s cn
>	    (m :: Method v m) <- look s mn
>	    findInList (\(Var m _) -> m == n) 
>		$ Decls (locals m) 
>		  :> Decls (params m)
>		  :> foldr1 (:>) [ Decls $ class_vars c | c <- cs ]

