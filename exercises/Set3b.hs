-- Exercise set 3b
-- 练习集 3b
--
-- This is a special exercise set. The exercises are about
-- 这是一个特殊的练习集。这些练习是关于
-- implementing list functions using recursion and pattern matching,
-- 使用递归和模式匹配实现列表函数，
-- without using any standard library functions. For this reason,
-- 不使用任何标准库函数。因此，
-- you'll be working in a limited environment where almost none of the
-- 你将在一个受限的环境中工作，那里几乎没有
-- standard library is available.
-- 标准库可用。
--
-- At least the following standard library functions are missing:
-- 至少以下标准库函数不可用：
--  * (++)
--  * head
--  * tail
--  * map
--  * filter
--  * concat
--  * (!!)
--
-- The (:) operator is available, as is list literal syntax [a,b,c].
-- (:) 运算符可用，列表字面量语法 [a,b,c] 也可用。
--
-- Feel free to use if-then-else, guards, and ordering functions (< and > etc.).
-- 你可以自由使用 if-then-else、守卫和比较函数（< 和 > 等）。
--
-- The tests will check that you haven't added imports :)
-- 测试会检查你是否添加了导入 :)

{-# LANGUAGE NoImplicitPrelude #-}

module Set3b where

import Mooc.LimitedPrelude
import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: given numbers start, count and end, build a list that starts
-- 练习1：给定数字 start、count 和 end，构建一个以
-- with count copies of start and ends with end.
-- count 个 start 副本开头并以 end 结尾的列表。
--
-- Use recursion and the : operator to build the list.
-- 使用递归和 : 运算符来构建列表。
--
-- Examples:
-- 示例：
--   buildList 1 5 2 ==> [1,1,1,1,1,2]
--   buildList 7 0 3 ==> [3]

buildList :: Int -> Int -> Int -> [Int]
buildList start 0 end = [end]
buildList start count end = start : buildList start (count-1) end

------------------------------------------------------------------------------
-- Ex 2: given i, build the list of sums [1, 1+2, 1+2+3, .., 1+2+..+i]
-- 练习2：给定 i，构建和的列表 [1, 1+2, 1+2+3, .., 1+2+..+i]
--
-- Use recursion and the : operator to build the list.
-- 使用递归和 : 运算符来构建列表。
--
-- Ps. you'll probably need a recursive helper function
-- 附：你可能需要一个递归辅助函数

sums :: Int -> [Int]
sums n = go 1 0
  where
    go i acc
      | i > n     = []
      | otherwise = let newAcc = acc + i
                    in newAcc : go (i+1) newAcc
------------------------------------------------------------------------------
-- Ex 3: define a function mylast that returns the last value of the
-- 练习3：定义一个函数 mylast，返回
-- given list. For an empty list, a provided default value is
-- 给定列表的最后一个值。对于空列表，提供的默认值
-- returned.
-- 会被返回。
--
-- Use only pattern matching and recursion (and the list constructors : and [])
-- 只使用模式匹配和递归（以及列表构造器 : 和 []）
--
-- Examples:
-- 示例：
--   mylast 0 [] ==> 0
--   mylast 0 [1,2,3] ==> 3

mylast :: a -> [a] -> a
mylast def [] =  def
mylast def [x] =  x
mylast def (x:xs) = mylast def xs


------------------------------------------------------------------------------
-- Ex 4: safe list indexing. Define a function indexDefault so that
-- 练习4：安全的列表索引。定义一个函数 indexDefault，使得
--   indexDefault xs i def
-- gets the element at index i in the list xs. If i is not a valid
-- 获取列表 xs 中索引 i 处的元素。如果 i 不是有效的
-- index, def is returned.
-- 索引，则返回 def。
--
-- Use only pattern matching and recursion (and the list constructors : and [])
-- 只使用模式匹配和递归（以及列表构造器 : 和 []）
--
-- Examples:
-- 示例：
--   indexDefault [True] 1 False         ==>  False
--   indexDefault [10,20,30] 0 7         ==>  10
--   indexDefault [10,20,30] 2 7         ==>  30
--   indexDefault [10,20,30] 3 7         ==>  7
--   indexDefault ["a","b","c"] (-1) "d" ==> "d"

indexDefault :: [a] -> Int -> a -> a
indexDefault [] i def = def
indexDefault (x:xs) 0 def  =  x
indexDefault (x:xs) i def  =  indexDefault xs (i-1) def

------------------------------------------------------------------------------
-- Ex 5: define a function that checks if the given list is in
-- 练习5：定义一个函数，检查给定列表是否
-- increasing order.
-- 按升序排列。
--
-- Use pattern matching and recursion to iterate through the list.
-- 使用模式匹配和递归来遍历列表。
--
-- Examples:
-- 示例：
--   sorted [1,2,3] ==> True
--   sorted []      ==> True
--   sorted [2,7,7] ==> True
--   sorted [1,3,2] ==> False
--   sorted [7,2,7] ==> False

sorted :: [Int] -> Bool
sorted [] = True
sorted [x] = True
sorted (a:b:xs) = (a <= b) && sorted (b:xs)

------------------------------------------------------------------------------
-- Ex 6: compute the partial sums of the given list like this:
-- 练习6：计算给定列表的部分和，如下所示：
--
--   sumsOf [a,b,c]  ==>  [a,a+b,a+b+c]
--   sumsOf [a,b]    ==>  [a,a+b]
--   sumsOf []       ==>  []
--
-- Use pattern matching and recursion (and the list constructors : and [])
-- 使用模式匹配和递归（以及列表构造器 : 和 []）

sumsOf :: [Int] -> [Int]
sumsOf = go 0
  where
    go _ [] = []
    go acc (y :ys ) = let acc' = acc + y
                        in  acc' : go acc' ys



------------------------------------------------------------------------------
-- Ex 7: implement the function merge that merges two sorted lists of
-- 练习7：实现函数 merge，将两个已排序的
-- Ints into a sorted list
-- Int 列表合并为一个排序列表
--
-- Use only pattern matching and recursion (and the list constructors : and [])
-- 只使用模式匹配和递归（以及列表构造器 : 和 []）
--
-- Examples:
-- 示例：
--   merge [1,3,5] [2,4,6] ==> [1,2,3,4,5,6]
--   merge [1,1,6] [1,2]   ==> [1,1,1,2,6]
--   merge [1,2,3,20] [7]  ==> [1,2,3,7,20]
--   merge [1] [2,3,4,5,6] ==> [1,2,3,4,5,6]

merge :: [Int] -> [Int] -> [Int]
merge xs   [] = xs
merge [] ys = ys 
merge (x:xs) (y:ys) = if x <= y then x : merge xs (y:ys)  else y : merge (x:xs) ys

------------------------------------------------------------------------------
-- Ex 8: compute the biggest element, using a comparison function
-- 练习8：计算最大元素，使用比较函数，
-- passed as an argument.
-- 该比较函数作为参数传入。
--
-- That is, implement the function mymaximum that takes
-- 也就是说，实现函数 mymaximum，它接受
--
-- * a function `bigger` :: a -> a -> Bool
-- * 一个函数 `bigger` :: a -> a -> Bool
-- * a value `initial` of type a
-- * 一个类型为 a 的值 `initial`
-- * a list `xs` of values of type a
-- * 一个类型为 a 的值列表 `xs`
--
-- and returns the biggest value it sees, considering both `initial`
-- 并返回它看到的最大值，同时考虑 `initial`
-- and all element in `xs`.
-- 和 `xs` 中的所有元素。
--
-- Examples:
-- 示例：
--   mymaximum (>) 3 [] ==> 3
--   mymaximum (>) 0 [1,3,2] ==> 3
--   mymaximum (>) 4 [1,3,2] ==> 4    -- initial value was biggest
--   mymaximum (<) 4 [1,3,2] ==> 1    -- note changed biggerThan
--   mymaximum (\(a,b) (c,d) -> b > d) ("",0) [("Banana",7),("Mouse",8)]
--     ==> ("Mouse",8)

mymaximum :: (a -> a -> Bool) -> a -> [a] -> a
mymaximum bigger initial [] = initial
mymaximum bigger initial (x:xs) =if  bigger initial x   then mymaximum bigger  initial xs else mymaximum bigger  x xs


------------------------------------------------------------------------------
-- Ex 9: define a version of map that takes a two-argument function
-- 练习9：定义一个接受双参数函数的 map 版本
-- and two lists. Example:
-- 和两个列表。示例：
--
--   map2 f [x,y,z,w] [a,b,c]  ==> [f x a, f y b, f z c]
--
-- If the lists have differing lengths, ignore the trailing elements
-- 如果列表长度不同，忽略较长列表中
-- of the longer list.
-- 多余的尾部元素。
--
-- Use recursion and pattern matching. Do not use any library functions.
-- 使用递归和模式匹配。不要使用任何库函数。

map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f [] bs = []
map2 f as [] = []
map2 f (a:as)  (b:bs)  =  f a b  : map2 f as bs 


------------------------------------------------------------------------------
-- Ex 10: implement the function maybeMap, which works a bit like a
-- 练习10：实现函数 maybeMap，它的工作方式有点像
-- combined map & filter.
-- map 和 filter 的组合。
---
--
-- maybeMap is given a list ([a]) and a function of type a -> Maybe b.
-- maybeMap 接收一个列表 ([a]) 和一个类型为 a -> Maybe b 的函数。
-- This function is called for all values in the list. If the function
-- 这个函数会对列表中的所有值进行调用。如果函数
-- returns Just x, x will be in the result list. If the function
-- 返回 Just x，x 将出现在结果列表中。如果函数
-- returns Nothing, no value gets added to the result list.
-- 返回 Nothing，则不会有值被添加到结果列表中。
--
-- Examples:
-- 示例：
--
-- let f x = if x>0 then Just (2*x) else Nothing
-- in maybeMap f [0,1,-1,4,-2,2]
--   ==> [2,8,4]
--
-- maybeMap Just [1,2,3]
--   ==> [1,2,3]
--
-- maybeMap (\x -> Nothing) [1,2,3]
--   ==> []

maybeMap :: (a -> Maybe b) -> [a] -> [b]
maybeMap f [] = []
maybeMap f (x:xs) = case f x of
    Just v  -> v : maybeMap f xs    
    Nothing -> maybeMap f xs        