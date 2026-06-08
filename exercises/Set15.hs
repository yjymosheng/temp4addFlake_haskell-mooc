module Set15 where

import Mooc.Todo
import Examples.Validation

import Control.Applicative
import Data.Char
import Text.Read (readMaybe)

------------------------------------------------------------------------------
-- Ex 1: Sum two Maybe Int values using Applicative operations (i.e.
-- 练习1：使用 Applicative 操作（即
-- liftA2 and pure). Don't use pattern matching.
-- liftA2 和 pure）对两个 Maybe Int 值求和。不要使用模式匹配。
--
-- Examples:
-- 示例：
--  sumTwoMaybes (Just 1) (Just 2)  ==> Just 3
--  sumTwoMaybes (Just 1) (Just 2)  ==> Just 3
--  sumTwoMaybes (Just 1) Nothing   ==> Nothing
--  sumTwoMaybes (Just 1) Nothing   ==> Nothing
--  sumTwoMaybes Nothing Nothing    ==> Nothing
--  sumTwoMaybes Nothing Nothing    ==> Nothing

sumTwoMaybes :: Maybe Int -> Maybe Int -> Maybe Int
sumTwoMaybes = todo

------------------------------------------------------------------------------
-- Ex 2: Given two lists of words, xs and ys, generate all statements
-- 练习2：给定两个单词列表 xs 和 ys，生成所有
-- of the form "x is [not] y". Use Applicative
-- 形如 "x is [not] y" 的语句。使用 Applicative
-- operations like liftA2!
-- 操作如 liftA2！
--
-- The order of the results doesn't matter.
-- 结果的顺序不重要。
--
-- Examples:
-- 示例：
--  statements ["beauty"] ["suffering"]
--  statements ["beauty"] ["suffering"]
--    ==> ["beauty is suffering","beauty is not suffering"]
--    ==> ["beauty is suffering","beauty is not suffering"]
--  statements ["beauty","code"] ["suffering","life"]
--  statements ["beauty","code"] ["suffering","life"]
--    ==> ["beauty is suffering","beauty is life",
--    ==> ["beauty is suffering","beauty is life",
--         "beauty is not suffering","beauty is not life",
--         "beauty is not suffering","beauty is not life",
--         "code is suffering","code is life",
--         "code is suffering","code is life",
--         "code is not suffering","code is not life"]
--         "code is not suffering","code is not life"]

statements :: [String] -> [String] -> [String]
statements = todo

------------------------------------------------------------------------------
-- Ex 3: A simple calculator with error handling. Given an operation
-- 练习3：一个带错误处理的简单计算器。给定一个操作
-- (negate or double) and a number, as strings, compute the result.
-- （negate 或 double）和一个数字，均为字符串，计算结果。
-- Return Nothing for an unknown operation or invalid number.
-- 对于未知操作或无效数字返回 Nothing。
--
-- Use Applicative operations, don't use pattern matching.
-- 使用 Applicative 操作，不要使用模式匹配。
--
-- Hint: remember the function readMaybe
-- 提示：记住函数 readMaybe
--
-- Examples:
-- 示例：
--  calculator "negate" "3"   ==> Just (-3)
--  calculator "negate" "3"   ==> Just (-3)
--  calculator "double" "7"   ==> Just 14
--  calculator "double" "7"   ==> Just 14
--  calculator "doubl" "7"    ==> Nothing
--  calculator "doubl" "7"    ==> Nothing
--  calculator "double" "7x"  ==> Nothing
--  calculator "double" "7x"  ==> Nothing

calculator :: String -> String -> Maybe Int
calculator = todo

