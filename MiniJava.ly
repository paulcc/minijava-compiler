> {
> module MiniJava (parse) where

> import Misc
> import Syntax
> import Lexer
> }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Parser config

> %name parse_aux
> %monad { OkF }
>        { (>>=) :: OkF a -> (a -> OkF b) -> OkF b }
>        { return :: a -> OkF a}
> %tokentype { Token }

<should> %lexer { lexer } { TokenEOF }

> %token 
>       -- literals
>       INT             { TokenLit $$ }

>       -- identifiers
>       ID              { TokenId $$ }


>       -- key words
>	class		{ TokenKeyword "class" }
>	public		{ TokenKeyword "public" }
>	static		{ TokenKeyword "static" }
>	void		{ TokenKeyword "void" }
>	main		{ TokenKeyword "main" }
>	String		{ TokenKeyword "String" }
>	extends		{ TokenKeyword "extends" }
>	return		{ TokenKeyword "return" }
>	if		{ TokenKeyword "if" }
>	else		{ TokenKeyword "else" }
>	int		{ TokenKeyword "int" }
>	boolean		{ TokenKeyword "boolean" }
>	while		{ TokenKeyword "while" }
>	length		{ TokenKeyword "length" }
>	true		{ TokenKeyword "true" }
>	false		{ TokenKeyword "false" }
>	this		{ TokenKeyword "this" }
>	new		{ TokenKeyword "new" }
>	print		{ TokenKeyword "print" }

>       -- punctuation and symbols
>       '.'             { TokenOp "." }
>       '='             { TokenOp "=" }
>       ';'             { TokenOp ";" }
>       ','             { TokenOp "," }
>       '!'             { TokenOp "!" }

>       '&&'            { TokenOp "&&" }
>       '<'             { TokenOp "<" }
>       '+'             { TokenOp "+" }
>       '-'             { TokenOp "-" }
>       '*'             { TokenOp "*" }

>       -- bracketing
>       '('             { TokenBracket '(' }
>       ')'             { TokenBracket ')' }
>       '['             { TokenBracket '[' }
>       ']'             { TokenBracket ']' }
>       '{'             { TokenBracket '{' }
>       '}'             { TokenBracket '}' }



> %left '&&'
> %left '<'
> %left '+' '-' 
> %left '*'

> %%


> program :: {Program}
>  : MainClass ClassDecls	{ Program $1 $2 }

> ClassDecls :: {[ClassDecl]}
>  : 				{ [] }
>  | ClassDecl ClassDecls	{ $1 : $2 }

> MainClass :: {MainClass}
>  : class ID '{' public static void main '(' String '[' ']' ID ')' '{' Statement '}' '}'
>				{ MainClass $2 $12 $15 }

> ClassDecl :: {ClassDecl}
>  : class ID optExtends '{' VarDecls MethodDecls '}'
>				{ ClassDecl $2 $3 $5 $6 }

> optExtends :: {Maybe Id}
>  :				{ Nothing }
>  | extends ID 		{ Just $2 }


---
NOTE: had to change this to left-assoc to avoid S/R conflict

> VarDecls :: {[VarDecl]}
>  : VarDecls VarDecl		{ $1 ++ [$2] }
>  | 				{ [] }

> MethodDecls :: {[MethodDecl]}
>  : 				{ [] }
>  | MethodDecl MethodDecls	{ $1 : $2 }

> VarDecl :: {VarDecl}
>  : Type ID ';'		{ VarDecl $1 $2 }

> MethodDecl :: {MethodDecl}
>  : public Type ID '(' FormalList ')' '{' VarDecls Statements return Exp ';' '}'
>				{ MethodDecl $2 $3 $5 $8 $9 $11 }

> FormalList :: {[VarDecl]}
>  : Type ID FormalRest		{ VarDecl $1 $2 : $3 }
>  | 				{ [] }
> FormalRest :: {[VarDecl]}
>  : ',' Type ID FormalRest	{ VarDecl $2 $3 : $4 }
>  | 				{ [] }

> Type :: {Type}
>  : int '[' ']'		{ T_IntArray }
>  | boolean			{ T_Boolean }
>  | int			{ T_Int }
>  | ID				{ T_Id $1 }

> Statement :: {Statement}
>  : '{' Statements '}'		{ S_Block $2 }
>  | if '(' Exp ')' Statement else Statement
>				{ S_If $3 $5 $7 }
>  | while '(' Exp ')' Statement
>				{ S_While $3 $5 }

>  | print '(' Exp ')' ';'	{ S_Print $3 }
>	-- NB this 'print' is abbreviation of token

>  | ID '=' Exp ';'		{ S_Assign $1 $3 }
>  | ID '[' Exp ']' '=' Exp ';' { S_ArrayAssign $1 $3 $6 }

> Statements :: {[Statement]}
>  : Statement Statements	{ $1 : $2 }
>  | 				{ [] }


> ExpList :: {[Exp]}
>  : 				{ [] }
>  | Exp ExpRest		{ $1 : $2 }

> ExpRest :: {[Exp]}
>  : 				{ [] }
>  | ',' Exp ExpRest		{ $2 : $3 }


> Exp :: {Exp}
>  : UnaryExp			{ $1 }
>  | Exp '&&' Exp		{ B_Op BoolAnd  $1 $3 }
>  | Exp '<' Exp		{ B_Op LessThan $1 $3 }
>  | Exp '+' Exp		{ B_Op Add      $1 $3 }
>  | Exp '-' Exp		{ B_Op Subtract $1 $3 }
>  | Exp '*' Exp		{ B_Op Multiply $1 $3 }

> UnaryExp :: {Exp}
>  : PrimaryExp 		{ $1 }
>  | '!' UnaryExp		{ E_Not $2 }

> PrimaryExp :: {Exp}
>  : NoNewArrayPrimaryExp 	{ $1 }
>  | ArrayCreationExp 		{ $1 } 

> ArrayCreationExp :: {Exp}
>  : new int '[' Exp ']' 	{ E_NewArray $4 }

> NoNewArrayPrimaryExp :: {Exp}
>  : INT			{ E_Int (read $1) }
>  | ID				{ E_Id $1 }
>  | true			{ E_true }
>  | false			{ E_false }
>  | this			{ E_this }
>  | PrimaryExp '.' ID '(' ExpList ')' 
>				{ Call "" $1 $3 $5 }
>  | PrimaryExp '.' length	{ Length $1 }
>  | NoNewArrayPrimaryExp '[' Exp ']'	
>				{ E_Index $1 $3 }
>  | new ID '(' ')'		{ E_NewObj $2 } 
>  | '(' Exp ')'		{ $2 }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Any other code

> {

> happyError ts
>  = fail ("Parse error, tokens left =\n" ++ unlines (map show ts))

%-------------------------------------------------------------------------------

---
`parse'
  - calls lexer, and then parses if result is ok
    - NB error checking is done in the monad

> parse :: String -> OkF Program
> parse s
>  = do
>       ts <- all_tokens s
>       parse_aux ts


> }

