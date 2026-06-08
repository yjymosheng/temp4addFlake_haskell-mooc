-- Exercise set 2:
-- 练习集 2：
--  * Guards
--  * 守卫
--  * Lists
--  * 列表
--  * Maybe
--  * Maybe 类型
--  * Either
--  * Either 类型
--
-- Functions you will need:
-- 你将需要以下函数：
--  * head, tail
--  * head, tail
--  * take, drop
--  * take, drop
--  * length
--  * length
--  * null
--  * null

module Set2a where

import Mooc.Todo

-- Some imports you'll need. Don't add other imports :)
-- 一些你需要的导入。不要添加其他导入 :)
import Data.List
import Data.Maybe (isNothing, isJust)

------------------------------------------------------------------------------
-- Ex 1: Define the constant years, that is a list of the values 1982,
-- 练习 1：定义常量 years，它是一个包含值 1982、
-- 2004 and 2020 in this order.
-- 2004 和 2020 的列表，按此顺序。

years = [1982 ,  2004 ,  2020]

------------------------------------------------------------------------------
-- Ex 2: define the function takeFinal, which returns the n last
-- 练习 2：定义函数 takeFinal，它返回给定列表的最后 n 个
-- elements of the given list.
-- 元素。
--
-- If the list is shorter than n, return all elements.
-- 如果列表长度小于 n，返回所有元素。
--
-- Hint! remember the take and drop functions.
-- 提示！记住 take 和 drop 函数。

takeFinal :: Int -> [a] -> [a]
takeFinal n xs 
    | length xs  <  n  =  xs 
    | otherwise  = drop (length xs  -  n  ) xs 

------------------------------------------------------------------------------
-- Ex 3: Update an element at a certain index in a list. More
-- 练习 3：更新列表中某个索引处的元素。更准确地说，
-- precisely, return a list that is identical to the given list except
-- 返回一个与给定列表相同的列表，除了
-- the element at index i is x.
-- 索引 i 处的元素为 x。
--
-- Note! indexing starts from 0
-- 注意！索引从 0 开始
--
-- Examples:
-- 示例：
--   updateAt 0 4 [1,2,3]   ==>  [4,2,3]
--   updateAt 0 4 [1,2,3]   ==>  [4,2,3]
--   updateAt 2 0 [4,5,6,7] ==>  [4,5,0,7]
--   updateAt 2 0 [4,5,6,7] ==>  [4,5,0,7]

updateAt :: Int -> a -> [a] -> [a]
updateAt i x xs = take i xs ++ [x] ++ drop (i+1 )  xs  

------------------------------------------------------------------------------
-- Ex 4: substring i j s should return the substring of s starting at
-- 练习 4：substring i j s 应该返回 s 中从索引 i 开始
-- index i and ending at (right before) index j. Indexes start from 0.
-- 到索引 j（不包含 j）的子串。索引从 0 开始。
--
-- Remember that strings are lists!
-- 记住字符串就是列表！
--
-- Examples:
-- 示例：
--   substring 2 5 "abcdefgh"  ==>  "cde"
--   substring 2 5 "abcdefgh"  ==>  "cde"
--   substring 2 2 "abcdefgh"  ==>  ""
--   substring 2 2 "abcdefgh"  ==>  ""
--   substring 0 4 "abcdefgh"  ==>  "abcd"
--   substring 0 4 "abcdefgh"  ==>  "abcd"

substring :: Int -> Int -> String -> String
substring i j s =  take (j-i) (drop i s )

------------------------------------------------------------------------------
-- Ex 5: check if a string is a palindrome. A palindrome is a string
-- 练习 5：检查一个字符串是否是回文。回文是一个正读
-- that is the same when read backwards.
-- 和反读都相同的字符串。
--
-- Hint! There's a really simple solution to this. Don't overthink it!
-- 提示！这个问题有一个非常简单的解法。不要想太多！
--
-- Examples:
-- 示例：
--   isPalindrome ""         ==>  True
--   isPalindrome ""         ==>  True
--   isPalindrome "ABBA"     ==>  True
--   isPalindrome "ABBA"     ==>  True
--   isPalindrome "racecar"  ==>  True
--   isPalindrome "racecar"  ==>  True
--   isPalindrome "AB"       ==>  False
--   isPalindrome "AB"       ==>  False

isPalindrome :: String -> Bool
isPalindrome str = str == reverse str

------------------------------------------------------------------------------
-- Ex 6: implement the function palindromify that chops a character
-- 练习 6：实现函数 palindromify，它从字符串的前面和后面
-- off the front _and_ back of a string until the result is a
-- 各砍掉一个字符，直到结果
-- palindrome.
-- 是回文。
--
-- Examples:
-- 示例：
--   palindromify "ab" ==> ""
--   palindromify "ab" ==> ""
--   palindromify "aaay" ==> "aa"
--   palindromify "aaay" ==> "aa"
--   palindromify "xabbay" ==> "abba"
--   palindromify "xabbay" ==> "abba"
--   palindromify "abracacabra" ==> "acaca"
--   palindromify "abracacabra" ==> "acaca"

