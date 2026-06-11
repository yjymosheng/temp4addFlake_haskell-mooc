module Set2b where

import Mooc.Todo

-- Some imports you'll need. Don't add other imports :)
-- 一些你需要的导入。不要添加其他导入 :)
import Data.List

------------------------------------------------------------------------------
-- Ex 1: compute binomial coefficients using recursion. Binomial
-- 练习1：使用递归计算二项式系数。二项式
-- coefficients are defined by the following equations:
-- 系数由以下等式定义：
--
--   B(n,k) = B(n-1,k) + B(n-1,k-1)
--   B(n,k) = B(n-1,k) + B(n-1,k-1)
--   B(n,0) = 1
--   B(n,0) = 1
--   B(0,k) = 0, when k>0
--   B(0,k) = 0，当 k>0 时
--
-- Hint! pattern matching is your friend.
-- 提示！模式匹配是你的好朋友。

binomial :: Integer -> Integer -> Integer
binomial  n 0  = 1
binomial  0 k = 0
binomial  n k  = binomial (n-1) k + binomial (n-1) (k-1)



------------------------------------------------------------------------------
-- Ex 2: implement the odd factorial function. Odd factorial is like
-- 练习2：实现奇数阶乘函数。奇数阶乘类似于
-- factorial, but it only multiplies odd numbers.
-- 阶乘，但它只乘奇数。
--
-- Examples:
-- 示例：
--   oddFactorial 7 ==> 7*5*3*1 ==> 105
--   oddFactorial 7 ==> 7*5*3*1 ==> 105
--   oddFactorial 6 ==> 5*3*1 ==> 15
--   oddFactorial 6 ==> 5*3*1 ==> 15

oddFactorial :: Integer -> Integer
oddFactorial x = product [1,3..x]

------------------------------------------------------------------------------
-- Ex 3: implement the Euclidean Algorithm for finding the greatest
-- 练习3：实现欧几里得算法来寻找最大
-- common divisor:
--公约数：
--
-- Given two numbers, a and b,
-- 给定两个数 a 和 b，
-- * if one is zero, return the other number
-- * 如果其中一个为零，返回另一个数
-- * if not, subtract the smaller number from the larger one
-- * 如果不为零，用较大的数减去较小的数
-- * replace the larger number with this new number
-- * 用这个新数替换较大的数
-- * repeat
-- * 重复
--
-- For example,
-- 例如，
--   myGcd 9 12 ==> 3
--   myGcd 9 12 ==> 3
-- In this case, the algorithm proceeds like this
-- 在这种情况下，算法的执行过程如下
--
--   a      b
--   a      b
--
--   9      12
--   9      12
--   9      (12-9)
--   9      (12-9)
--   9      3
--   9      3
--   (9-3)  3
--   (9-3)  3
--   6      3
--   6      3
--   (6-3)  3
--   (6-3)  3
--   3      3
--   3      3
--   (3-3)  3
--   (3-3)  3
--   0      3
--   0      3
--
-- Background reading:
-- 背景阅读：
-- * https://en.wikipedia.org/wiki/Euclidean_algorithm
-- * https://en.wikipedia.org/wiki/Euclidean_algorithm

myGcd :: Integer -> Integer -> Integer
myGcd a 0 =  a
myGcd 0 b =  b
myGcd a b =  if a > b then myGcd (a-b) b else myGcd a (b-a)

------------------------------------------------------------------------------
-- Ex 4: Implement the function leftpad which adds space characters
-- 练习4：实现函数 leftpad，它在字符串开头添加空格字符
-- to the start of the string until it is long enough.
-- 直到字符串达到指定长度。
--
-- Examples:
-- 示例：
--   leftpad "foo" 5 ==> "  foo"
--   leftpad "foo" 5 ==> "  foo"
--   leftpad "13" 3 ==> " 13"
--   leftpad "13" 3 ==> " 13"
--   leftpad "xxxxx" 3 ==> "xxxxx"
--   leftpad "xxxxx" 3 ==> "xxxxx"
--
-- Tips:
-- 提示：
-- * you can combine strings with the ++ operator.
-- * 你可以用 ++ 运算符拼接字符串。
-- * you can compute the length of a string with the length function
-- * 你可以用 length 函数计算字符串的长度

