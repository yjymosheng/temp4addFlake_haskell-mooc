module Set16a where

import Mooc.Todo
import Test.QuickCheck

import Data.List

------------------------------------------------------------------------------
-- Ex 1: Write a Property that checks that a given list is sorted (in
-- 练习1：编写一个 Property，检查给定的列表是否已排序（按
-- ascending order)
-- 升序）
--
-- Examples:
-- 示例：
--  *Set16a> quickCheck (isSorted [1,2,3])
--  *Set16a> quickCheck (isSorted [1,2,3])
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。
--  *Set16a> quickCheck (isSorted [1,3,2])
--  *Set16a> quickCheck (isSorted [1,3,2])
--  *** Failed! Falsified (after 1 test):
--  *** 失败！被证伪（经过 1 个测试后）：
--  *Set16a> quickCheck (isSorted [])
--  *Set16a> quickCheck (isSorted [])
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。

isSorted :: (Show a, Ord a) => [a] -> Property
isSorted = todo

------------------------------------------------------------------------------
-- Ex 2: In this and the following exercises, we'll build a suite of
-- 练习2：在本练习及后续练习中，我们将构建一组
-- tests for testing a function
-- 测试，用于测试一个函数
--
--   frequencies :: Eq a => [a] -> [(a,Int)]
--   frequencies :: Eq a => [a] -> [(a,Int)]
--
-- That counts how many times each element occurs in a list.
-- 该函数计算列表中每个元素出现的次数。
--
-- The tests will be properties that check that a given input (of type
-- 这些测试将是属性，用于检查给定的输入（类型为
-- [a]) and output (of type [(a,Int)]) have a certain relationship.
-- [a]）和输出（类型为 [(a,Int)]）之间具有某种关系。
--
-- For this exercise, implement a Property that checks that the sum
-- 在本练习中，实现一个 Property，检查
-- all the Ints in the output is the length of the input.
-- 输出中所有 Int 的总和等于输入的长度。
--
-- Examples:
-- 示例：
-- (the exact output of the test doesn't matter, only whether it passes)
-- （测试的确切输出不重要，只关心它是否通过）
--
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('b',2)])
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('b',2)])
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('x',3),('z',-1)])
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('x',3),('z',-1)])
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('b',1)])
--  *Set16a> quickCheck (sumIsLength "abb" [('a',1),('b',1)])
--  *** Failed! Falsified (after 1 test):
--  *** 失败！被证伪（经过 1 个测试后）：
--  3 /= 2
--  3 /= 2
--  *Set16a> quickCheck (sumIsLength "" [])
--  *Set16a> quickCheck (sumIsLength "" [])
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。
--  *Set16a> quickCheck (sumIsLength [4,5,6,4,5,4] (freq1 [4,5,6,4,5,4]))
--  *Set16a> quickCheck (sumIsLength [4,5,6,4,5,4] (freq1 [4,5,6,4,5,4]))
--  +++ OK, passed 1 test.
--  +++ OK，通过了 1 个测试。

sumIsLength :: Show a => [a] -> [(a,Int)] -> Property
sumIsLength input output = todo

-- This is a function that passes the sumIsLength test but is wrong
-- 这是一个通过了 sumIsLength 测试但结果错误的函数
freq1 :: Eq a => [a] -> [(a,Int)]
freq1 [] = []
freq1 [x] = [(x,1)]
freq1 (x:y:xs) = [(x,1),(y,length xs + 1)]

------------------------------------------------------------------------------
-- Ex 3: Implement a Property that takes an arbitrary element from the
-- 练习3：实现一个 Property，从输入中任取一个元素，
-- input, and checks that it occurs in the output.
-- 并检查它是否出现在输出中。
--
-- You can assume that the input is nonempty.
-- 你可以假设输入是非空的。
--
-- Hint: Use forAll to pick an element from the input.
-- 提示：使用 forAll 从输入中选取一个元素。
--
-- Examples:
-- 示例：
--  *Set16a> quickCheck (inputInOutput "abb" [('a',1),('b',2)])
--  *Set16a> quickCheck (inputInOutput "abb" [('a',1),('b',2)])
--  +++ OK, passed 100 tests.
--  +++ OK，通过了 100 个测试。
--  *Set16a> quickCheck (inputInOutput "abb" [('a',1),('x',3),('z',-1)])
--  *Set16a> quickCheck (inputInOutput "abb" [('a',1),('x',3),('z',-1)])
--  *** Failed! Falsified (after 1 test):
--  *** 失败！被证伪（经过 1 个测试后）：
--  'b'
--  'b'
--  *Set16a> quickCheck (inputInOutput [4,5,6,4,5,4] (freq1 [4,5,6,4,5,4]))
--  *Set16a> quickCheck (inputInOutput [4,5,6,4,5,4] (freq1 [4,5,6,4,5,4]))
--  *** Failed! Falsified (after 3 tests):
--  *** 失败！被证伪（经过 3 个测试后）：
--  6
--  6
--  *Set16a> quickCheck (inputInOutput [4,5,6,4,5,4] (freq2 [4,5,6,4,5,4]))
--  *Set16a> quickCheck (inputInOutput [4,5,6,4,5,4] (freq2 [4,5,6,4,5,4]))
--  +++ OK, passed 100 tests.
--  +++ OK，通过了 100 个测试。

