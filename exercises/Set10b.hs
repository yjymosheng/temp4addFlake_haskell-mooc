-- This exercise set hides most of Prelude. You only have access to
-- 本练习集隐藏了大部分 Prelude。你只能使用
-- the Bool, Int and list types, and pattern matching.
-- Bool、Int 和列表类型，以及模式匹配。
--
-- In particular, seq is not available, so you must use pattern
-- 特别注意，seq 不可用，因此你必须使用模式
-- matching to force evaluation!
-- 匹配来强制求值！

{-# LANGUAGE NoImplicitPrelude #-}

module Set10b where

import Mooc.VeryLimitedPrelude
import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: Define the operator ||| that works like ||, but forces its
-- 练习1：定义运算符 |||，其功能与 || 类似，但强制求值的是
-- _right_ argument instead of the left one.
-- _右_参数而不是左参数。
--
-- Examples:
-- 示例：
--   False ||| False     ==> False
--   False ||| False     ==> False
--   True ||| False      ==> True
--   True ||| False      ==> True
--   undefined ||| True  ==> True
--   undefined ||| True  ==> True
--   False ||| undefined ==> an error!
--   False ||| undefined ==> 一个错误！

(|||) :: Bool -> Bool -> Bool
x ||| True = True
x ||| False = x


------------------------------------------------------------------------------
-- Ex 2: Define the function boolLength, that returns the length of a
-- 练习2：定义函数 boolLength，返回一个
-- list of booleans and forces all of the elements
-- 布尔值列表的长度，并强制求值所有元素
--
-- Examples:
-- 示例：
--   boolLength [False,True,False] ==> 3
--   boolLength [False,True,False] ==> 3
--   boolLength [False,undefined]  ==> an error!
--   boolLength [False,undefined]  ==> 一个错误！
--
-- Note that with the ordinary length function,
-- 注意，使用普通的 length 函数时，
--   length [False,undefined] ==> 2
--   length [False,undefined] ==> 2

boolLength :: [Bool] -> Int
boolLength []     = 0
boolLength (x:xs) = case x of
                      False -> 1 + boolLength xs
                      True  -> 1 + boolLength xs

------------------------------------------------------------------------------
-- Ex 3: Define the function validate which, given a predicate and a
-- 练习3：定义函数 validate，给定一个谓词和一个
-- value, evaluates to the value. However, validate should also force the
-- 值，求值结果为该值。但是，validate 还应该强制求值
-- result of `predicate value`, even though it is not used.
-- `predicate value` 的结果，即使该结果未被使用。
--
-- Examples:
-- 示例：
--   validate even 3               ==>  3
--   validate even 3               ==>  3
--   validate odd 3                ==>  3
--   validate odd 3                ==>  3
--   validate undefined 3          ==>  an error!
--   validate undefined 3          ==>  一个错误！
--   validate (\x -> undefined) 3  ==>  an error!
--   validate (\x -> undefined) 3  ==>  一个错误！

validate :: (a -> Bool) -> a -> a
validate predicate value = case  predicate value of
                                  False -> value
                                  True  -> value

------------------------------------------------------------------------------
-- Ex 4: Even though we can't implement the generic seq function
-- 练习4：虽然我们无法自己实现通用的 seq 函数，
-- ourselves, we can implement it manually for specific datatypes.
-- 但我们可以为特定的数据类型手动实现它。
--
-- The type class MySeq contains the method myseq which is supposed to
-- 类型类 MySeq 包含方法 myseq，它应该
-- work like the built-in seq function. Implement the given MySeq
-- 的工作方式与内置的 seq 函数相同。实现给定的 MySeq
-- instances.
-- 实例。
--
-- Just like in the course material, we use the special value
-- 正如课程材料中一样，我们使用特殊值
-- `undefined` here to illustrate what myseq evaluates. The tests for
-- `undefined` 来说明 myseq 的求值行为。本练习的
-- this exercise also use undefined.
-- 测试也使用了 undefined。
--
-- Examples:
-- 示例：
--   myseq True  0 ==> 0
--   myseq True  0 ==> 0
--   myseq ((\x -> x) True) 0 ==> 0
--   myseq ((\x -> x) True) 0 ==> 0
--   myseq (undefined :: Bool) 0
--   myseq (undefined :: Bool) 0
--     ==> *** Exception: Prelude.undefined
--     ==> *** 异常：Prelude.undefined
--   myseq (3::Int) True ==> True
--   myseq (3::Int) True ==> True
--   myseq (undefined::Int) True
--   myseq (undefined::Int) True
--     ==> *** Exception: Prelude.undefined
--     ==> *** 异常：Prelude.undefined
--   myseq [1,2] 'z' ==> 'z'
--   myseq [1,2] 'z' ==> 'z'
--   myseq [undefined] 'z' ==> 'z'           -- [undefined] is in WHNF
--   myseq [undefined] 'z' ==> 'z'           -- [undefined] 处于 WHNF
--   myseq (1:undefined) 'z' ==> 'z'         -- 1:undefined is in WHNF
--   myseq (1:undefined) 'z' ==> 'z'         -- 1:undefined 处于 WHNF
--   myseq (undefined:[2,3]) 'z' ==> 'z'     -- undefined:[2,3] is in WHNF
--   myseq (undefined:[2,3]) 'z' ==> 'z'     -- undefined:[2,3] 处于 WHNF
--   myseq [1..] 'z' ==> 'z'
--   myseq [1..] 'z' ==> 'z'
--   myseq (undefined::[Int]) 'z'
--   myseq (undefined::[Int]) 'z'
--     ==> *** Exception: Prelude.undefined
--     ==> *** 异常：Prelude.undefined

class MySeq a where
  myseq :: a -> b -> b

instance MySeq Bool where
  myseq  True b =   b 
  myseq  False  b =   b 

instance MySeq Int where
  -- myseq = todo
  myseq  0 b =   b 
  myseq  _ b =   b 



instance MySeq [a] where
  -- myseq = todo
  myseq []     b = b
  myseq (_:_)  b = b   -- 匹配 Cons 构造器3