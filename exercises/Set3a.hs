-- Exercise set 3a
-- 练习集 3a
--
--  * lists
--  * 列表
--  * functional programming
--  * 函数式编程

module Set3a where

import Mooc.Todo

-- Some imports you'll need.
-- 一些你需要的导入。
-- Do not add any other imports! :)
-- 不要添加任何其他导入！ :)
import Data.Char
import Data.Either
import Data.List

------------------------------------------------------------------------------
-- Ex 1: implement the function maxBy that takes as argument a
-- 练习1：实现函数 maxBy，它接受一个
-- measuring function (of type a -> Int) and two values (of type a).
-- 度量函数（类型为 a -> Int）和两个值（类型为 a）作为参数。
--
-- maxBy should apply the measuring function to both arguments and
-- maxBy 应该将度量函数应用于两个参数，并
-- return the argument for which the measuring function returns a
-- 返回度量函数返回
-- higher value.
-- 较大值的那个参数。
--
-- Examples:
-- 示例：
--
--  maxBy (*2)   3       5      ==>  5
--  maxBy length [1,2,3] [4,5]  ==>  [1,2,3]
--  maxBy head   [1,2,3] [4,5]  ==>  [4,5]

maxBy :: (a -> Int) -> a -> a -> a
maxBy measure a b = let
    ma  = measure a
    mb  = measure b
    in if ma > mb then a else b

------------------------------------------------------------------------------
-- Ex 2: implement the function mapMaybe that takes a function and a
-- 练习2：实现函数 mapMaybe，它接受一个函数和一个
-- Maybe value. If the value is Nothing, it returns Nothing. If it is
-- Maybe 值。如果值是 Nothing，则返回 Nothing。如果是
-- a Just, it updates the contained value using the function.
-- Just，则使用函数更新包含的值。
--
-- Examples:
-- 示例：
--   mapMaybe length Nothing      ==> Nothing
--   mapMaybe length (Just "abc") ==> Just 3

mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe = fmap

------------------------------------------------------------------------------
-- Ex 3: implement the function mapMaybe2 that works like mapMaybe
-- 练习3：实现函数 mapMaybe2，它的工作方式类似于 mapMaybe
-- except it combines two Maybe values using a function of two
-- 不同的是它使用一个双参数函数来组合两个 Maybe 值
-- arguments.
-- 。
--
-- Examples:
-- 示例：
--   mapMaybe2 take (Just 2) (Just "abcd") ==> Just "ab"
--   mapMaybe2 div (Just 6) (Just 3)  ==>  Just 2
--   mapMaybe2 div Nothing  (Just 3)  ==>  Nothing
--   mapMaybe2 div (Just 6) Nothing   ==>  Nothing

mapMaybe2 :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
mapMaybe2 f x y = fmap f x <*> y

------------------------------------------------------------------------------
-- Ex 4: define the functions firstHalf and palindrome so that
-- 练习4：定义函数 firstHalf 和 palindrome，使得
-- palindromeHalfs returns the first halfs of all palindromes in its
-- palindromeHalfs 返回其输入中所有回文的
-- input.
-- 前半部分。
--
-- The first half of a string should include the middle character of
-- 字符串的前半部分应该包含
-- the string if the string has an odd length.
-- 字符串长度为奇数时的中间字符。
--
-- Examples:
-- 示例：
--   palindromeHalfs ["abba", "cat", "racecar"]
--     ==> ["ab","race"]
--
-- What types should firstHalf and palindrome have? Give them type
-- firstHalf 和 palindrome 应该有什么类型？给它们
-- annotations.
-- 类型注解。
--
-- Note! Do not change the definition of palindromeHalfs
-- 注意！不要修改 palindromeHalfs 的定义

palindromeHalfs :: [String] -> [String]
palindromeHalfs xs = map firstHalf (filter palindrome xs)

firstHalf  s =  take  ((length s + 1 ) `div`   2 ) s

palindrome :: String  ->  Bool 
palindrome s = reverse s  == s 

------------------------------------------------------------------------------
-- Ex 5: Implement a function capitalize that takes in a string and
-- 练习5：实现函数 capitalize，它接受一个字符串并
-- capitalizes the first letter of each word in it.
-- 将其中每个单词的首字母大写。
--
-- You should probably define a helper function capitalizeFirst that
-- 你可能需要定义一个辅助函数 capitalizeFirst，它
-- capitalizes the first letter of a string.
-- 将字符串的首字母大写。
--
-- These functions will help:
-- 以下函数会有帮助：
--  - toUpper :: Char -> Char   from the module Data.Char
--  - toUpper :: Char -> Char   来自模块 Data.Char
--  - words :: String -> [String]
--  - unwords :: [String] -> String
--
-- Example:
-- 示例：
--   capitalize "goodbye cruel world" ==> "Goodbye Cruel World"

capitalize :: String -> String
capitalize = todo

