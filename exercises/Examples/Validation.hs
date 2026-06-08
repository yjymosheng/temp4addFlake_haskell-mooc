module Examples.Validation (Validation,invalid,check) where

import Control.Applicative
import Data.Char (isDigit)

data Validation a = Ok a | Errors [String]
  deriving (Show,Eq)

instance Functor Validation where
  fmap f (Ok x) = Ok (f x)
  fmap _ (Errors e) = Errors e

instance Applicative Validation where
  pure x = Ok x
  liftA2 f (Ok x)      (Ok y)      = Ok (f x y)
  liftA2 f (Errors e1) (Ok y)      = Errors e1
  liftA2 f (Ok x)      (Errors e2) = Errors e2
  liftA2 f (Errors e1) (Errors e2) = Errors (e1++e2)

invalid :: String -> Validation a
invalid err = Errors [err]

check :: Bool -> String -> a -> Validation a
check b err x
  | b = pure x
  | otherwise = invalid err

----
---- Example
---- 示例
----

birthday :: String -> Int -> Validation String
birthday name age = liftA2 congratulate checkedName checkedAge
  where checkedName = check (length name < 10) "Name too long" name
        checkedAge = check (age < 99) "Too old" age
        congratulate n a = "Happy "++show a++"th birthday "++n++"!"

-- birthday "Guy" 31
-- birthday "Guy" 31 的调用示例
--   ==> Ok "Happy 31th birthday Guy!"
--   ==> 结果为 Ok "Happy 31th birthday Guy!"
-- birthday "Guybrush Threepwood" 31
-- birthday "Guybrush Threepwood" 31 的调用示例
--   ==> Errors ["Name too long"]
--   ==> 结果为 Errors ["Name too long"]（名字过长）
-- birthday "Yog-sothoth" 10000
-- birthday "Yog-sothoth" 10000 的调用示例
--   ==> Errors ["Name too long","Too old"]
--   ==> 结果为 Errors ["Name too long","Too old"]（名字过长且年龄过大）

----
---- Example: validating lists
---- 示例：验证列表
----

-- via recursion
-- 通过递归实现
allPositive :: [Int] -> Validation [Int]
allPositive [] = Ok []
allPositive (x:xs) = liftA2 (:) checkThis checkRest
  where checkThis = check (x>=0) ("Not positive: "++show x) x
        checkRest = allPositive xs

-- allPositive [1,2,3] ==>  Ok [1,2,3]
-- allPositive [1,2,3] ==> Ok [1,2,3]（全部为正数，验证通过）
-- allPositive [1,2,3,-4] ==> Errors ["Not positive: -4"]
-- allPositive [1,2,3,-4] ==> Errors ["Not positive: -4"]（-4 不是正数）
-- allPositive [1,-2,3,-4] ==> Errors ["Not positive: -2","Not positive: -4"]
-- allPositive [1,-2,3,-4] ==> Errors ["Not positive: -2","Not positive: -4"]（-2 和 -4 不是正数）

-- via traverse
-- 通过 traverse 实现
allPositive' :: [Int] -> Validation [Int]
allPositive' xs = traverse checkNumber xs
  where checkNumber x = check (x>=0) ("Not positive: "++show x) x

---
--- Alternative instance
--- Alternative 实例
---

instance Alternative Validation where
  empty = Errors []
  Ok x <|> _ = Ok x
  Errors e1 <|> Ok y = Ok y
  Errors e1 <|> Errors e2 = Errors (e1++e2)

----
---- Example: parsing contact information:
---- 示例：解析联系信息：
----

data ContactInfo = Email String | Phone String
  deriving Show

validateEmail :: String -> Validation ContactInfo
validateEmail s = check (elem '@' s) "Not an email: should contain a @" (Email s)

checkLength :: String -> Validation ContactInfo
checkLength s = check (length s <= 10) "Not a phone number: should be at most 10 digits" (Phone s)

checkDigits :: String -> Validation ContactInfo
checkDigits s = check (all isDigit s) "Not a phone number: should be all numbers" (Phone s)

validatePhone :: String -> Validation ContactInfo
validatePhone s = checkDigits s *> checkLength s

validateContactInfo :: String -> Validation ContactInfo
validateContactInfo s = validateEmail s <|> validatePhone s

-- validateContactInfo "user@example.com"
-- 验证邮箱地址示例
--   ==> Ok (Email "user@example.com")
--   ==> 结果为 Ok (Email "user@example.com")
-- validateContactInfo "01234"
-- 验证电话号码示例
--   ==> Ok (Phone "01234")
--   ==> 结果为 Ok (Phone "01234")
-- validateContactInfo "01234567890"
-- 既非邮箱又非有效电话号码的示例
--   ==> Errors ["Not an email: should contain a @","Not a phone number: should be at most 10 digits"]
--   ==> 结果为 Errors ["Not an email: should contain a @"（缺少@符号）,"Not a phone number: should be at most 10 digits"（号码超过10位）]
-- validateContactInfo "01234567890x"
-- 包含非数字字符的无效输入示例
--   ==> Errors ["Not an email: should contain a @",
--   ==> 结果为 Errors ["Not an email: should contain a @"（缺少@符号），
--               "Not a phone number: should be all numbers",
--               "Not a phone number: should be all numbers"（包含非数字字符），
--               "Not a phone number: should be at most 10 digits"]
--               "Not a phone number: should be at most 10 digits"（号码超过10位）]
-- validateContactInfo "x"
-- 完全无效的输入示例
--   ==> Errors ["Not an email: should contain a @",
--   ==> 结果为 Errors ["Not an email: should contain a @"（缺少@符号），
--               "Not a phone number: should be all numbers"]
--               "Not a phone number: should be all numbers"（包含非数字字符）]
