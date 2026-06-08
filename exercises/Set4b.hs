-- Exercise set 4b: folds
-- 练习集 4b：折叠

module Set4b where

import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: countNothings with a fold. The function countNothings from
-- 练习1：用折叠实现 countNothings。课程材料中的 countNothings 函数
-- the course material can be implemented using foldr. Your task is to
-- 可以用 foldr 实现。你的任务是
-- define countHelper so that the following definition of countNothings
-- 定义 countHelper，使得以下 countNothings 的定义
-- works.
-- 能够正常工作。
--
-- Hint: You can start by trying to add a type signature for countHelper.
-- 提示：你可以先尝试为 countHelper 添加类型签名。
--
-- Challenge: look up the maybe function and use it in countHelper.
-- 挑战：查阅 maybe 函数并在 countHelper 中使用它。
--
-- Examples:
-- 示例：
--   countNothings []  ==>  0
--   countNothings []  ==>  0
--   countNothings [Just 1, Nothing, Just 3, Nothing]  ==>  2
--   countNothings [Just 1, Nothing, Just 3, Nothing]  ==>  2

countNothings :: [Maybe a] -> Int
countNothings xs = foldr countHelper 0 xs

countHelper = todo

------------------------------------------------------------------------------
-- Ex 2: myMaximum with a fold. Just like in the previous exercise,
-- 练习2：用折叠实现 myMaximum。就像上一个练习一样，
-- define maxHelper so that the given definition of myMaximum works.
-- 定义 maxHelper 使得给定的 myMaximum 定义能够正常工作。
--
-- Examples:
-- 示例：
--   myMaximum []  ==>  0
--   myMaximum []  ==>  0
--   myMaximum [1,3,2]  ==>  3
--   myMaximum [1,3,2]  ==>  3

myMaximum :: [Int] -> Int
myMaximum [] = 0
myMaximum (x:xs) = foldr maxHelper x xs

maxHelper = todo

------------------------------------------------------------------------------
-- Ex 3: compute the sum and length of a list with a fold. Define
-- 练习3：用折叠计算列表的和与长度。定义
-- slHelper and slStart so that the given definition of sumAndLength
-- slHelper 和 slStart，使得给定的 sumAndLength 定义
-- works. This could be used to compute the average of a list.
-- 能够正常工作。这可以用来计算列表的平均值。
--
-- Start by giving slStart and slHelper types.
-- 首先给 slStart 和 slHelper 添加类型。
--
-- Examples:
-- 示例：
--   sumAndLength []             ==>  (0.0,0)
--   sumAndLength []             ==>  (0.0,0)
--   sumAndLength [1.0,2.0,4.0]  ==>  (7.0,3)
--   sumAndLength [1.0,2.0,4.0]  ==>  (7.0,3)


sumAndLength :: [Double] -> (Double,Int)
sumAndLength xs = foldr slHelper slStart xs

slStart = todo
slHelper = todo

------------------------------------------------------------------------------
-- Ex 4: implement concat with a fold. Define concatHelper and
-- 练习4：用折叠实现 concat。定义 concatHelper 和
-- concatStart so that the given definition of myConcat joins inner
-- concatStart，使得给定的 myConcat 定义能够将
-- lists of a list.
-- 列表中的内部列表连接起来。
--
-- Examples:
-- 示例：
--   myConcat [[]]                ==> []
--   myConcat [[]]                ==> []
--   myConcat [[1,2,3],[4,5],[6]] ==> [1,2,3,4,5,6]
--   myConcat [[1,2,3],[4,5],[6]] ==> [1,2,3,4,5,6]

myConcat :: [[a]] -> [a]
myConcat xs = foldr concatHelper concatStart xs

concatStart = todo
concatHelper = todo

------------------------------------------------------------------------------
-- Ex 5: get all occurrences of the largest number in a list with a
-- 练习5：用折叠获取列表中最大数的所有出现。实现
-- fold. Implement largestHelper so that the given definition of largest works.
-- largestHelper 使得给定的 largest 定义能够正常工作。
--
-- Examples:
-- 示例：
--   largest [] ==> []
--   largest [] ==> []
--   largest [1,3,2] ==> [3]
--   largest [1,3,2] ==> [3]
--   largest [1,3,2,3] ==> [3,3]
--   largest [1,3,2,3] ==> [3,3]

largest :: [Int] -> [Int]
largest xs = foldr largestHelper [] xs

largestHelper = todo


------------------------------------------------------------------------------
-- Ex 6: get the first element of a list with a fold. Define
-- 练习6：用折叠获取列表的第一个元素。定义
-- headHelper so that the given definition of myHead works.
-- headHelper 使得给定的 myHead 定义能够正常工作。
--
-- Start by giving headHelper a type.
-- 首先给 headHelper 添加类型。
--
-- Examples:
-- 示例：
--   myHead []  ==>  Nothing
--   myHead []  ==>  Nothing
--   myHead [1,2,3]  ==>  Just 1
--   myHead [1,2,3]  ==>  Just 1

myHead :: [a] -> Maybe a
myHead xs = foldr headHelper Nothing xs

headHelper = todo

------------------------------------------------------------------------------
-- Ex 7: get the last element of a list with a fold. Define lasthelper
-- 练习7：用折叠获取列表的最后一个元素。定义 lastHelper
-- so that the given definition of myLast works.
-- 使得给定的 myLast 定义能够正常工作。
--
-- Start by giving lastHelper a type.
-- 首先给 lastHelper 添加类型。
--
-- Examples:
-- 示例：
--   myLast [] ==> Nothing
--   myLast [] ==> Nothing
--   myLast [1,2,3] ==> Just 3
--   myLast [1,2,3] ==> Just 3

myLast :: [a] -> Maybe a
myLast xs = foldr lastHelper Nothing xs

lastHelper = todo
