-- Exercise set 6: defining classes and instances
-- 练习集6：定义类型类和实例

module Set6 where

import Mooc.Todo
import Data.Char (toLower)

------------------------------------------------------------------------------
-- Ex 1: define an Eq instance for the type Country below. You'll need
-- 练习1：为下面的 Country 类型定义一个 Eq 实例。你需要
-- to use pattern matching.
-- 使用模式匹配。

data Country = Finland | Switzerland | Norway
  deriving Show

instance Eq Country where
  (==) = todo

------------------------------------------------------------------------------
-- Ex 2: implement an Ord instance for Country so that
-- 练习2：为 Country 实现一个 Ord 实例，使得
--   Finland <= Norway <= Switzerland
--   Finland <= Norway <= Switzerland
--
-- Remember minimal complete definitions!
-- 记住最小完整定义！

instance Ord Country where
  compare = todo -- implement me?
  (<=) = todo -- and me?
  min = todo -- and me?
  max = todo -- and me?

------------------------------------------------------------------------------
-- Ex 3: Implement an Eq instance for the type Name which contains a String.
-- 练习3：为包含 String 的 Name 类型实现 Eq 实例。
-- The Eq instance should ignore capitalization.
-- Eq 实例应该忽略大小写。
--
-- Hint: use the function Data.Char.toLower that has been imported for you.
-- 提示：使用已经为你导入的 Data.Char.toLower 函数。
--
-- Examples:
-- 示例：
--   Name "Pekka" == Name "pekka"   ==> True
--   Name "Pekka" == Name "pekka"   ==> True
--   Name "Pekka!" == Name "pekka"  ==> False
--   Name "Pekka!" == Name "pekka"  ==> False

data Name = Name String
  deriving Show

instance Eq Name where
  (==) = todo

------------------------------------------------------------------------------
-- Ex 4: here is a list type parameterized over the type it contains.
-- 练习4：这里是一个参数化列表类型，其参数为所包含的元素类型。
-- Implement an instance "Eq (List a)" that compares the lists element
-- 实现一个 "Eq (List a)" 实例，逐元素比较列表。
-- by element.
-- 逐元素。
--
-- Note how the instance needs an Eq a constraint. What happens if you
-- 注意该实例需要一个 Eq a 约束。如果你
-- remove it?
-- 去掉它会发生什么？

data List a = Empty | LNode a (List a)
  deriving Show

instance Eq a => Eq (List a) where
  (==) = todo

------------------------------------------------------------------------------
-- Ex 5: below you'll find two datatypes, Egg and Milk. Implement a
-- 练习5：下面你会找到两个数据类型，Egg 和 Milk。实现一个
-- type class Price, containing a function price. The price function
-- 类型类 Price，包含一个函数 price。price 函数
-- should return the price of an item.
-- 应该返回一个物品的价格。
--
-- The prices should be as follows:
-- 价格应该如下：
-- * chicken eggs cost 20
-- * 鸡蛋价格为 20
-- * chocolate eggs cost 30
-- * 巧克力蛋价格为 30
-- * milk costs 15 per liter
-- * 牛奶每升价格为 15
--
-- Example:
-- 示例：
--   price ChickenEgg  ==>  20
--   price ChickenEgg  ==>  20

data Egg = ChickenEgg | ChocolateEgg
  deriving Show
data Milk = Milk Int -- amount in litres
  deriving Show


------------------------------------------------------------------------------
-- Ex 6: define the necessary instance hierarchy in order to be able
-- 练习6：定义必要的实例层次结构，以便能够
-- to compute these:
-- 计算以下内容：
--
-- price (Just ChickenEgg) ==> 20
-- price (Just ChickenEgg) ==> 20
-- price [Milk 1, Milk 2]  ==> 45
-- price [Milk 1, Milk 2]  ==> 45
-- price [Just ChocolateEgg, Nothing, Just ChickenEgg]  ==> 50
-- price [Just ChocolateEgg, Nothing, Just ChickenEgg]  ==> 50
-- price [Nothing, Nothing, Just (Milk 1), Just (Milk 2)]  ==> 45
-- price [Nothing, Nothing, Just (Milk 1), Just (Milk 2)]  ==> 45