leftpad :: String -> Int -> String
leftpad str len = replicate (len - length str) ' ' ++ str

------------------------------------------------------------------------------
-- Ex 5: let's make a countdown for a rocket! Given a number, you
-- 练习5：让我们为火箭做一个倒计时！给定一个数字，你
-- should produce a string that says "Ready!", counts down from the
-- 应该生成一个字符串，先说 "Ready!"，然后从
-- number, and then says "Liftoff!".
-- 该数字开始倒计时，最后说 "Liftoff!"。
--
-- For example,
-- 例如，
--   countdown 4 ==> "Ready! 4... 3... 2... 1... Liftoff!"
--   countdown 4 ==> "Ready! 4... 3... 2... 1... Liftoff!"
--
-- Hints:
-- 提示：
-- * you can combine strings with the ++ operator
-- * 你可以用 ++ 运算符拼接字符串
-- * you can use the show function to convert a number into a string
-- * 你可以用 show 函数将数字转换为字符串
-- * you'll probably need a recursive helper function
-- * 你可能需要一个递归辅助函数

countdown :: Integer -> String
countdown n = "Ready! " ++ concat (f n) ++ "Liftoff!"
    where
        f s = [show s ++ "... " | s <- [s,s-1..1]]


------------------------------------------------------------------------------
-- Ex 6: implement the function smallestDivisor that returns the
-- 练习6：实现函数 smallestDivisor，返回
-- smallest number (greater than 1) that divides the given number evenly.
-- 能整除给定数字的最小数（大于1）。
--
-- That is, when
-- 也就是说，当
--   smallestDivisor n ==> k
--   smallestDivisor n ==> k
-- we have
-- 我们有
--   n = t*k
--   n = t*k
-- for some t.
-- 对于某个 t。
--
-- Ps. your function doesn't need to work for inputs 0 and 1, but
-- 附：你的函数不需要处理输入 0 和 1 的情况，但
-- remember this in the next exercise!
-- 在下一个练习中要记住这一点！
--
-- Hint: remember the mod function!
-- 提示：记住 mod 函数！

smallestDivisor :: Integer -> Integer
smallestDivisor n =  head  [ s |  s <- [2..n] ,   n `mod` s ==0  ]
    

------------------------------------------------------------------------------
-- Ex 7: implement a function isPrime that checks if the given number
-- 练习7：实现一个函数 isPrime，检查给定的数字
-- is a prime number. Use the function smallestDivisor.
-- 是否为质数。使用函数 smallestDivisor。
--
-- Ps. 0 and 1 are not prime numbers
-- 附：0 和 1 不是质数

isPrime :: Integer -> Bool
isPrime 0  = False
isPrime 1 = False
isPrime n = smallestDivisor n == n 

------------------------------------------------------------------------------
-- Ex 8: implement a function biggestPrimeAtMost that returns the
-- 练习8：实现一个函数 biggestPrimeAtMost，返回
-- biggest prime number that is less than or equal to the given
-- 小于或等于给定数字的最大
-- number. Use the function isPrime you just defined.
-- 质数。使用你刚刚定义的函数 isPrime。
--
-- You don't need to care about arguments less than 2. Any behaviour
-- 你不需要关心小于 2 的参数。任何行为
-- for them is fine.
-- 都可以。
--
-- Examples:
-- 示例：
--   biggestPrimeAtMost 3 ==> 3
--   biggestPrimeAtMost 3 ==> 3
--   biggestPrimeAtMost 10 ==> 7
--   biggestPrimeAtMost 10 ==> 7

biggestPrimeAtMost :: Integer -> Integer
biggestPrimeAtMost 2  =  2 
biggestPrimeAtMost  n =  if isPrime  n  then  n else  biggestPrimeAtMost (n-1)
