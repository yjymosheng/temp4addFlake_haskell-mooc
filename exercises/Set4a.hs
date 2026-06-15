-- Exercise set 4a:
-- 练习集 4a：
--
--  * using type classes
--  * 使用类型类
--  * working with lists
--  * 处理列表
--
-- Type classes you'll need
-- 你需要的类型类
--  * Eq
--  * Eq
--  * Ord
--  * Ord
--  * Num
--  * Num
--  * Fractional
--  * Fractional
--
-- Useful functions:
-- 有用的函数：
--  * maximum
--  * maximum
--  * minimum
--  * minimum
--  * sort
--  * sort

module Set4a where

import Mooc.Todo
import Data.List
import Data.Ord
import qualified Data.Map as Map
import Data.Array

------------------------------------------------------------------------------
-- Ex 1: implement the function allEqual which returns True if all
-- 练习1：实现函数 allEqual，如果列表中所有
-- values in the list are equal.
-- 值都相等则返回 True。
--
-- Examples:
-- 示例：
--   allEqual [] ==> True
--   allEqual [] ==> True
--   allEqual [1,2,3] ==> False
--   allEqual [1,2,3] ==> False
--   allEqual [1,1,1] ==> True
--   allEqual [1,1,1] ==> True
--
-- PS. check out the error message you get with your implementation if
-- 附：看看你的实现会得到什么错误信息，如果你
-- you remove the Eq a => constraint from the type!
-- 从类型中移除了 Eq a => 约束的话！

allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual (x:xs) = go xs  x
    where
        go [] _ = True
        go (a:as) tmp = a== tmp  && go as a



------------------------------------------------------------------------------
-- Ex 2: implement the function distinct which returns True if all
-- 练习2：实现函数 distinct，如果列表中所有
-- values in a list are different.
-- 值都不同则返回 True。
--
-- Hint: a certain function from the lecture material can make this
-- 提示：课程材料中的某个函数可以让这
-- really easy for you.
-- 变得非常简单。
--
-- Examples:
-- 示例：
--   distinct [] ==> True
--   distinct [] ==> True
--   distinct [1,1,2] ==> False
--   distinct [1,1,2] ==> False
--   distinct [1,2] ==> True
--   distinct [1,2] ==> True

distinct :: Eq a => [a] -> Bool
distinct [] =  True
distinct (x:xs ) = notElem x xs  && distinct xs


------------------------------------------------------------------------------
-- Ex 3: implement the function middle that returns the middle value
-- 练习3：实现函数 middle，返回三个参数中的中间值
-- (not the smallest or the largest) out of its three arguments.
-- （不是最小值也不是最大值）。
--
-- The function should work on all types in the Ord class. Give it a
-- 该函数应该适用于 Ord 类中的所有类型。给它一个
-- suitable type signature.
-- 合适的类型签名。
--
-- Examples:
-- 示例：
--   middle 'b' 'a' 'c'  ==> 'b'
--   middle 'b' 'a' 'c'  ==> 'b'
--   middle 1 7 3        ==> 3
--   middle 1 7 3        ==> 3
middle :: Ord a => a -> a -> a -> a
middle a b c = max (  min a b   ) ( min ( max a b )  c  )

------------------------------------------------------------------------------
-- Ex 4: return the range of an input list, that is, the difference
-- 练习4：返回输入列表的极差，即
-- between the smallest and the largest element.
-- 最小元素和最大元素之间的差值。
--
-- Your function should work on all suitable types, like Float and
-- 你的函数应该适用于所有合适的类型，如 Float 和
-- Int. You'll need to add _class constraints_ to the type of range.
-- Int。你需要在 range 的类型中添加_类约束_。
--
-- It's fine if your function doesn't work for empty inputs.
-- 如果你的函数不能处理空输入也没关系。
--
-- Examples:
-- 示例：
--   rangeOf [4,2,1,3]          ==> 3
--   rangeOf [4,2,1,3]          ==> 3
--   rangeOf [1.5,1.0,1.1,1.2]  ==> 0.5
--   rangeOf [1.5,1.0,1.1,1.2]  ==> 0.5

rangeOf :: (Num a, Ord a) => [a] -> a
rangeOf xs  = let
        big = maximum xs
        small = minimum xs
    in big - small