palindromify :: String -> String
palindromify s = if isPalindrome s  then s else palindromify $ drop 1 (init s)

------------------------------------------------------------------------------
-- Ex 7: implement safe integer division, that is, a function that
-- 练习 7：实现安全的整数除法，即一个函数，
-- returns a Just result normally, but Nothing if the divisor is zero.
-- 正常情况下返回 Just 结果，但如果除数为零则返回 Nothing。
--
-- Remember that integer division can be done with the div function.
-- 记住整数除法可以使用 div 函数。
--
-- Examples:
-- 示例：
--   safeDiv 4 2  ==> Just 2
--   safeDiv 4 2  ==> Just 2
--   safeDiv 4 0  ==> Nothing
--   safeDiv 4 0  ==> Nothing

safeDiv :: Integer -> Integer -> Maybe Integer
safeDiv x y 
    | y == 0  = Nothing 
    | otherwise  = Just $ div x y  

------------------------------------------------------------------------------
-- Ex 8: implement a function greet that greets a person given a first
-- 练习 8：实现一个函数 greet，根据给定的名
-- name and possibly a last name. The last name is represented as a
-- 和可能的姓来问候一个人。姓用
-- Maybe String value.
-- Maybe String 值表示。
--
-- Examples:
-- 示例：
--   greet "John" Nothing         ==> "Hello, John!"
--   greet "John" Nothing         ==> "Hello, John!"
--   greet "John" (Just "Smith")  ==> "Hello, John Smith!"
--   greet "John" (Just "Smith")  ==> "Hello, John Smith!"

greet :: String -> Maybe String -> String
greet first Nothing   = "Hello, " ++ first ++ "!"
greet first (Just last) = "Hello, " ++ first ++ " " ++ last ++ "!"

------------------------------------------------------------------------------
-- Ex 9: safe list indexing. Define a function safeIndex so that
-- 练习 9：安全的列表索引。定义一个函数 safeIndex，使得
--   safeIndex xs i
--   safeIndex xs i
-- gets the element at index i in the list xs. If i is not a valid
-- 获取列表 xs 中索引 i 处的元素。如果 i 不是有效的
-- index, Nothing is returned.
-- 索引，则返回 Nothing。
--
-- Examples:
-- 示例：
--   safeIndex [True] 1            ==> Nothing
--   safeIndex [True] 1            ==> Nothing
--   safeIndex [10,20,30] 0        ==> Just 10
--   safeIndex [10,20,30] 0        ==> Just 10
--   safeIndex [10,20,30] 2        ==> Just 30
--   safeIndex [10,20,30] 2        ==> Just 30
--   safeIndex [10,20,30] 3        ==> Nothing
--   safeIndex [10,20,30] 3        ==> Nothing
--   safeIndex ["a","b","c"] (-1)  ==> Nothing
--   safeIndex ["a","b","c"] (-1)  ==> Nothing

safeIndex :: [a] -> Int -> Maybe a
safeIndex xs i 
    | i < 0 || i >  length xs - 1   =  Nothing
    | otherwise =  Just   $ xs !! i

------------------------------------------------------------------------------
-- Ex 10: another variant of safe division. This time you should use
-- 练习 10：安全除法的另一个变体。这次你应该使用
-- Either to return a string error message.
-- Either 来返回字符串错误消息。
--
-- Examples:
-- 示例：
--   eitherDiv 4 2   ==> Right 2
--   eitherDiv 4 2   ==> Right 2
--   eitherDiv 4 0   ==> Left "4/0"
--   eitherDiv 4 0   ==> Left "4/0"

eitherDiv :: Integer -> Integer -> Either String Integer
eitherDiv x y 
    |  y ==0  =  Left $ show x ++ "/" ++ show y 
    | otherwise =  Right $  x  `div` y 

------------------------------------------------------------------------------
-- Ex 11: implement the function addEithers, which combines two values of type
-- 练习 11：实现函数 addEithers，它将两个类型为
-- Either String Int into one like this:
-- Either String Int 的值合并为一个，规则如下：
--
-- - If both inputs were Ints, sum the Ints
-- - 如果两个输入都是 Int，则将 Int 相加
-- - Otherwise, return the first argument that was not an Int
-- - 否则，返回第一个不是 Int 的参数
--
-- Hint! Remember pattern matching
-- 提示！记住模式匹配
--
-- Examples:
-- 示例：
--   addEithers (Right 1) (Right 2) ==> Right 3
--   addEithers (Right 1) (Right 2) ==> Right 3
--   addEithers (Right 1) (Left "fail") ==> Left "fail"
--   addEithers (Right 1) (Left "fail") ==> Left "fail"
--   addEithers (Left "boom") (Left "fail") ==> Left "boom"
--   addEithers (Left "boom") (Left "fail") ==> Left "boom"

addEithers :: Either String Int -> Either String Int -> Either String Int
addEithers  (Right a ) ( Right b ) = Right $ a +b 
addEithers  (Right a ) ( Left  b ) = Left   b 
addEithers  (Left a ) ( Right b ) = Left a 
addEithers   (Left a ) ( Left b ) = Left a 