------------------------------------------------------------------------------
-- Ex 4: Safe division. Implement the function validateDiv that
-- 练习4：安全除法。实现函数 validateDiv，
-- divides two integers, but returns an error ("Division by zero!") if
-- 将两个整数相除，但如果除数为零则返回错误
-- the divisor is zero.
-- （"Division by zero!"）。
--
-- NB! The constructors of Validation are not exported, so you can't
-- 注意！Validation 的构造器没有被导出，所以你不能
-- pattern match on Validation, you must use the Applicative methods
-- 对 Validation 进行模式匹配，你必须使用 Applicative 方法
-- and the invalid and check functions.
-- 以及 invalid 和 check 函数。
--
-- Examples:
-- 示例：
--  validateDiv 6 2 ==> Ok 3
--  validateDiv 6 2 ==> Ok 3
--  validateDiv 6 0 ==> Errors ["Division by zero!"]
--  validateDiv 6 0 ==> Errors ["Division by zero!"]
--  validateDiv 0 3 ==> Ok 0
--  validateDiv 0 3 ==> Ok 0

validateDiv :: Int -> Int -> Validation Int
validateDiv = todo

------------------------------------------------------------------------------
-- Ex 5: Validating street addresses. A street address consists of a
-- 练习5：验证街道地址。街道地址由
-- street name, a street number, and a postcode.
-- 街道名称、街道号码和邮政编码组成。
--
-- Implement the function validateAddress which constructs an Address
-- 实现函数 validateAddress，如果输入有效则构造一个 Address
-- value if the input is valid:
-- 值：
--
-- * Street length should be at most 20 characters
-- * 街道名称长度最多为 20 个字符
--   (if not, error "Invalid street name")
--   （否则，错误 "Invalid street name"）
-- * Street number should only contain digits
-- * 街道号码应只包含数字
--   (if not, error "Invalid street number")
--   （否则，错误 "Invalid street number"）
-- * Postcode should be exactly five digits long
-- * 邮政编码应恰好为五位数字
--   (if not, error "Invalid postcode")
--   （否则，错误 "Invalid postcode"）
--
-- Examples:
-- 示例：
--  validateAddress "Haskell road" "35" "13337"
--  validateAddress "Haskell road" "35" "13337"
--    ==> Ok (Address "Haskell road" "35" "13337")
--    ==> Ok (Address "Haskell road" "35" "13337")
--  validateAddress "Haskell road" "35a" "13337"
--  validateAddress "Haskell road" "35a" "13337"
--    ==> Errors ["Invalid street number"]
--    ==> Errors ["Invalid street number"]
--  validateAddress "Haskell road" "35a" "1333"
--  validateAddress "Haskell road" "35a" "1333"
--    ==> Errors ["Invalid street number","Invalid postcode"]
--    ==> Errors ["Invalid street number","Invalid postcode"]
--  validateAddress "Haskeller's favourite road" "35a" "1333"
--  validateAddress "Haskeller's favourite road" "35a" "1333"
--    ==> Errors ["Invalid street name","Invalid street number","Invalid postcode"]
--    ==> Errors ["Invalid street name","Invalid street number","Invalid postcode"]

data Address = Address String String String
  deriving (Show,Eq)

validateAddress :: String -> String -> String -> Validation Address
validateAddress streetName streetNumber postCode = todo

------------------------------------------------------------------------------
-- Ex 6: Given the names, ages and employment statuses of two
-- 练习6：给定两个人的姓名、年龄和就业状态，
-- persons, wrapped in Applicatives, return a list of two Person
-- 包装在 Applicative 中，返回一个包含两个 Person
-- values, wrapped in an applicative.
-- 值的列表，也包装在 Applicative 中。
--
-- Examples:
-- 示例：
--  twoPersons (Just "Clarice") (Just 35) (Just True) (Just "Hannibal") (Just 50) (Just False)
--  twoPersons (Just "Clarice") (Just 35) (Just True) (Just "Hannibal") (Just 50) (Just False)
--    ==> Just [Person "Clarice" 35 True,Person "Hannibal" 50 False]
--    ==> Just [Person "Clarice" 35 True,Person "Hannibal" 50 False]
--  twoPersons (Just "Clarice") (Just 35) (Just True) (Just "Hannibal") Nothing (Just False)
--  twoPersons (Just "Clarice") (Just 35) (Just True) (Just "Hannibal") Nothing (Just False)
--    ==> Nothing
--    ==> Nothing
--  twoPersons ["Clarice"] [25,35] [True] ["Hannibal"] [50] [False]
--  twoPersons ["Clarice"] [25,35] [True] ["Hannibal"] [50] [False]
--    ==> [[Person "Clarice" 25 True,Person "Hannibal" 50 False],
--    ==> [[Person "Clarice" 25 True,Person "Hannibal" 50 False],
--         [Person "Clarice" 35 True,Person "Hannibal" 50 False]]
--         [Person "Clarice" 35 True,Person "Hannibal" 50 False]]