------------------------------------------------------------------------------
-- Ex 7: below you'll find the datatype Number, which is either an
-- 练习7：下面你会找到数据类型 Number，它要么是一个
-- Integer, or a special value Infinite.
-- Integer，要么是一个特殊值 Infinite。
--
-- Implement an Ord instance so that finite Numbers compare normally,
-- 实现一个 Ord 实例，使得有限的 Number 正常比较，
-- and Infinite is greater than any other value.
-- 而 Infinite 大于任何其他值。

data Number = Finite Integer | Infinite
  deriving (Show,Eq)


------------------------------------------------------------------------------
-- Ex 8: rational numbers have a numerator and a denominator that are
-- 练习8：有理数有一个分子和一个分母，它们是
-- integers, usually separated by a horizontal bar or a slash:
-- 整数，通常用横线或斜线分隔：
--
--      numerator
--        分子
--    -------------  ==  numerator / denominator
--    -------------  ==  分子 / 分母
--     denominator
--        分母
--
-- You may remember from school that two rationals a/b and c/d are
-- 你可能在学过，两个有理数 a/b 和 c/d
-- equal when a*d == b*c. Implement the Eq instance for rationals
-- 当 a*d == b*c 时相等。使用这个定义实现有理数的 Eq 实例
-- using this definition.
-- 使用这个定义。
--
-- You may assume in all exercises that the denominator is always
-- 在所有练习中你可以假设分母始终
-- positive and nonzero.
-- 为正且非零。
--
-- Examples:
-- 示例：
--   RationalNumber 4 5 == RationalNumber 4 5    ==> True
--   RationalNumber 4 5 == RationalNumber 4 5    ==> True
--   RationalNumber 12 15 == RationalNumber 4 5  ==> True
--   RationalNumber 12 15 == RationalNumber 4 5  ==> True
--   RationalNumber 13 15 == RationalNumber 4 5  ==> False
--   RationalNumber 13 15 == RationalNumber 4 5  ==> False

data RationalNumber = RationalNumber Integer Integer
  deriving Show

instance Eq RationalNumber where
  p == q = todo

------------------------------------------------------------------------------
-- Ex 9: implement the function simplify, which simplifies a rational
-- 练习9：实现函数 simplify，它通过约去分子和分母的公因数来化简有理数。
-- number by removing common factors of the numerator and denominator.
-- 通过约去分子和分母的公因数来化简有理数。
-- In other words,
-- 换句话说，
--
--     ca         a
--     ca         a
--    ----  ==>  ---
--    ----  ==>  ---
--     cb         b
--     cb         b
--
-- As a concrete example,
-- 作为一个具体例子，
--
--     12        3 * 4         4
--     12        3 * 4         4
--    ----  ==  -------  ==>  ---.
--    ----  ==  -------  ==>  ---.
--     15        3 * 5         5
--     15        3 * 5         5
--
-- Hint: Remember the function gcd?
-- 提示：还记得 gcd 函数吗？

simplify :: RationalNumber -> RationalNumber
simplify p = todo