inputInOutput :: (Show a, Eq a) => [a] -> [(a,Int)] -> Property
inputInOutput input output = todo

-- This function passes both the sumIsLength and inputInOutput tests
-- 这个函数同时通过了 sumIsLength 和 inputInOutput 测试
freq2 :: Eq a => [a] -> [(a,Int)]
freq2 xs = map (\x -> (x,1)) xs

------------------------------------------------------------------------------
-- Ex 4: Implement a Property that takes a pair (x,n) from the
-- 练习4：实现一个 Property，从输出中取一个对 (x,n)，
-- output, and checks that x occurs n times in the input.
-- 并检查 x 在输入中出现了 n 次。
--
-- You can assume that the output is nonempty.
-- 你可以假设输出是非空的。
--
-- Examples:
-- 示例：
--  *Set16a> quickCheck (outputInInput "abb" [('a',1)])
--  *Set16a> quickCheck (outputInInput "abb" [('a',1)])
--  +++ OK, passed 100 tests.
--  +++ OK，通过了 100 个测试。
--  *Set16a> quickCheck (outputInInput "abb" [('a',1),('x',3)])
--  *Set16a> quickCheck (outputInInput "abb" [('a',1),('x',3)])
--  *** Failed! Falsified (after 1 test):
--  *** 失败！被证伪（经过 1 个测试后）：
--  ('x',3)
--  ('x',3)
--  0 /= 3
--  0 /= 3
--  *Set16a> quickCheck (outputInInput "abb" [('a',1),('b',3)])
--  *Set16a> quickCheck (outputInInput "abb" [('a',1),('b',3)])
--  *** Failed! Falsified (after 3 tests):
--  *** 失败！被证伪（经过 3 个测试后）：
--  ('b',3)
--  ('b',3)
--  2 /= 3
--  2 /= 3
--  *Set16a> quickCheck (outputInInput [4,5,6,4,5,4] (freq2 [4,5,6,4,5,4]))
--  *Set16a> quickCheck (outputInInput [4,5,6,4,5,4] (freq2 [4,5,6,4,5,4]))
--  *** Failed! Falsified (after 1 test):
--  *** 失败！被证伪（经过 1 个测试后）：
--  (4,1)
--  (4,1)
--  3 /= 1
--  3 /= 1
--  *Set16a> quickCheck (outputInInput [4,5,6,4,5,4] (freq3 [4,5,6,4,5,4]))
--  *Set16a> quickCheck (outputInInput [4,5,6,4,5,4] (freq3 [4,5,6,4,5,4]))
--  +++ OK, passed 100 tests.
--  +++ OK，通过了 100 个测试。

outputInInput :: (Show a, Eq a) => [a] -> [(a,Int)] -> Property
outputInInput input output = todo

-- This function passes the outputInInput test but not the others
-- 这个函数通过了 outputInInput 测试但未通过其他测试
freq3 :: Eq a => [a] -> [(a,Int)]
freq3 [] = []
freq3 (x:xs) = [(x,1 + length (filter (==x) xs))]

------------------------------------------------------------------------------
-- Ex 5: Implement a Property that takes a candidate function freq, a
-- 练习5：实现一个 Property，接受一个候选函数 freq、一个
-- NonEmptyList Char input, and checks that all the three properties
-- NonEmptyList Char 输入，并检查所有三个属性
-- (sumIsLength, inputInOutput and outputInInput) hold between the
-- （sumIsLength、inputInOutput 和 outputInInput）在
-- input and the output from freq.
-- 输入和 freq 的输出之间是否成立。
--
-- Hint: Use conjoin or (.&&.) to "and" together properties.
-- 提示：使用 conjoin 或 (.&&.) 将属性"与"在一起。
--
-- Examples:
-- 示例：
--  *Set16a> quickCheck (frequenciesProp freq1)
--  *Set16a> quickCheck (frequenciesProp freq1)
--  *** Failed! Falsified (after 5 tests and 5 shrinks):
--  *** 失败！被证伪（经过 5 个测试和 5 次缩小后）：
--  ...
--  ...
--  *Set16a> quickCheck (frequenciesProp freq2)
--  *Set16a> quickCheck (frequenciesProp freq2)
--  *** Failed! Falsified (after 20 tests and 2 shrinks):
--  *** 失败！被证伪（经过 20 个测试和 2 次缩小后）：
--  ...
--  ...
--  *Set16a> quickCheck (frequenciesProp freq3)
--  *Set16a> quickCheck (frequenciesProp freq3)
--  *** Failed! Falsified (after 1 test and 2 shrinks):
--  *** 失败！被证伪（经过 1 个测试和 2 次缩小后）：
--  ...
--  ...
--  *Set16a> quickCheck (frequenciesProp frequencies)
--  *Set16a> quickCheck (frequenciesProp frequencies)
--  +++ OK, passed 100 tests.
--  +++ OK，通过了 100 个测试。