data Person = Person String Int Bool
  deriving (Show, Eq)

twoPersons :: Applicative f =>
  f String -> f Int -> f Bool -> f String -> f Int -> f Bool
  -> f [Person]
twoPersons name1 age1 employed1 name2 age2 employed2 = todo

------------------------------------------------------------------------------
-- Ex 7: Validate a String that's either a Bool or an Int. The return
-- 练习7：验证一个字符串是 Bool 还是 Int。函数的返回
-- type of the function uses Either Bool Int to be able to represent
-- 类型使用 Either Bool Int 来表示
-- both cases. Use <|> to combine two validators and to produce two
-- 两种情况。使用 <|> 组合两个验证器，如果值既不是 Int 也不是 Bool，
-- errors if the value is not an Int or a Bool.
-- 则产生两个错误。
--
-- Hint: remember readMaybe
-- 提示：记住 readMaybe
--
-- PS. The tests won't test special cases of Int literals like hexadecimal
-- 附：测试不会测试 Int 字面量的特殊情况，如十六进制
-- (0x3a) or octal (0o14).
-- （0x3a）或八进制（0o14）。
--
-- Examples:
-- 示例：
--  boolOrInt "True"    ==> Ok (Left True)
--  boolOrInt "True"    ==> Ok (Left True)
--  boolOrInt "13"      ==> Ok (Right 13)
--  boolOrInt "13"      ==> Ok (Right 13)
--  boolOrInt "13.2"    ==> Errors ["Not a Bool","Not an Int"]
--  boolOrInt "13.2"    ==> Errors ["Not a Bool","Not an Int"]
--  boolOrInt "Falseb"  ==> Errors ["Not a Bool","Not an Int"]
--  boolOrInt "Falseb"  ==> Errors ["Not a Bool","Not an Int"]

boolOrInt :: String -> Validation (Either Bool Int)
boolOrInt = todo

------------------------------------------------------------------------------
-- Ex 8: Improved phone number validation. Implement the function
-- 练习8：改进的电话号码验证。实现函数
-- normalizePhone that, given a String:
-- normalizePhone，给定一个字符串：
--
-- * removes all spaces from the string
-- * 移除字符串中的所有空格
-- * checks that there are at most 10 remaining characters
-- * 检查剩余字符最多为 10 个
-- * checks that all remaining characters are digits, and logs an
-- * 检查所有剩余字符是否为数字，并为每个无效字符
--   error for every nonvalid character
--   记录一个错误
-- * returns the string, stripped of whitespace, if no errors
-- * 如果没有错误，返回去除空格后的字符串
--
-- Examples:
-- 示例：
--  normalizePhone "123 456 78" ==> Ok "12345678"
--  normalizePhone "123 456 78" ==> Ok "12345678"
--  normalizePhone "123 4x6 78"
--  normalizePhone "123 4x6 78"
--    ==> Errors ["Invalid character: x"]
--    ==> Errors ["Invalid character: x"]
--  normalizePhone "123 4x6 7y"
--  normalizePhone "123 4x6 7y"
--    ==> Errors ["Invalid character: x","Invalid character: y"]
--    ==> Errors ["Invalid character: x","Invalid character: y"]
--  normalizePhone "123 4x6 7y 999"
--  normalizePhone "123 4x6 7y 999"
--    ==> Errors ["Too long","Invalid character: x","Invalid character: y"]
--    ==> Errors ["Too long","Invalid character: x","Invalid character: y"]
--  normalizePhone "123 456 78 999"
--  normalizePhone "123 456 78 999"
--    ==> Errors ["Too long"]
--    ==> Errors ["Too long"]

