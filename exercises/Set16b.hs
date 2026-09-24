module Set16b where

import Mooc.Todo
import Examples.Phantom

import Data.Char (toUpper)

------------------------------------------------------------------------------
-- Ex 1: Define a constant pounds with type Money GBP and a value of
-- 3. The type Money is imported from Example.Phantom but you'll need
-- to introduce GBP yourself.
--
-- 练习1：定义一个类型为 Money GBP、值为 3 的常量 pounds。Money 类型从
-- Example.Phantom 导入，但你需要自行引入 GBP。

pounds = todo

------------------------------------------------------------------------------
-- Ex 2: Implement composition for Rates. Give composeRates a
-- restricted type so that the currencies are tracked correctly.
--
-- 练习2：实现 Rates 的组合。给 composeRates 一个受限的类型，以便正确跟踪货币。
--
-- Examples:
--   composeRates (Rate 1.5) (Rate 1.25) ==> Rate 1.875
--   composeRates eurToUsd usdToChf :: Rate EUR CHF
--   composeRates eurToUsd (invert eurToUsd) :: Rate EUR EUR
--   composeRates eurToUsd eurToUsd :: type error!
--   composeRates eurToUsd :: Rate USD to -> Rate EUR to

-- For testing
usdToChf :: Rate USD CHF
usdToChf = Rate 1.11

composeRates rate1 rate2 = todo

------------------------------------------------------------------------------
-- Ex 3: Tracking first, last and full names with phantom types. The
-- goal is to have the types:
--  * Name First - for first names
--  * Name Last - for last names
--  * Name Full - for full names
-- In this exercise, you should define the phantom types First, Last
-- and Full, and the parameterised type Name. Then implement the
-- functions fromName, toFirst and toLast. Give the functions the
-- commented-out types
--
-- 练习3：使用幻影类型跟踪名、姓和全名。目标是拥有以下类型：
--  * Name First - 用于名
--  * Name Last - 用于姓
--  * Name Full - 用于全名
-- 在本练习中，你应该定义幻影类型 First、Last 和 Full，以及参数化类型 Name。
-- 然后实现函数 fromName、toFirst 和 toLast。给这些函数注释掉的类型签名。
--
-- Examples:
--  fromName (toFirst "bob") ==> "bob"
--  fromName (toLast "smith") ==> "smith"
--  toFirst "bob" :: Name First
--  toLast "smith" :: Name Last


-- Get the String contained in a name
--fromName :: Name a -> String
fromName = todo

-- Build a Name First
--toFirst :: String -> Name First
toFirst = todo

-- Build a Name Last
--toLast :: String -> Name Last
toLast = todo

------------------------------------------------------------------------------
-- Ex 4: Implement the functions capitalize and toFull.
-- toFull should combine a first and a last name into a full name. Give
-- toFull the correct type (see examples below).
-- capitalize should capitalize the first letter of a name. Give
-- capitalize the correct type (see examples below).
--
-- 练习4：实现函数 capitalize 和 toFull。
-- toFull 应该将名和姓组合成全名。给 toFull 正确的类型（见下方示例）。
-- capitalize 应该将名称的首字母大写。给 capitalize 正确的类型（见下方示例）。
--
-- Examples:
--  toFull (toFirst "bob") (toLast "smith") :: Name Full
--  fromName (toFull (toFirst "bob") (toLast "smith")) ==> "bob smith"
--  capitalize (toFirst "bob") :: Name First
--  fromName (capitalize (toFirst "bob")) ==> "Bob"
--  capitalize (toLast "smith") :: Name Last
--  fromName (capitalize (toLast "smith")) ==> "Smith"

capitalize = todo

toFull = todo

------------------------------------------------------------------------------
-- Ex 5: Type classes can let you write code that handles different
-- phantom types differently. Define instances for the Render type
-- class such that:
--
-- 练习5：类型类可以让你编写以不同方式处理不同幻影类型的代码。为 Render
-- 类型类定义实例，使得：
--
-- Examples:
--  render (Money 1.0 :: Money EUR) ==> "1.0e"
--  render (Money 1.0 :: Money USD) ==> "$1.0"
--  render (Money 1.0 :: Money CHF) ==> "1.0chf"

class Render currency where
  render :: Money currency -> String