------------------------------------------------------------------------------
-- Ex 5: given a (non-empty) list of (non-empty) lists, return the longest
-- 练习5：给定一个（非空）列表的（非空）列表，返回最长的
-- list. If there are multiple lists of the same length, return the list that
-- 列表。如果有多个长度相同的列表，返回
-- has the smallest _first element_.
-- _第一个元素_最小的列表。
--
-- (If multiple lists have the same length and same first element,
-- （如果多个列表具有相同的长度和相同的第一个元素，
-- you can return any one of them.)
-- 你可以返回其中任意一个。）
--
-- Give the function "longest" a suitable type.
-- 给函数 "longest" 一个合适的类型。
--
-- Challenge: Can you solve this exercise without sorting the list of lists?
-- 挑战：你能在不对列表进行排序的情况下解决这个练习吗？
--
-- Examples:
-- 示例：
--   longest [[1,2,3],[4,5],[6]] ==> [1,2,3]
--   longest [[1,2,3],[4,5],[6]] ==> [1,2,3]
--   longest ["bcd","def","ab"] ==> "bcd"
--   longest ["bcd","def","ab"] ==> "bcd"

longest :: Ord a => [[a]] -> [a]
longest xs =  snd $ foldl1  choose ( map (\s ->  ( length s ,  s )) xs  )
    where
      choose  (len1, a1) (len2, b2)
        | len1 > len2 = (len1, a1)
        | len1 < len2 = (len2, b2)
        | otherwise   = if head a1 < head b2 then (len1, a1) else (len2, b2)

------------------------------------------------------------------------------
-- Ex 6: Implement the function incrementKey, that takes a list of
-- 练习6：实现函数 incrementKey，接受一个
-- (key,value) pairs, and adds 1 to all the values that have the given key.
-- (键,值) 对的列表，并将所有具有给定键的值加 1。
--
-- You'll need to add _class constraints_ to the type of incrementKey
-- 你需要在 incrementKey 的类型中添加_类约束_
-- to make the function work!
-- 才能使函数正常工作！
--
-- The function needs to be generic and handle all compatible types,
-- 该函数需要是通用的，能处理所有兼容的类型，
-- see the examples.
-- 参见示例。
--
-- Examples:
-- 示例：
--   incrementKey True [(True,1),(False,3),(True,4)] ==> [(True,2),(False,3),(True,5)]
--   incrementKey True [(True,1),(False,3),(True,4)] ==> [(True,2),(False,3),(True,5)]
--   incrementKey 'a' [('a',3.4)] ==> [('a',4.4)]
--   incrementKey 'a' [('a',3.4)] ==> [('a',4.4)]

incrementKey ::( Eq k,  Num v  )=>  k -> [(k,v)] -> [(k,v)]
incrementKey k = map (\s -> if fst s == k then (fst s , snd s +1)  else s )

------------------------------------------------------------------------------
-- Ex 7: compute the average of a list of values of the Fractional
-- 练习7：计算 Fractional 类的值列表的平均值
-- class.
-- 。
--
-- There is no need to handle the empty list case.
-- 不需要处理空列表的情况。
--
-- Hint! since Fractional is a subclass of Num, you have all
-- 提示！由于 Fractional 是 Num 的子类，你可以使用所有的
-- arithmetic operations available
-- 算术运算
--
-- Hint! you can use the function fromIntegral to convert the list
-- 提示！你可以使用函数 fromIntegral 将列表
-- length to a Fractional
-- 长度转换为 Fractional 类型

average :: Fractional a => [a] -> a
average xs = sum xs  / (fromIntegral . length $  xs )

------------------------------------------------------------------------------
-- Ex 8: given a map from player name to score and two players, return
-- 练习8：给定一个从玩家名到分数的映射和两个玩家，返回
-- the name of the player with more points. If the players are tied,
-- 分数更高的玩家的名字。如果两个玩家分数相同，
-- return the name of the first player (that is, the name of the
-- 返回第一个玩家的名字（即参数列表中
-- player who comes first in the argument list, player1).
-- 排在前面的玩家，player1）。
--
-- If a player doesn't exist in the map, you can assume they have 0 points.
-- 如果玩家不在映射中，可以假设他们有 0 分。
--
-- Hint: Map.findWithDefault can make this simpler
-- 提示：Map.findWithDefault 可以让这更简单
--
-- Examples:
-- 示例：
--   winner (Map.fromList [("Bob",3470),("Jane",2130),("Lisa",9448)]) "Jane" "Lisa"
--   winner (Map.fromList [("Bob",3470),("Jane",2130),("Lisa",9448)]) "Jane" "Lisa"
--     ==> "Lisa"
--     ==> "Lisa"
--   winner (Map.fromList [("Mike",13607),("Bob",5899),("Lisa",5899)]) "Lisa" "Bob"
--   winner (Map.fromList [("Mike",13607),("Bob",5899),("Lisa",5899)]) "Lisa" "Bob"
--     ==> "Lisa"
--     ==> "Lisa"

winner :: Map.Map String Int -> String -> String -> String
winner scores player1 player2 = let
    socre1 =  Map.findWithDefault 0  player1 scores
    socre2 =  Map.findWithDefault 0  player2 scores
    in if socre1 >= socre2 then player1 else player2