normalizePhone :: String -> Validation String
normalizePhone = todo

------------------------------------------------------------------------------
-- Ex 9: Parsing expressions. The Expression type describes an
-- 练习9：解析表达式。Expression 类型描述一种
-- arithmetic expression that has an operator (+ or -) and two
-- 具有运算符（+ 或 -）和两个参数的算术表达式，
-- arguments that can be either numbers or single-letter variables.
-- 参数可以是数字或单字母变量。
-- The operator and the arguments are always separated by spaces. Here
-- 运算符和参数之间总是用空格分隔。以下
-- are some examples of expressions like this: 1 + 2, y + 7, z - w
-- 是此类表达式的一些示例：1 + 2, y + 7, z - w
--
-- Implement the function parseExpression that uses the Validation
-- 实现函数 parseExpression，使用 Validation
-- applicative to convert strings like "y + 7" to Expression values
-- applicative 将 "y + 7" 这样的字符串转换为
-- like Plus (Variable 'y') (Number 7).
-- Plus (Variable 'y') (Number 7) 这样的 Expression 值。
--
-- The parser should produce the following errors:
-- 解析器应产生以下错误：
--  * For operators other than + or -: "Unknown operator: %"
--  * 对于非 + 或 - 的运算符："Unknown operator: %"
--  * For variables that aren't single letters: "Invalid variable: xy"
--  * 对于非单字母的变量："Invalid variable: xy"
--  * For arguments that aren't numbers: "Invalid number: 1x" --
--  * 对于非数字的参数："Invalid number: 1x" --
--  * For expressions that don't consist of three words:
--  * 对于不包含三个单词的表达式：
--    "Invalid expression: 1 + 2 +"
--    "Invalid expression: 1 + 2 +"
--    "Invalid expression: 1 -"
--    "Invalid expression: 1 -"
--
-- Hint: The functions `words` and `isAlpha`
-- 提示：函数 `words` 和 `isAlpha`
--
-- Hint: If you have problems with the ordering of errors, remember
-- 提示：如果你在错误顺序上有问题，请记住
-- that Validation collects errors left-to-right!
-- Validation 从左到右收集错误！
--
-- Examples:
-- 示例：
--  parseExpression "1 + 2" ==> Ok (Plus (Number 1) (Number 2))
--  parseExpression "1 + 2" ==> Ok (Plus (Number 1) (Number 2))
--  parseExpression "z - A" ==> Ok (Minus (Variable 'z') (Variable 'A'))
--  parseExpression "z - A" ==> Ok (Minus (Variable 'z') (Variable 'A'))
--  parseExpression "1 * 2" ==> Errors ["Unknown operator: *"]
--  parseExpression "1 * 2" ==> Errors ["Unknown operator: *"]
--  parseExpression "1 + 2x"
--  parseExpression "1 + 2x"
--    ==> Errors ["Invalid number: 2x","Invalid variable: 2x"]
--    ==> Errors ["Invalid number: 2x","Invalid variable: 2x"]
--  parseExpression ". % 2x"
--  parseExpression ". % 2x"
--    ==> Errors ["Unknown operator: %",
--    ==> Errors ["Unknown operator: %",
--                "Invalid number: .","Invalid variable: .",
--                "Invalid number: .","Invalid variable: .",
--                "Invalid number: 2x","Invalid variable: 2x"]
--                "Invalid number: 2x","Invalid variable: 2x"]

data Arg = Number Int | Variable Char
  deriving (Show, Eq)

data Expression = Plus Arg Arg | Minus Arg Arg
  deriving (Show, Eq)

