> module Syntax where

> data Program 
>  = Program MainClass [ClassDecl]

> data MainClass
>  = MainClass { main_class_name :: Id
>              , pars_name :: Id
>              , main_body :: Statement }

> data ClassDecl
>  = ClassDecl { class_name :: Id
>              , extends    :: Maybe Id
>              , vars       :: [VarDecl]
>              , methods    :: [MethodDecl] }

> data VarDecl
>  = VarDecl { var_type :: Type, var_id :: Id }

> data MethodDecl
>  = MethodDecl { m_type   :: Type
>               , m_name   :: Id 
>               , m_args   :: [VarDecl]
>               , decls    :: [VarDecl]
>               , body     :: [Statement]
>               , m_return :: Exp }

> data Type
>  = T_IntArray
>  | T_Boolean
>  | T_Int
>  | T_Id Id
>    deriving (Eq, Show)

> data Statement
>  = S_Block       [Statement]
>  | S_If          { cond :: Exp, then_arm :: Statement, else_arm :: Statement }
>  | S_While       { cond :: Exp, while_body :: Statement }
>  | S_Print       Exp
>  | S_Assign	   { var :: Id,                   value :: Exp }
>  | S_ArrayAssign { var :: Id, arr_index :: Exp, value :: Exp }

> data Op
>  = BoolAnd | LessThan | Add | Subtract | Multiply deriving (Eq, Show)

> data Exp
>  = B_Op Op Exp Exp
>  | E_Index { array_exp, index_exp :: Exp }
>  | Length Exp
>  | Call { class_ :: Id, callee :: Exp, method :: Id, args :: [Exp] }
>  | E_Int Int
>  | E_false
>  | E_true
>  | E_Id Id
>  | E_this
>  | E_NewArray Exp
>  | E_NewObj   Id 
>  | E_Not Exp

> type Id = String