------------------------------------------------------------------------------
-- Ex 9: compute how many times each value in the list occurs. Return
-- 练习9：计算列表中每个值出现的次数。返回
-- the frequencies as a Map from value to Int.
-- 频率作为从值到 Int 的 Map。
--
-- Challenge 1: try using Map.alter for this
-- 挑战1：尝试使用 Map.alter 来完成
--
-- Challenge 2: use foldr to process the list
-- 挑战2：使用 foldr 来处理列表
--
-- Example:
-- 示例：
--   freqs [False,False,False,True]
--   freqs [False,False,False,True]
--     ==> Map.fromList [(False,3),(True,1)]
--     ==> Map.fromList [(False,3),(True,1)]

freqs :: (Eq a, Ord a) => [a] -> Map.Map a Int
freqs = foldr (\s -> Map.insertWith (+) s 1 ) Map.empty

------------------------------------------------------------------------------
-- Ex 10: recall the withdraw example from the course material. Write a
-- 练习10：回顾课程材料中的 withdraw 示例。编写一个
-- similar function, transfer, that transfers money from one account
-- 类似的函数 transfer，将钱从一个账户
-- to another.
-- 转移到另一个账户。
--
-- However, the function should not perform the transfer if
-- 但是，在以下情况下函数不应执行转账：
-- * the from account doesn't exist,
-- * 转出账户不存在，
-- * the to account doesn't exist,
-- * 转入账户不存在，
-- * the sum is negative,
-- * 金额为负数，
-- * or the from account doesn't have enough money.
-- * 或转出账户没有足够的钱。
--
-- Hint: there are many ways to implement this logic. Map.member or
-- 提示：有很多方法可以实现这个逻辑。Map.member 或
-- Map.notMember might help.
-- Map.notMember 可能会有帮助。
--
-- Examples:
-- 示例：
--   let bank = Map.fromList [("Bob",100),("Mike",50)]
--   let bank = Map.fromList [("Bob",100),("Mike",50)]
--   transfer "Bob" "Mike" 20 bank
--   transfer "Bob" "Mike" 20 bank
--     ==> fromList [("Bob",80),("Mike",70)]
--     ==> fromList [("Bob",80),("Mike",70)]
--   transfer "Bob" "Mike" 120 bank
--   transfer "Bob" "Mike" 120 bank
--     ==> fromList [("Bob",100),("Mike",50)]
--     ==> fromList [("Bob",100),("Mike",50)]
--   transfer "Bob" "Lisa" 20 bank
--   transfer "Bob" "Lisa" 20 bank
--     ==> fromList [("Bob",100),("Mike",50)]
--     ==> fromList [("Bob",100),("Mike",50)]
--   transfer "Lisa" "Mike" 20 bank
--   transfer "Lisa" "Mike" 20 bank
--     ==> fromList [("Bob",100),("Mike",50)]
--     ==> fromList [("Bob",100),("Mike",50)]

transfer :: String -> String -> Int -> Map.Map String Int -> Map.Map String Int
transfer from to amount bank
    |amount >= 0 &&  Map.member from bank && Map.member to  bank  && Map.findWithDefault 0 from bank >= amount =  Map.adjust (\s -> s - amount) from $ Map.adjust (+amount) to bank 
    | otherwise =  bank
------------------------------------------------------------------------------
-- Ex 11: given an Array and two indices, swap the elements in the indices.
-- 练习11：给定一个数组和两个索引，交换索引处的元素。
--
-- Example:
-- 示例：
--   swap 2 3 (array (1,4) [(1,"one"),(2,"two"),(3,"three"),(4,"four")])
--   swap 2 3 (array (1,4) [(1,"one"),(2,"two"),(3,"three"),(4,"four")])
--         ==> array (1,4) [(1,"one"),(2,"three"),(3,"two"),(4,"four")]
--         ==> array (1,4) [(1,"one"),(2,"three"),(3,"two"),(4,"four")]

swap :: Ix i => i -> i -> Array i a -> Array i a
swap i j arr = arr // [(i, arr ! j), (j, arr ! i)]


------------------------------------------------------------------------------
-- Ex 12: given an Array, find the index of the largest element. You
-- 练习12：给定一个数组，找到最大元素的索引。你
-- can assume the Array isn't empty.
-- 可以假设数组不为空。
--
-- You may assume that the largest element is unique.
-- 你可以假设最大元素是唯一的。
--
-- Hint: check out Data.Array.indices or Data.Array.assocs
-- 提示：查看 Data.Array.indices 或 Data.Array.assocs

maxIndex :: (Ix i, Ord a) => Array i a -> i
maxIndex xs = fst $  foldl1 ( \(i1, val1) (i2 , val2 ) -> if val1 > val2 then (i1 ,val1) else (i2,val2 )  ) (assocs xs ) 