------------------------------------------------------------------------------
-- Ex 10: implement the typeclass Num for RationalNumber. The results
-- 练习10：为 RationalNumber 实现 Num 类型类。加法和乘法的结果
-- of addition and multiplication must be simplified.
-- 必须经过化简。
--
-- Reminders:
-- 提醒：
--   * negate x is 0-x
--   * negate x 是 0-x
--   * abs is absolute value
--   * abs 是绝对值
--   * signum is -1, +1 or 0 depending on the sign of the input
--   * signum 根据输入的符号返回 -1、+1 或 0
--
-- Examples:
-- 示例：
--   RationalNumber 1 3 + RationalNumber 1 6 ==> RationalNumber 1 2
--   RationalNumber 1 3 + RationalNumber 1 6 ==> RationalNumber 1 2
--   RationalNumber 1 3 * RationalNumber 3 1 ==> RationalNumber 1 1
--   RationalNumber 1 3 * RationalNumber 3 1 ==> RationalNumber 1 1
--   negate (RationalNumber 2 3)             ==> RationalNumber (-2) 3
--   negate (RationalNumber 2 3)             ==> RationalNumber (-2) 3
--   fromInteger 17 :: RationalNumber        ==> RationalNumber 17 1
--   fromInteger 17 :: RationalNumber        ==> RationalNumber 17 1
--   abs (RationalNumber (-3) 2)             ==> RationalNumber 3 2
--   abs (RationalNumber (-3) 2)             ==> RationalNumber 3 2
--   signum (RationalNumber (-3) 2)          ==> RationalNumber (-1) 1
--   signum (RationalNumber (-3) 2)          ==> RationalNumber (-1) 1
--   signum (RationalNumber 0 2)             ==> RationalNumber 0 1
--   signum (RationalNumber 0 2)             ==> RationalNumber 0 1

instance Num RationalNumber where
  p + q = todo
  p * q = todo
  abs q = todo
  signum q = todo
  fromInteger x = todo
  negate q = todo

------------------------------------------------------------------------------
-- Ex 11: a class for adding things. Define a class Addable with a
-- 练习11：一个用于相加的类型类。定义一个类 Addable，包含
-- constant `zero` and a function `add`. Define instances of Addable
-- 常量 `zero` 和函数 `add`。为 Integer 和列表定义 Addable 的实例。
-- for Integers and lists. Numbers are added with the usual addition,
-- 数字使用通常的加法相加，
-- while lists are added by catenating them. Pick a value for `zero`
-- 而列表通过拼接相加。为 `zero` 选择一个值，
-- such that: `add zero x == x`
-- 使得：`add zero x == x`
--
-- Examples:
-- 示例：
--   add 1 2                ==>  3
--   add 1 2                ==>  3
--   add 1 zero             ==>  1
--   add 1 zero             ==>  1
--   add [1,2] [3,4]        ==>  [1,2,3,4]
--   add [1,2] [3,4]        ==>  [1,2,3,4]
--   add zero [True,False]  ==>  [True,False]
--   add zero [True,False]  ==>  [True,False]


------------------------------------------------------------------------------
-- Ex 12: cycling. Implement a type class Cycle that contains a
-- 练习12：循环。实现一个类型类 Cycle，包含
-- function `step` that cycles through the values of the type.
-- 一个函数 `step`，用于在类型的值之间循环。
-- Implement instances for Color and Suit that work like this:
-- 为 Color 和 Suit 实现实例，工作方式如下：
--
--   step Red ==> Green
--   step Red ==> Green
--   step Green ==> Blue
--   step Green ==> Blue
--   step Blue ==> Red
--   step Blue ==> Red
--
-- The suit instance should cycle suits in the order Club, Spade,
-- Suit 实例应该按照 Club、Spade、
-- Diamond, Heart, Club.
-- Diamond、Heart、Club 的顺序循环。
--
-- Also add a function `stepMany` to the class and give it a default
-- 还要在类中添加一个函数 `stepMany`，并给它一个默认
-- implementation using `step`. The function `stepMany` should take
-- 实现，使用 `step`。函数 `stepMany` 应该执行
-- multiple (determined by an Int argument) steps like this:
-- 多步（由 Int 参数决定），如下所示：
--
--   stepMany 2 Club ==> Diamond
--   stepMany 2 Club ==> Diamond
--   stepMany 3 Diamond ==> Spade
--   stepMany 3 Diamond ==> Spade
--
-- The tests will test the Cycle class and your default implementation
-- 测试将通过添加如下实例来测试 Cycle 类和你的 stepMany 默认实现
-- of stepMany by adding an instance like this:
-- 通过添加如下实例：
--
--    instance Cycle Int where
--      step = succ

data Color = Red | Green | Blue
  deriving (Show, Eq)
data Suit = Club | Spade | Diamond | Heart
  deriving (Show, Eq)
