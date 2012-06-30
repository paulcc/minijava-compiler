> module Lexer (all_tokens, lexer, test_lexer, Token(..)) where

$Name:  $
$Header: /users/dcs0pcc/cvs-public/minijava/Lexer.lhs,v 1.4 2005/01/14 20:57:47 dcs0pcc Exp $

> import Char
> import Maybe (isJust, fromJust)
> import List  (nub, sortBy, isPrefixOf)
> import Misc

%-------------------------------------------------------------------------------

> data Token
>  = TokenEOF
>  | TokenFail String
>
>  | TokenBracket Char		-- () {} [] etc
>  | TokenOp String
>  | TokenInfixOp String

>  | TokenKeyword String
>  | TokenId String
>  | TokenLit String
>    deriving (Show, Eq)

%-------------------------------------------------------------------------------

> all_tokens :: String -> OkF [Token]
> all_tokens = error_free . do_until null lexer

> error_free ts
>  = case [ s | (TokenFail s) <- ts ] of
>	[]  -> Ok $ filter (/= TokenEOF) ts
>	s:_ -> Fail s

> do_until :: (a -> Bool) -> (a -> (b,a)) -> a -> [b]
> do_until p f a
>  | p a       = []
>  | otherwise = let (b,a') = f a in b : do_until p f a'

%-------------------------------------------------------------------------------

> lexer :: String -> (Token, String)
> lexer [] = (TokenEOF, [])

> lexer (c:cs) 
>  | isSpace c = lexer cs

> lexer ('/':'/':cs) 
>  = lexer $ dropWhile (/='\n') cs

> lexer s@('\'':_)
>  = case lex s of
>		[(c,rest)] -> (TokenLit c, rest)	-- NB 'c' is already a string
>		[]         -> (TokenFail "Bad char literal (incomplete?)",s)
>		ls         -> (TokenFail "Multiple lexes of string literal",s)

> lexer s@('"':_)
>  = case lex s of
>		[(str,rest)] -> (TokenLit $ show $ (init $ tail str :: String), rest)
>		[]           -> (TokenFail "Bad string literal (incomplete?)",s)
>		ls           -> (TokenFail "Multiple lexes of string literal",s)

> lexer (c:cs) 
>  | c `elem` brackets = (TokenBracket c, cs)
>   where
>		brackets = "(){}[]"

> lexer s@(c:cs)
>  | c `elem` symbol_chars && isJust match
>     = fromJust match
>    where
>		match = symbol_matches s

> lexer s@('`':c:cs)
>  | isAlpha c && isLower c
>     = case lex (c:cs) of
>         [(id,'`':rest)] -> (TokenInfixOp id, rest)
>         _               -> (TokenFail "error in lexing infix function op", s)

> lexer s@(c:cs)
>  | isDigit c 
>     = (TokenLit $ show (read digits :: Int), dropWhile isSpace not)
>    where
>		(digits, not) = span isDigit s

> lexer s
>  | null first
>     -- = (TokenFail $ "Didn't lex:" ++ s ++ error "\ncrashing\n", s)
>     = (TokenFail $ "Didn't lex:" ++ s, s)
>  | sop `isPrefixOf` s && (null after_sop || not (is_id_char $ head after_sop))
>     = (TokenKeyword "print", after_sop)
>  | first `elem` keywords 
>     = (TokenKeyword first, after)
>  | otherwise 
>     = (TokenId first, after)
>    where
>		sop = "System.out.println" 
>		after_sop = drop (length sop) s
>		(first,rest) = span is_id_char s
>		after = dropWhile isSpace $ drop (length first) s
>		is_id_char c = isAlphaNum c || c == '_' || c == '\''


%-------------------------------------------------------------------------------
Keywords

> keywords 
>  = words "class public static void main String extends return if else int boolean while length true false this new"


%-------------------------------------------------------------------------------
Symbols
 - starting point is list of possible combinations
 - want a greedy match on this.
 - fn given - not too efficient but it is simple - could use tree instead...

NOTE: removed this =<<  - happy isn't ok with mix-assoc levels

> symbols :: [String]
> symbols 
>  = words "&& < + - * , ; ! = ." 

> symbol_chars :: String
> symbol_chars = nub $ concat $ symbols

> symbol_matches :: String -> Maybe (Token,String)
> symbol_matches s 
>  = case (filter (`isPrefixOf` s) symbols) of
>		[] -> Nothing
>		ss -> Just $ 
>			  chop_off $ 
>			  head $
>			  sortBy increasing_length ss 
>    where
>		increasing_length a b = length b `compare` length a
>		chop_off sym = let n = length sym in (TokenOp sym, drop n s)

%-------------------------------------------------------------------------------

> test_lexer = putStr . unlines . map show . do_until null lexer

> t1 = test_lexer "while \"abc\" 1 2s a{ then  {} () ++ + == != else"

> tf n = do { l <- readFile n; test_lexer l }
