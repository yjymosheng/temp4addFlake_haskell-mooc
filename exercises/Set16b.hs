module Set16b where

import Mooc.Todo
import Examples.Phantom

import Data.Char (toUpper)

------------------------------------------------------------------------------
-- Ex 1: Define a constant pounds with type Money GBP and a value of
-- 练习1：定义一个类型为 Money GBP、值为
-- 3. The type Money is imported from Example.Phantom but you'll need
-- 3 的常量 pounds。Money 类型从 Example.Phantom 导入，但你需要
-- to introduce GBP yourself.
-- 自行引入 GBP。

pounds = todo

------------------------------------------------------------------------------
-- Ex 2: Implement composition for Rates. Give composeRates a
-- 练习2：实现 Rates 的组合。给 composeRates 一个
-- restricted type so that the currencies are tracked correctly.
-- 受限的类型，以便正确跟踪货币。
--
-- Examples:
-- 示例：
--   composeRates (Rate 1.5) (Rate 1.25) ==> Rate 1.875
--   composeRates (Rate 1.5) (Rate 1.25) ==> Rate 1.875
--   composeRates eurToUsd usdToChf :: Rate EUR CHF
--   composeRates eurToUsd usdToChf :: Rate EUR CHF
--   composeRates eurToUsd (invert eurToUsd) :: Rate EUR EUR
--   composeRates eurToUsd (invert eurToUsd) :: Rate EUR EUR
--   composeRates eurToUsd eurToUsd :: type error!
--   composeRates eurToUsd eurToUsd :: 类型错误！
--   composeRates eurToUsd :: Rate USD to -> Rate EUR to
--   composeRates eurToUsd :: Rate USD to -> Rate EUR to

-- For testing
-- 用于测试
usdToChf :: Rate USD CHF
usdToChf = Rate 1.11

composeRates rate1 rate2 = todo

------------------------------------------------------------------------------
-- Ex 3: Tracking first, last and full names with phantom types. The
-- 练习3：使用幻影类型跟踪名、姓和全名。
-- goal is to have the types:
-- 目标是拥有以下类型：
--  * Name First - for first names
--  * Name First - 用于名
--  * Name Last - for last names
--  * Name Last - 用于姓
--  * Name Full - for full names
--  * Name Full - 用于全名
--
-- In this exercise, you should define the phantom types First, Last
-- 在本练习中，你应该定义幻影类型 First、Last
-- and Full, and the parameterised type Name. Then implement the
-- 和 Full，以及参数化类型 Name。然后实现
-- functions fromName, toFirst and toLast. Give the functions the
-- 函数 fromName、toFirst 和 toLast。给这些函数
-- commented-out types
-- 注释掉的类型签名
--
-- Examples:
-- 示例：
--  fromName (toFirst "bob") ==> "bob"
--  fromName (toFirst "bob") ==> "bob"
--  fromName (toLast "smith") ==> "smith"
--  fromName (toLast "smith") ==> "smith"
--  toFirst "bob" :: Name First
--  toFirst "bob" :: Name First
--  toLast "smith" :: Name Last
--  toLast "smith" :: Name Last


-- Get the String contained in a name
-- 获取名称中包含的字符串
--fromName :: Name a -> String
fromName = todo

-- Build a Name First
-- 构建一个 Name First
--toFirst :: String -> Name First
toFirst = todo

-- Build a Name Last
-- 构建一个 Name Last
--toLast :: String -> Name Last
toLast = todo

------------------------------------------------------------------------------
-- Ex 4: Implement the functions capitalize and toFull.
-- 练习4：实现函数 capitalize 和 toFull。
--
-- toFull should combine a first and a last name into a full name. Give
-- toFull 应该将名和姓组合成全名。给
-- toFull the correct type (see examples below).
-- toFull 正确的类型（见下方示例）。
--
-- capitalize should capitalize the first letter of a name. Give
-- capitalize 应该将名称的首字母大写。给
-- capitalize the correct type (see examples below).
-- capitalize 正确的类型（见下方示例）。
--
-- Examples:
-- 示例：
--  toFull (toFirst "bob") (toLast "smith") :: Name Full
--  toFull (toFirst "bob") (toLast "smith") :: Name Full
--  fromName (toFull (toFirst "bob") (toLast "smith"))
--  fromName (toFull (toFirst "bob") (toLast "smith"))
--    ==> "bob smith"
--    ==> "bob smith"
--  capitalize (toFirst "bob") :: Name First
--  capitalize (toFirst "bob") :: Name First
--  fromName (capitalize (toFirst "bob")) ==> "Bob"
--  fromName (capitalize (toFirst "bob")) ==> "Bob"
--  capitalize (toLast "smith") :: Name Last
--  capitalize (toLast "smith") :: Name Last
--  fromName (capitalize (toLast "smith")) ==> "Smith"
--  fromName (capitalize (toLast "smith")) ==> "Smith"

capitalize = todo

toFull = todo

------------------------------------------------------------------------------
-- Ex 5: Type classes can let you write code that handles different
-- 练习5：类型类可以让你编写以不同方式处理不同
-- phantom types differently. Define instances for the Render type
-- 幻影类型的代码。为 Render 类型类定义实例，使得：
-- class such that:
-- （同上）
--
--  render (Money 1.0 :: Money EUR) ==> "1.0e"
--  render (Money 1.0 :: Money EUR) ==> "1.0e"
--  render (Money 1.0 :: Money USD) ==> "$1.0"
--  render (Money 1.0 :: Money USD) ==> "$1.0"
--  render (Money 1.0 :: Money CHF) ==> "1.0chf"
--  render (Money 1.0 :: Money CHF) ==> "1.0chf"

class Render currency where
  render :: Money currency -> String