------------------------------------------------------------------------------
-- Ex 6: powers k max should return all the powers of k that are less
-- 练习6：powers k max 应该返回 k 的所有
-- than or equal to max. For example:
-- 小于或等于 max 的幂。例如：
--
-- powers 2 5 ==> [1,2,4]
-- powers 3 30 ==> [1,3,9,27]
-- powers 2 2 ==> [1,2]
--
-- You can assume that k is at least 2.
-- 你可以假设 k 至少为 2。
--
-- Hints:
-- 提示：
--   * k^max > max
--   * the function takeWhile
--   * 函数 takeWhile

powers :: Int -> Int -> [Int]
powers k max = todo

------------------------------------------------------------------------------
-- Ex 7: implement a functional while loop. While should be a function
-- 练习7：实现一个函数式 while 循环。While 应该是一个函数，
-- that takes a checking function, an updating function, and an
-- 它接受一个检查函数、一个更新函数和
-- initial value. While should repeatedly apply the updating function
-- 一个初始值。While 应该反复将更新函数
-- to the initial value as long as the value passes the checking
-- 应用于初始值，只要该值通过检查
-- function. Finally, the value that doesn't pass the check is
-- 函数。最后，未通过检查的值
-- returned.
-- 被返回。
--
-- Examples:
-- 示例：
--
--   while odd (+1) 1    ==>   2
--
--   while (<=4) (+1) 0  ==>   5
--
--   let check [] = True
--       check ('A':xs) = False
--       check _ = True
--   in while check tail "xyzAvvt"
--     ==> Avvt

while :: (a->Bool) -> (a->a) -> a -> a
while check update value = todo

------------------------------------------------------------------------------
-- Ex 8: another version of a while loop. This time, the check
-- 练习8：while 循环的另一个版本。这次，检查
-- function returns an Either value. A Left value means stop, a Right
-- 函数返回一个 Either 值。Left 值表示停止，Right
-- value means keep looping.
-- 值表示继续循环。
--
-- The call `whileRight check x` should call `check x`, and if the
-- 调用 `whileRight check x` 应该调用 `check x`，如果
-- result is a Left, return the contents of the Left. If the result is
-- 结果是 Left，则返回 Left 的内容。如果结果是
-- a Right, the function should call `check` on the contents of the
-- Right，则函数应该对 Right 的内容调用 `check`，
-- Right and so on.
-- 以此类推。
--
-- Examples (see definitions of step and bomb below):
-- 示例（见下面 step 和 bomb 的定义）：
--   whileRight (step 100) 1   ==> 128
--   whileRight (step 1000) 3  ==> 1536
--   whileRight bomb 7         ==> "BOOM"
--
-- Hint! Remember the case-of expression from lecture 2.
-- 提示！记住第2讲中的 case-of 表达式。

whileRight :: (a -> Either b a) -> a -> b
whileRight check x = todo

-- for the whileRight examples:
-- 用于 whileRight 的示例：
-- step k x doubles x if it's less than k
-- step k x 在 x 小于 k 时将 x 翻倍
step :: Int -> Int -> Either Int Int
step k x = if x<k then Right (2*x) else Left x

-- bomb x implements a countdown: it returns x-1 or "BOOM" if x was 0
-- bomb x 实现倒计时：它返回 x-1，如果 x 为 0 则返回 "BOOM"
bomb :: Int -> Either String Int
bomb 0 = Left "BOOM"
bomb x = Right (x-1)

------------------------------------------------------------------------------
-- Ex 9: given a list of strings and a length, return all strings that
-- 练习9：给定一个字符串列表和一个长度，返回所有满足以下条件的字符串：
--  * have the given length
--  * 具有给定长度
--  * are made by catenating two input strings
--  * 由两个输入字符串连接而成
--
-- Examples:
-- 示例：
--   joinToLength 2 ["a","b","cd"]        ==> ["aa","ab","ba","bb"]
--   joinToLength 5 ["a","b","cd","def"]  ==> ["cddef","defcd"]
--
-- Hint! This is a great use for list comprehensions
-- 提示！这是列表推导式的绝佳应用

joinToLength :: Int -> [String] -> [String]
joinToLength = todo

------------------------------------------------------------------------------
-- Ex 10: implement the operator +|+ that returns a list with the first
-- 练习10：实现运算符 +|+，它返回一个包含
-- elements of its input lists.
-- 输入列表首元素的列表。
--
-- Give +|+ a type signature. NB: It needs to be of the form (+|+) :: x,
-- 给 +|+ 一个类型签名。注意：它需要是 (+|+) :: x 的形式，
-- with the parentheses because +|+ is an infix operator.
-- 带括号，因为 +|+ 是一个中缀运算符。
--
-- Examples:
-- 示例：
--   [1,2,3] +|+ [4,5,6]  ==> [1,4]
--   [] +|+ [True]        ==> [True]
--   [] +|+ []            ==> []


------------------------------------------------------------------------------
-- Ex 11: remember the lectureParticipants example from Lecture 2? We
-- 练习11：还记得第2讲中的 lectureParticipants 示例吗？我们
-- used a value of type [Either String Int] to store some measurements
-- 使用了类型为 [Either String Int] 的值来存储一些
-- that might be missing. Implement the function sumRights which sums
-- 可能缺失的测量值。实现函数 sumRights，它对
-- all non-missing measurements in a list like this.
-- 此类列表中所有非缺失的测量值求和。
--
-- Challenge: look up the type of the either function. Implement
-- 挑战：查阅 either 函数的类型。使用 map 和 either 函数
-- sumRights using the map & either functions instead of pattern
-- 实现 sumRights，而不是对列表或 Either 进行
-- matching on lists or Eithers!
-- 模式匹配！
--
-- Examples:
-- 示例：
--   sumRights [Right 1, Left "bad value", Right 2]  ==>  3
--   sumRights [Left "bad!", Left "missing"]         ==>  0