parseExpression :: String -> Validation Expression
parseExpression = todo

------------------------------------------------------------------------------
-- Ex 10: The Priced T type tracks a value of type T, and a price
-- 练习10：Priced T 类型跟踪一个类型为 T 的值和一个价格
-- (represented by an Int). Implement the Functor and Applicative
-- （由 Int 表示）。实现 Priced 的 Functor 和 Applicative
-- instances for Priced. They should work like this:
-- 实例。它们应该这样工作：
--
-- * Transforming a Priced value with fmap keeps the price the same
-- * 使用 fmap 转换 Priced 值时保持价格不变
-- * pure should create a value with price 0
-- * pure 应创建价格为 0 的值
-- * liftA2 should sum the prices of the things to be combined
-- * liftA2 应将待组合值的价格相加
--
-- Examples:
-- 示例：
--  fmap reverse (Priced 3 "abc")
--  fmap reverse (Priced 3 "abc")
--    ==> Priced 3 "cba"
--    ==> Priced 3 "cba"
--  liftA2 (*) (pure 2) (pure 3) :: Priced Int
--  liftA2 (*) (pure 2) (pure 3) :: Priced Int
--    ==> Priced 0 6
--    ==> Priced 0 6
--  liftA2 (+) (Priced 1 3) (Priced 1 5)
--  liftA2 (+) (Priced 1 3) (Priced 1 5)
--    ==> Priced 2 8
--    ==> Priced 2 8
--  traverse (\x -> Priced (length x) x) ["abc","de","f"]
--  traverse (\x -> Priced (length x) x) ["abc","de","f"]
--    ==> Priced 6 ["abc","de","f"]
--    ==> Priced 6 ["abc","de","f"]

data Priced a = Priced Int a
  deriving (Show, Eq)

instance Functor Priced where
  fmap = todo

instance Applicative Priced where
  pure = todo
  liftA2 = todo

------------------------------------------------------------------------------
-- Ex 11: This and the next exercise will use a copy of the
-- 练习11：本练习和下一个练习将使用
-- Applicative type class called MyApplicative. MyApplicative lacks
-- Applicative 类型类的副本 MyApplicative。MyApplicative 缺少
-- the Functor requirement that Applicative has, and also the <*> type
-- Applicative 所需的 Functor 约束，以及 <*> 类型
-- class method. You'll get to implement them instead.
-- 类方法。你需要自己实现它们。
--
-- First you'll reimplement <*> using liftA2. In practical terms,
-- 首先你将使用 liftA2 重新实现 <*>。具体来说，
-- implement the operator <#> that works like <*>, using myPure and
-- 实现 <#> 操作符，其功能类似 <*>，使用 myPure 和
-- myLiftA2.
-- myLiftA2。
--
-- As long as you get the types right, your implementation is pretty
-- 只要类型正确，你的实现基本
-- much guaranteed to be correct.
-- 上就保证是正确的。
--
-- Examples:
-- 示例：
--  Just succ <#> Just 2      ==> Just 3
--  Just succ <#> Just 2      ==> Just 3
--  Nothing <#> Just 2        ==> Nothing
--  Nothing <#> Just 2        ==> Nothing
--  [(*2),(+1)] <#> [10,100]  ==> [20,200,11,101]
--  [(*2),(+1)] <#> [10,100]  ==> [20,200,11,101]

class MyApplicative f where
  myPure :: a -> f a
  myLiftA2 :: (a -> b -> c) -> f a -> f b -> f c

-- Some instances for testing:
-- 一些用于测试的实例：
instance MyApplicative Maybe where
  myPure = pure
  myLiftA2 = liftA2
instance MyApplicative [] where
  myPure = pure
  myLiftA2 = liftA2

