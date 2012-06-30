> module FormTraces where

> import Control.Monad.Reader
> import Text.PrettyPrint.HughesPJ
> import List((\\), nub)

> import TransBasics
> import IR
> import PrintIR



%-------------------------------------------------------------------------------

> type Block = (Label,([Stm],Stm))

> blocks :: [Stm] -> ReaderT LabelSupply IO [Block]

> blocks [] 
>  = return []

> blocks (LABEL l : ss)
>  | not (null rest) && isJump end
>  = do
>	let b1 = (l, (body, end))
>	bs <- blocks (tail rest)
>	return (b1 : bs)

>  | not (null rest) && isLabel end
>  = do
>	let b1 = (l, (body, JUMP (NAME $ fromLabel end) [fromLabel end]))
>	bs <- blocks rest
>	return (b1 : bs)

Disabled - no jumpless blocks should be formed
<>  | null rest
<>  = do
<>	return $ [(l, (body, JUMP (NAME "done") ["done"]))]

>  | otherwise 
>  = error "oops"
>    where
>	(body, rest) = break is_end ss
>	end = head rest

> blocks ss
>  = do
>	ls <- ask
>	l  <- lift ls
>	blocks (LABEL l : ss)

> isLabel (LABEL _) = True
> isLabel _         = False

> fromLabel (LABEL l) = l

> isJump CJUMP{} = True
> isJump JUMP{}  = True
> isJump _       = False

> is_end s = isLabel s || isJump s

%---------------------------------------

traces forming

follow blocks, 

> traces :: [Block] -> [[Block]]
> traces []
>  = []

> traces (b1@(l, (b,j)) : bs)
>  = case pick_out (jumpLabels j) bs of
>	[]            -> [b1] : traces bs
>	(b2,rest) : _ -> glue b1 (traces (b2:rest))
>    where
>	glue x (a:as) = (x:a):as
>	glue x []     = [[x]]

> pick_out :: Eq a => [a] -> [(a,b)] -> [((a,b),[(a,b)])]
> pick_out ts lxs 
>  = [ ((t,x), rest t) | t <- ts, Just x <- [lookup t lxs ] ]
>    where
>	rest t = [ (l,x) | (l,x) <- lxs, l /= t ]

> jumpLabels j@JUMP{}  = targets j
> jumpLabels j@CJUMP{} = [iffalse j, iftrue j]
>  -- NB order the false label first, heuristically

%---------------------------------------

> showB :: Block -> Doc
> showB (l, (b,j))
>  = text ("---" ++ l ++ "---") $$ pp (LABEL l : b ++ [j])

> showT :: Int -> [Block] -> Doc 
> showT j bs
>  = vcat [ text (show j ++ "." ++ show i ++ ":") <+> showB b 
>	  | (i,b) <- zip [1..] bs ]
>    $$ empty

> do_traces :: LabelSupply -> MethodTranslation [Stm] 
>					-> IO (MethodTranslation [Stm], String)
> do_traces ls (MethodTranslation l f ss)
>  = do
>	bs <- runReaderT (blocks ss) ls
>	let ts = traces bs
>	let jump_targets = [ l | t <- ts, (_,(_,j)) <- t, l <- jumpLabels j ]
>	let multi_targets = nub $ jump_targets \\ nub jump_targets
>	let ts' = map (fixJumps multi_targets) ts
>	return ( MethodTranslation l f 
>	       $ concat [ LABEL l : b ++ [j] | t <- ts', (l,(b,j)) <- t ]
>	       , pretty_print $ zipWith showT [1..] ts'
>	       )

%---------------------------------------
Squeeze block if jump is a no-op 
 - NB we check for this being a unique label. 

> fixJumps ns (b1@(l,(body1,JUMP (NAME m) _)) : b2@(n, (body2,j)) : bs)
>  | m == n && m `notElem` ns
>  = fixJumps ns $ (l, (body1 ++ body2, j)) : bs

---
Tweak CJUMPs to be in right format

> fixJumps ns ( b1@(l,(body1,CJUMP op left right iftrue iffalse))
>             : b2@(n, _)
>             : bs)
>  | n == iffalse 			-- want this, so no-op
>  = b1 : fixJumps ns (b2 : bs)

>  | n == iftrue 			-- negate relop and swap labels
>  = (l, (body1, CJUMP (negated op) left right iffalse iftrue))
>    : fixJumps ns (b2 : bs)
>    where
>	negated EQ_ = NE_
>	negated LT_ = GE_

> fixJumps ns ((l,(body,j@CJUMP{})) : bs)
>  = (l,         (body, j{iffalse=new_false})) 
>  : (new_false, ([],   JUMP (NAME (iffalse j)) [iffalse j]))
>  : fixJumps ns bs
>    where
>	new_false = l ++ "_f"	-- reuse the block's label

NOTE: this recursion is correct - bs won't be headed by the false label, 
since the earlier case will have caught this. 

---
easy cases

> fixJumps ns (b:bs) = b : fixJumps ns bs
> fixJumps ns []     = []