sumRights :: [Either a Int] -> Int
sumRights = todo

------------------------------------------------------------------------------
-- Ex 12: recall the binary function composition operation
-- 练习12：回顾二元函数组合操作
-- (f . g) x = f (g x). In this exercise, your task is to define a function
-- (f . g) x = f (g x)。在这个练习中，你的任务是定义一个函数，
-- that takes any number of functions given as a list and composes them in the
-- 它接受以列表形式给出的任意数量的函数，并按照它们在列表中
-- same order than they appear in the list.
-- 出现的相同顺序进行组合。
--
-- Examples:
-- 示例：
--   multiCompose [] "foo" ==> "foo"
--   multiCompose [] 1     ==> 1
--   multiCompose [(++"bar")] "foo" ==> "foobar"
--   multiCompose [reverse, tail, (++"bar")] "foo" ==> "raboo"
--   multiCompose [(3*), (2^), (+1)] 0 ==> 6
--   multiCompose [(+1), (2^), (3*)] 0 ==> 2

multiCompose fs = todo

------------------------------------------------------------------------------
-- Ex 13: let's consider another way to compose multiple functions. Given
-- 练习13：让我们考虑另一种组合多个函数的方式。给定
-- some function f, a list of functions gs, and some value x, define
-- 某个函数 f、一个函数列表 gs 和某个值 x，定义
-- a composition operation that applies each function g in gs to x and then
-- 一个组合操作，将 gs 中的每个函数 g 应用于 x，然后
-- f to the resulting list. Give also the type annotation for multiApp.
-- 将 f 应用于结果列表。同时给出 multiApp 的类型注解。
--
-- Challenge: Try implementing multiApp without lambdas or list comprehensions.
-- 挑战：尝试不使用 lambda 或列表推导式来实现 multiApp。
--
-- Examples:
-- 示例：
--   multiApp id [] 7  ==> []
--   multiApp id [id, reverse, tail] "This is a test"
--       ==> ["This is a test","tset a si sihT","his is a test"]
--   multiApp id  [(1+), (^3), (+2)] 1  ==>  [2,1,3]
--   multiApp sum [(1+), (^3), (+2)] 1  ==>  6
--   multiApp reverse [tail, take 2, reverse] "foo" ==> ["oof","fo","oo"]
--   multiApp concat [take 3, reverse] "race" ==> "racecar"
--   multiApp id [head, (!!2), last] "axbxc" ==> ['a','b','c'] i.e. "abc"
--   multiApp sum [head, (!!2), last] [1,9,2,9,3] ==> 6

multiApp = todo

------------------------------------------------------------------------------
-- Ex 14: in this exercise you get to implement an interpreter for a
-- 练习14：在这个练习中，你将实现一个
-- simple language. You should keep track of the x and y coordinates,
-- 简单语言的解释器。你应该跟踪 x 和 y 坐标，
-- and interpret the following commands:
-- 并解释以下命令：
--
-- up -- increment y by one
-- up -- y 加一
-- down -- decrement y by one
-- down -- y 减一
-- left -- decrement x by one
-- left -- x 减一
-- right -- increment x by one
-- right -- x 加一
-- printX -- print value of x
-- printX -- 打印 x 的值
-- printY -- print value of y
-- printY -- 打印 y 的值
--
-- The interpreter will be a function of type [String] -> [String].
-- 解释器将是一个类型为 [String] -> [String] 的函数。
-- Its input is a list of commands, and its output is a list of the
-- 它的输入是一个命令列表，输出是输入中
-- results of the print commands in the input.
-- 打印命令的结果列表。
--
-- Both coordinates start at 0.
-- 两个坐标都从 0 开始。
--
-- Examples:
-- 示例：
--
-- interpreter ["up","up","up","printY","down","printY"] ==> ["3","2"]
-- interpreter ["up","right","right","printY","printX"] ==> ["1","2"]
--
-- Surprise! after you've implemented the function, try running this in GHCi:
-- 惊喜！实现函数后，尝试在 GHCi 中运行以下命令：
--     interact (unlines . interpreter . lines)
-- after this you can enter commands on separate lines and see the
-- 之后你可以在单独的行中输入命令并看到
-- responses to them
-- 对应的响应
--
-- The suprise will only work if you generate the return list directly
-- 这个惊喜只有在你直接生成返回列表时才有效
-- using (:). If you build the list in an argument to a helper
-- 使用 (:)。如果你在辅助函数的参数中构建列表，
-- function, the surprise won't work. See section 3.8 in the material.
-- 惊喜将不起作用。参见教材第 3.8 节。

interpreter :: [String] -> [String]
interpreter commands = todo