(<#>) :: MyApplicative f => f (a -> b) -> f a -> f b
f <#> x = todo

------------------------------------------------------------------------------
-- Ex 12: Reimplement fmap using liftA2 and pure. In practical terms,
-- 练习12：使用 liftA2 和 pure 重新实现 fmap。具体来说，
-- implement the function myFmap below using the methods myPure and
-- 使用 MyApplicative 类型类中的 myPure 和
-- myLiftA2 from the type class MyApplicative.
-- myLiftA2 方法实现下面的函数 myFmap。
--
-- As long as you get the types right, your implementation is pretty
-- 只要类型正确，你的实现基本
-- much guaranteed to be correct. However, this time there are a
-- 上就保证是正确的。不过，这次有
-- couple of different possible implementations!
-- 几种不同的可能实现！
--
-- Examples:
-- 示例：
--  myFmap negate (Just 1) ==> Just (-1)
--  myFmap negate (Just 1) ==> Just (-1)
--  myFmap negate Nothing  ==> Nothing
--  myFmap negate Nothing  ==> Nothing
--  myFmap negate [1,2,3]  ==> [-1,-2,-3]
--  myFmap negate [1,2,3]  ==> [-1,-2,-3]

myFmap :: MyApplicative f => (a -> b) -> f a -> f b
myFmap = todo

------------------------------------------------------------------------------
-- Ex 13: Given a function that returns an Alternative value, and a
-- 练习13：给定一个返回 Alternative 值的函数和一个
-- list, try the function on all the elements in the list and produce
-- 列表，对该列表中的所有元素尝试该函数，并产生
-- any successes.
-- 所有成功的结果。
--
-- Hint: traverse won't help you since it succeeds only if all the
-- 提示：traverse 不会帮助你，因为它只有在所有
-- calls succeed. You need to use <|>.
-- 调用都成功时才成功。你需要使用 <|>。
--
-- Examples:
-- 示例：
--
--   The Maybe Applicative returns the first success:
--   Maybe Applicative 返回第一个成功的结果：
--     tryAll (\x -> if x>0 then pure x else empty) [0,3,2] :: Maybe Int
--     tryAll (\x -> if x>0 then pure x else empty) [0,3,2] :: Maybe Int
--       ==> Just 3
--       ==> Just 3
--     tryAll (\x -> if x>0 then pure x else empty) [0,-1,0] :: Maybe Int
--     tryAll (\x -> if x>0 then pure x else empty) [0,-1,0] :: Maybe Int
--       ==> Nothing
--       ==> Nothing
--   The list Applicative returns all successes:
--   列表 Applicative 返回所有成功的结果：
--     tryAll (\x -> if x>0 then pure x else empty) [0,3,2] :: [Int]
--     tryAll (\x -> if x>0 then pure x else empty) [0,3,2] :: [Int]
--       ==> [3,2]
--       ==> [3,2]
--   The Validation Applicative returns the first success or all errors:
--   Validation Applicative 返回第一个成功结果或所有错误：
--     tryAll (\x -> if x>0 then pure x else invalid "zero") [0,3,2]
--     tryAll (\x -> if x>0 then pure x else invalid "zero") [0,3,2]
--       ==> Ok 3
--       ==> Ok 3
--     tryAll (\x -> if x>0 then pure x else invalid "zero") [0,0,0]
--     tryAll (\x -> if x>0 then pure x else invalid "zero") [0,0,0]
--       ==> Errors ["zero","zero","zero"]
--       ==> Errors ["zero","zero","zero"]

tryAll :: Alternative f => (a -> f b) -> [a] -> f b
tryAll = todo

------------------------------------------------------------------------------
-- Ex 14: Here's the type `Both` that expresses the composition of
-- 练习14：这里有一个类型 `Both`，它表示
-- functors. Here are some example values and types:
-- 函子的组合。以下是一些示例值和类型：
--
--   Both (Just [True])                    :: Both Maybe [] Bool
--   Both (Just [True])                    :: Both Maybe [] Bool
--   Both [Just True, Nothing, Just False] :: Both [] Maybe Bool
--   Both [Just True, Nothing, Just False] :: Both [] Maybe Bool
--   Both [[True,False],[]]                :: Both [] [] Bool
--   Both [[True,False],[]]                :: Both [] [] Bool
--
--   Both (Ok (Just "value"))       :: Both Validation Maybe String
--   Both (Ok (Just "value"))       :: Both Validation Maybe String
--   Both (Just (Errors ["wrong"])) :: Both Maybe Validation a
--   Both (Just (Errors ["wrong"])) :: Both Maybe Validation a
--
-- Implement a Functor instance for Both f g, given that f and g are
-- 为 Both f g 实现 Functor 实例，假设 f 和 g 都是
-- both Functors.
-- Functor。
--
-- Examples:
-- 示例：
--  fmap not (Both (Just [True]))     ==> Both (Just [False])
--  fmap not (Both (Just [True]))     ==> Both (Just [False])
--  fmap not (Both [Nothing])         ==> Both [Nothing]
--  fmap not (Both [Nothing])         ==> Both [Nothing]
--  fmap (+1) (Both [[1,2,3],[4,5]])  ==> Both [[2,3,4],[5,6]]
--  fmap (+1) (Both [[1,2,3],[4,5]])  ==> Both [[2,3,4],[5,6]]

newtype Both f g a = Both (f (g a))
  deriving Show

instance (Functor f, Functor g) => Functor (Both f g) where
  fmap = todo

------------------------------------------------------------------------------
-- Ex 15: The composition of two Applicatives is also an Applicative!
-- 练习15：两个 Applicative 的组合也是一个 Applicative！
-- Implement the instance Applicative (Both f g) (given that f and g
-- 实现 Applicative (Both f g) 实例（假设 f 和 g
-- are already Applicatives).
-- 已经是 Applicative）。
--
-- Again, there's only one way to implement this that gets the types
-- 同样，只有一种实现方式能让类型
-- right.
-- 正确。
--
-- Examples:
-- 示例：
--  pure 1 :: Both Maybe [] Int
--  pure 1 :: Both Maybe [] Int
--    ==> Both (Just [1])
--    ==> Both (Just [1])
--  liftA2 (+) (Both (Just [10,100])) (Both (Just [1,2]))
--  liftA2 (+) (Both (Just [10,100])) (Both (Just [1,2]))
--    ==> Both (Just [11,12,101,102])
--    ==> Both (Just [11,12,101,102])
--  liftA2 (+) (Both (Just [10,100])) (Both Nothing)
--  liftA2 (+) (Both (Just [10,100])) (Both Nothing)
--    ==> Both Nothing
--    ==> Both Nothing
--  liftA2 (&&) (Both (Just (invalid "err"))) (Both (Just (pure True)))
--  liftA2 (&&) (Both (Just (invalid "err"))) (Both (Just (pure True)))
--    ==> Both (Just (Errors ["err"]))
--    ==> Both (Just (Errors ["err"]))
--  liftA2 (&&) (Both (Just (invalid "err"))) (Both (Just (invalid "umm")))
--  liftA2 (&&) (Both (Just (invalid "err"))) (Both (Just (invalid "umm")))
--    ==> Both (Just (Errors ["err","umm"]))
--    ==> Both (Just (Errors ["err","umm"]))
--  liftA2 (+) (Both [pure 1, invalid "fail 1"])
--  liftA2 (+) (Both [pure 1, invalid "fail 1"])
--             (Both [pure 10, pure 100, invalid "fail 2"])
--             (Both [pure 10, pure 100, invalid "fail 2"])
--    ==> Both [Ok 11,Ok 101,Errors ["fail 2"],
--    ==> Both [Ok 11,Ok 101,Errors ["fail 2"],
--              Errors ["fail 1"],Errors ["fail 1"],
--              Errors ["fail 1"],Errors ["fail 1"],
--              Errors ["fail 1","fail 2"]]
--              Errors ["fail 1","fail 2"]]

instance (Applicative f, Applicative g) => Applicative (Both f g) where
  pure = todo
  liftA2 = todo
