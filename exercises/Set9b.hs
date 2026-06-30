module Set9b where

import Mooc.Todo

import Data.List



type Row   = Int
type Col   = Int
type Coord = (Row, Col)

nextRow :: Coord -> Coord
nextRow (i,j) = (i+1 , 1)

nextCol :: Coord -> Coord
nextCol (i,j) = (i,j+1 )


type Size = Int

prettyPrint :: Size -> [Coord] -> String
prettyPrint n ds =
    let initTable = replicate n $ replicate n '.'
        setQueen table (row, col) =
            take (row - 1) table ++
            [take (col - 1) (table !! (row - 1)) ++ ['Q'] ++
             drop col (table !! (row - 1))] ++
            drop row table
        table = foldl setQueen initTable ds
    in unlines table


sameRow :: Coord -> Coord -> Bool
sameRow (i,j) (k,l) = i == k

sameCol :: Coord -> Coord -> Bool
sameCol (i,j) (k,l) = j == l

sameDiag :: Coord -> Coord -> Bool
sameDiag (i,j) (k,l) = k - i == l- j

sameAntidiag :: Coord -> Coord -> Bool
sameAntidiag (i,j) (k,l) =  i - k == l - j


type Candidate = Coord
type Stack     = [Coord]

danger :: Candidate -> Stack -> Bool
danger s = any (\x -> sameCol x s || sameRow x s || sameAntidiag x s || sameDiag x s)



prettyPrint2 :: Size -> Stack -> String
prettyPrint2 n ss = unlines $ [[if (row,col ) `elem` ss then  'Q'  else  if danger (row,col) ss  then '#' else '.' | col <- [1..n ] ] | row <- [1..n]]


fixFirst :: Size -> Stack -> Maybe Stack
fixFirst n [] = Just [] 
fixFirst n (x@(i,j):xs) 
    | j >  n  = Nothing 
    |  not (danger x xs)  =  Just (x:xs )
    | otherwise = fixFirst n (nextCol x: xs )

continue :: Stack -> Stack
continue [] = [(1,1) ]
continue (x : xs ) =  nextRow x: x :xs 


backtrack :: Stack -> Stack
backtrack [] = []
backtrack [_] = []
backtrack (_ : b : xs) = nextCol b : xs 


step :: Size -> Stack -> Stack
step n s = case fixFirst n s of
    Just s' -> continue s'
    Nothing -> backtrack s

finish :: Size -> Stack -> Stack
finish n s 
    | length s <= n = finish n $ step n s
    | otherwise = tail s

solve :: Size -> Stack
solve n = finish n [(1,1)]
