> module BuildTable (SymbolTable(..), buildTable) where


> import List(nub)

> import Misc(assert)
> import Syntax
> import SymbolTable

%---------------------------------------

> buildTable :: Program -> SymbolTable Type Type
> buildTable s = SymbolTable (mkTable s) Nothing

> class GivesSymbolTable s t where
>	mkTable :: s -> t


%---------------------------------------

> instance GivesSymbolTable Program [Class Type Type] where
>	mkTable (Program (MainClass nm _ _) class_decls) 
>	 = Class nm Nothing [] [Method mainLabel (T_Id "dummy type info") [] []]
>	 : map mkTable class_decls

"main" not callable, but it needs a frame later, so add it with fake data
note: String[] isn't a valid type, so no go... - type-checked prog can't use

> instance GivesSymbolTable ClassDecl (Class Type Type) where
>	mkTable (ClassDecl class_name superclass vars methods)
>	 = assert (unique $ map var_id vars) 
>		  ("Instance vars not unique for " ++ show class_name ++ ".")
>	 $ assert (unique $ map m_name methods) 
>		  ("Method names not unique for " ++ show class_name ++ ".")
>	 $ Class class_name superclass (map mkTable vars) (map mkTable methods)

> instance GivesSymbolTable MethodDecl (Method Type Type) where
>	mkTable (MethodDecl m_type m_name m_args decls body m_return)
>	 = assert (unique $ map var_id m_args) 
>		  ("Parameters not unique for " ++ show m_name ++ ".")
>	 $ assert (unique $ map var_id decls) 
>		  ("Local vars not unique for " ++ show m_name ++ ".")
>	 $ assert (unique $ map var_id $ m_args ++ decls) 
>		  ("Local vars shadow parameters in " ++ show m_name ++ ".")
>	 $ Method m_name m_type (map mkTable m_args) (map mkTable decls)

> instance GivesSymbolTable VarDecl (Var Type) where
>	mkTable (VarDecl var_type var_id) = Var var_id var_type

---
uniqueness test
 - did nub delete anything?

> unique :: Eq a => [a] -> Bool
> unique xs = nub xs == xs
