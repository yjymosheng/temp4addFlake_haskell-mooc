-- Welcome to the first exercise set of the Haskell Mooc! Edit this
-- 欢迎来到 Haskell Mooc 的第一个练习集！编辑此
-- file according to the instructions, and check your answers with
-- 文件按照说明进行，并用以下命令检查你的答案
--
--   stack runhaskell Set1Test.hs
--   stack runhaskell Set1Test.hs
--
-- You can also play around with your answers in GHCi with
-- 你也可以在 GHCi 中尝试你的答案
--
--   stack ghci Set1.hs
--   stack ghci Set1.hs
--
-- This set contains exercises on
-- 本集包含以下练习
--   * defining functions
--   * 定义函数
--   * basic expressions
--   * 基本表达式
--   * pattern matching
--   * 模式匹配
--   * recursion
--   * 递归

module Set1 where

import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: define variables one and two. They should have type Int and
-- 练习1：定义变量 one 和 two。它们的类型应该是 Int，并且
-- values 1 and 2, respectively.
-- 值分别为 1 和 2。

------------------------------------------------------------------------------
-- Ex 2: define the function double of type Integer->Integer. Double
-- 练习2：定义类型为 Integer->Integer 的函数 double。Double
-- should take one argument and return it multiplied by two.
-- 应该接受一个参数并返回它乘以二的结果。

double :: Integer -> Integer
double x = todo

------------------------------------------------------------------------------
-- Ex 3: define the function quadruple that uses the function double
-- 练习3：定义函数 quadruple，使用上一个练习中的函数 double
-- from the previous exercise to return its argument multiplied by
-- 来返回其参数乘以
-- four.
-- 四的结果。

quadruple :: Integer -> Integer
quadruple x = todo

------------------------------------------------------------------------------
-- Ex 4: define the function distance. It should take four arguments of
-- 练习4：定义函数 distance。它应该接受四个
-- type Double: x1, y1, x2, and y2 and return the (euclidean) distance
-- Double 类型的参数：x1、y1、x2 和 y2，并返回点 (x1,y1) 和 (x2,y2) 之间的（欧几里得）距离
-- between points (x1,y1) and (x2,y2).
-- 之间的（欧几里得）距离。
--
-- Give distance a type signature, i.e. distance :: something.
-- 给 distance 一个类型签名，即 distance :: something。
--
-- PS. if you can't remember how the distance is computed, the formula is:
-- 附：如果你不记得距离是如何计算的，公式是：
--   square root of ((x distance) squared + (y distance) squared)
--   ((x 距离)的平方 + (y 距离)的平方) 的平方根
--
-- Examples:
-- 示例：
--   distance 0 0 1 1  ==>  1.4142135...
--   distance 0 0 1 1  ==>  1.4142135...
--   distance 1 1 4 5  ==>  5.0
--   distance 1 1 4 5  ==>  5.0

distance = todo

--------------------------------------------------------------------
- ---------
-- Ex 5: define the function eeny that ren inuts
-- 练习5：定义函数 ee and "meeny" for odd inputs.
-- 对于奇数输入返回 "meeny"。
--
-- Ps. have a look at the built in function "even"
-- 附：看一下内置函数 "even"

eeny :: Integer -> String
eeny = todo

------------------------------------------------------------------------------
-- Ex 6: here's the function checkPassword from the course material.
-- 练习6：这是课程材料中的函数 checkPassword。
-- Modify it so that it accepts two passwords, "swordfish" and
-- 修改它使其接受两个密码，"swordfish" 和
-- "mellon".
-- "mellon"。

checkPassword :: String -> String
checkPassword password =
  if password == "swordfish"
    then "You're in."
    else "ACCESS DENIED!"

------------------------------------------------------------------------------
-- Ex 7: A postal service prices packages the following way.
-- 练习7：邮政服务按以下方式对包裹定价。
-- Packages that weigh up to 500 grams cost 250 credits.
-- 重量不超过 500 克的包裹费用为 250 积分。
-- Packages over 500 and up to 5000 grams cost 300 credit + 1 credit per gram.
-- 重量超过 500 克且不超过 5000 克的包裹费用为 300 积分 + 每克 1 积分。
-- Packages over 5000 grams cost a constant 6000 credits.
-- 重量超过 5000 克的包裹费用固定为 6000 积分。
--
-- Write a function postagePrice that takes the weight of a package
-- 编写一个函数 postagePrice，接受包裹的重量
-- in grams, and returns the cost in credits.
-- （以克为单位），并返回费用（以积分为单位）。

postagePrice :: Int -> Int
postagePrice = todo

------------------------------------------------------------------------------
-- Ex 8: define a function isZero that returns True if it is given an
-- 练习8：定义一个函数 isZero，如果给定的
-- Integer that is 0, and False otherwise. Give isZero a type signature.
-- Integer 为 0 则返回 True，否则返回 False。给 isZero 一个类型签名。
--
-- Use pattern matching! Don't use comparisons!
-- 使用模式匹配！不要使用比较运算！
--
-- Ps. remember, the type of booleans in haskell is Bool
-- 附：记住，Haskell 中布尔值的类型是 Bool

isZero = todo

------------------------------------------------------------------------------
-- Ex 9: implement using recursion a function sumTo such that
-- 练习9：使用递归实现一个函数 sumTo，使得
--   sumTo n
--   sumTo n
-- computes the sum 1+2+...+n
-- 计算总和 1+2+...+n

sumTo :: Integer -> Integer
sumTo = todo

------------------------------------------------------------------------------
-- Ex 10: power n k should compute n to the power k (i.e. n^k)
-- 练习10：power n k 应该计算 n 的 k 次方（即 n^k）
-- Use recursion.
-- 使用递归。
-- There's no need to handle negative values of k.
-- 不需要处理 k 为负数的情况。

power :: Integer -> Integer -> Integer
power = todo

------------------------------------------------------------------------------
-- Ex 11: ilog3 n should be the number of times you can divide given
-- 练习11：ilog3 n 应该是你能将给定数字除以三的次数
-- number by three (rounding down) before you get 0.
-- （向下取整），直到得到 0 为止。
--
-- For example, ilog3 20 ==> 3 since
-- 例如，ilog3 20 ==> 3，因为
--   20/3 = 6.66 (gets rounded down to 6)
--   20/3 = 6.66（向下取整为 6）
--   6/3 = 2
--   6/3 = 2
--   2/3 = 0.666 (gets rounded down to 0)
--   2/3 = 0.666（向下取整为 0）
--
-- Use recursion to define ilog3. Use the function "div" for integer
-- 使用递归来定义 ilog3。使用函数 "div" 进行整数
-- division. It rounds down for you.
-- 除法。它会自动向下取整。
--
-- More examples:
-- 更多示例：
--   ilog3 2 ==> 1
--   ilog3 2 ==> 1
--   ilog3 7 ==> 2
--   ilog3 7 ==> 2

ilog3 :: Integer -> Integer
ilog3 = todo