frequenciesProp :: ([Char] -> [(Char,Int)]) -> NonEmptyList Char -> Property
frequenciesProp freq input = todo

frequencies :: Eq a => [a] -> [(a,Int)]
frequencies [] = []
frequencies (x:ys) = (x, length xs) : frequencies others
  where (xs,others) = partition (==x) (x:ys)

------------------------------------------------------------------------------
-- Ex 6: Write a generator for lists that have these properties:
-- 练习6：编写一个生成器，生成具有以下属性的列表：
-- * length 3-5
-- * 长度为 3-5
-- * elements are numbers from 0 to 10
-- * 元素为 0 到 10 的数字
-- * the list is sorted
-- * 列表已排序
--
-- Hints: Remember the generators `elements` and `choose`, but also
-- 提示：记住生成器 `elements` 和 `choose`，但也
-- check out `vectorOf`, and don't be afraid to use `sort`.
-- 看看 `vectorOf`，不要害怕使用 `sort`。
--
-- Example:
-- 示例：
--  *Set16a> sample genList
--  *Set16a> sample genList
--  [0,1,2,8]
--  [0,1,2,8]
--  [3,5,7,8,10]
--  [3,5,7,8,10]
--  [6,7,9]
--  [6,7,9]
--  [2,2,3]
--  [2,2,3]
--  [0,5,7,10]
--  [0,5,7,10]
--  [5,8,10]
--  [5,8,10]
--  [1,6,8]
--  [1,6,8]
--  [1,5,8,9]
--  [1,5,8,9]
--  [2,3,4,6,8]
--  [2,3,4,6,8]
--  [0,1,8]
--  [0,1,8]
--  [2,4,10]
--  [2,4,10]

genList :: Gen [Int]
genList = todo

------------------------------------------------------------------------------
-- Ex 7: Here are the datatypes Arg and Expression from Set 15. Write
-- 练习7：以下是第 15 套练习中的数据类型 Arg 和 Expression。编写
-- Arbitrary instances for Expression and Arg such that:
-- Expression 和 Arg 的 Arbitrary 实例，使得：
--
-- * All combinations of Plus, Minus, Number, Variable are produced
-- * 能生成 Plus、Minus、Number、Variable 的所有组合
-- * All numbers are in the range 0-10
-- * 所有数字在 0-10 范围内
-- * All variables are one of a,b,c,x,y,z
-- * 所有变量是 a、b、c、x、y、z 之一
--
-- You don't need to implement shrink, just arbitrary.
-- 你不需要实现 shrink，只需实现 arbitrary。
--
-- Hint: use
-- 提示：使用
--   oneof :: [Gen a] -> Gen a
--   oneof :: [Gen a] -> Gen a
-- to randomly pick from a set of generators
-- 从一组生成器中随机选择
--
-- Examples:
-- 示例：
--  *Set16a> sample (arbitrary :: Gen Arg)
--  *Set16a> sample (arbitrary :: Gen Arg)
--  Number 3
--  Number 3
--  Variable 'c'
--  Variable 'c'
--  Variable 'z'
--  Variable 'z'
--  Number 5
--  Number 5
--  Number 6
--  Number 6
--  Variable 'x'
--  Variable 'x'
--  *Set16a> sample (arbitrary :: Gen Expression)
--  *Set16a> sample (arbitrary :: Gen Expression)
--  Minus (Variable 'b') (Variable 'c')
--  Minus (Variable 'b') (Variable 'c')
--  Plus (Variable 'c') (Number 0)
--  Plus (Variable 'c') (Number 0)
--  Minus (Number 0) (Variable 'c')
--  Minus (Number 0) (Variable 'c')
--  Minus (Number 0) (Number 7)
--  Minus (Number 0) (Number 7)
--  Minus (Number 8) (Number 5)
--  Minus (Number 8) (Number 5)

data Arg = Number Int | Variable Char
  deriving (Show, Eq)

data Expression = Plus Arg Arg | Minus Arg Arg
  deriving (Show, Eq)

instance Arbitrary Arg where
  arbitrary = todo

instance Arbitrary Expression where
  arbitrary = todo
