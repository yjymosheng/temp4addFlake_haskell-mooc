-- Exercise set 7
-- 练习集 7

module Set7 where

import Mooc.Todo
import Data.List
import Data.List.NonEmpty (NonEmpty ((:|)))
import Data.Monoid
import Data.Semigroup

------------------------------------------------------------------------------
-- Ex 1: you'll find below the types Time, Distance and Velocity,
-- 练习1：你将在下面找到 Time、Distance 和 Velocity 类型，
-- which represent time, distance and velocity in seconds, meters and
-- 它们分别以秒、米和米每秒来表示时间、距离和速度。
-- meters per second.
-- 米每秒。
--
-- Implement the functions below.
-- 实现下面的函数。

data Distance = Distance Double
  deriving (Show,Eq)

data Time = Time Double
  deriving (Show,Eq)

data Velocity = Velocity Double
  deriving (Show,Eq)

-- velocity computes a velocity given a distance and a time
-- velocity 根据给定的距离和时间计算速度
velocity :: Distance -> Time -> Velocity
velocity = todo

-- travel computes a distance given a velocity and a time
-- travel 根据给定的速度和时间计算距离
travel :: Velocity -> Time -> Distance
travel = todo

------------------------------------------------------------------------------
-- Ex 2: let's implement a simple Set datatype. A Set is a list of
-- 练习2：让我们实现一个简单的 Set 数据类型。Set 是一个
-- unique elements. The set is always kept ordered.
-- 唯一元素的列表。集合始终保持有序。
--
-- Implement the functions below. You might need to add class
-- 实现下面的函数。你可能需要添加类
-- constraints to the functions' types.
-- 约束到函数的类型中。
--
-- Examples:
-- 示例：
--   member 'a' (Set ['a','b','c'])  ==>  True
--   member 'a' (Set ['a','b','c'])  ==>  True
--   add 2 (add 3 (add 1 emptySet))  ==>  Set [1,2,3]
--   add 2 (add 3 (add 1 emptySet))  ==>  Set [1,2,3]
--   add 1 (add 1 emptySet)  ==>  Set [1]
--   add 1 (add 1 emptySet)  ==>  Set [1]

data Set a = Set [a]
  deriving (Show,Eq)

-- emptySet is a set with no elements
-- emptySet 是一个没有元素的集合
emptySet :: Set a
emptySet = todo

-- member tests if an element is in a set
-- member 测试一个元素是否在集合中
member :: Eq a => a -> Set a -> Bool
member = todo

-- add a member to a set
-- 向集合中添加一个成员
add :: a -> Set a -> Set a
add = todo

------------------------------------------------------------------------------
-- Ex 3: a state machine for baking a cake. The type Event represents
-- 练习3：烤蛋糕的状态机。Event 类型表示
-- things that can happen while baking a cake. The type State is meant
-- 烤蛋糕时可能发生的事情。State 类型用于
-- to represent the states a cake can be in.
-- 表示蛋糕可能处于的状态。
--
-- Your job is to
-- 你的任务是
--
--  * add new states to the State type
--  * 向 State 类型添加新状态
--  * and implement the step function
--  * 并实现 step 函数
--
-- so that they have the following behaviour:
-- 使它们具有以下行为：
--
--  * Baking starts in the Start state
--  * 烘焙从 Start 状态开始
--  * A successful cake (reperesented by the Finished value) is baked
--  * 一个成功的蛋糕（由 Finished 值表示）是通过
--    by first adding eggs, then adding flour and sugar (flour and
--    先加鸡蛋，然后加面粉和糖（面粉和
--    sugar can be added in which ever order), then mixing, and
--    糖可以以任意顺序添加），然后搅拌，最后
--    finally baking.
--    烘焙来制作的。
--  * If the order of Events differs from this, the result is an Error cake.
--  * 如果事件的顺序与此不同，结果就是一个 Error 蛋糕。
--    No Events can save an Error cake.
--    没有任何事件可以挽救一个 Error 蛋糕。
--  * Once a cake is Finished, it stays Finished even if additional Events happen.
--  * 一旦蛋糕完成（Finished），即使发生额外的事件，它也保持 Finished 状态。
--
-- The function bake just calls step repeatedly. It's used for the
-- 函数 bake 只是重复调用 step。它用于
-- examples below. Don't modify it.
-- 下面的示例。不要修改它。
--
-- Examples:
-- 示例：
--   bake [AddEggs,AddFlour,AddSugar,Mix,Bake]  ==>  Finished
--   bake [AddEggs,AddFlour,AddSugar,Mix,Bake]  ==>  Finished
--   bake [AddEggs,AddFlour,AddSugar,Mix,Bake,AddSugar,Mix]  ==> Finished
--   bake [AddEggs,AddFlour,AddSugar,Mix,Bake,AddSugar,Mix]  ==> Finished
--   bake [AddFlour]  ==>  Error
--   bake [AddFlour]  ==>  Error
--   bake [AddEggs,AddFlour,Mix]  ==>  Error
--   bake [AddEggs,AddFlour,Mix]  ==>  Error

data Event = AddEggs | AddFlour | AddSugar | Mix | Bake
  deriving (Eq,Show)

data State = Start | Error | Finished
  deriving (Eq,Show)

step = todo

-- do not edit this
-- 不要编辑这个
bake :: [Event] -> State
bake events = go Start events
  where go state [] = state
        go state (e:es) = go (step state e) es

------------------------------------------------------------------------------
-- Ex 4: remember how the average function from Set4 couldn't really
-- 练习4：还记得 Set4 中的 average 函数无法真正
-- work on empty lists? Now we can reimplement average for NonEmpty
-- 处理空列表吗？现在我们可以为 NonEmpty 列表重新实现 average
-- lists and avoid the edge case.
-- 来避免这种边界情况。
--
-- PS. The Data.List.NonEmpty type has been imported for you
-- 附：Data.List.NonEmpty 类型已经为你导入
--
-- Examples:
-- 示例：
--   average (1.0 :| [])  ==>  1.0
--   average (1.0 :| [])  ==>  1.0
--   average (1.0 :| [2.0,3.0])  ==>  2.0
--   average (1.0 :| [2.0,3.0])  ==>  2.0

average :: Fractional a => NonEmpty a -> a
average = todo

------------------------------------------------------------------------------
-- Ex 5: reverse a NonEmpty list.
-- 练习5：反转一个 NonEmpty 列表。
--
-- PS. The Data.List.NonEmpty type has been imported for you
-- 附：Data.List.NonEmpty 类型已经为你导入

reverseNonEmpty :: NonEmpty a -> NonEmpty a
reverseNonEmpty = todo

------------------------------------------------------------------------------
-- Ex 6: implement Semigroup instances for the Distance, Time and
-- 练习6：为练习1中的 Distance、Time 和
-- Velocity types from exercise 1. The instances should perform
-- Velocity 类型实现 Semigroup 实例。这些实例应该执行
-- addition.
-- 加法运算。
--
-- When you've defined the instances you can do things like this:
-- 当你定义了这些实例后，你可以做这样的事情：
--
-- velocity (Distance 50 <> Distance 10) (Time 1 <> Time 2)
-- velocity (Distance 50 <> Distance 10) (Time 1 <> Time 2)
--    ==> Velocity 20
--    ==> Velocity 20


------------------------------------------------------------------------------
-- Ex 7: implement a Monoid instance for the Set type from exercise 2.
-- 练习7：为练习2中的 Set 类型实现 Monoid 实例。
-- The (<>) operation should be the union of sets.
-- (<>) 操作应该是集合的并集。
--
-- What's the right definition for mempty?
-- mempty 的正确定义是什么？
--
-- What are the class constraints for the instances?
-- 实例的类约束是什么？


------------------------------------------------------------------------------
-- Ex 8: below you'll find two different ways of representing
-- 练习8：下面你将找到两种不同的表示
-- calculator operations. The type Operation1 is a closed abstraction,
-- 计算器操作的方式。Operation1 类型是一个封闭的抽象，
-- while the class Operation2 is an open abstraction.
-- 而 Operation2 类是一个开放的抽象。
--
-- Your task is to add:
-- 你的任务是添加：
--  * a multiplication case to Operation1 and Operation2
--  * 一个乘法情况到 Operation1 和 Operation2
--    (named Multiply1 and Multiply2, respectively)
--    （分别命名为 Multiply1 和 Multiply2）
--  * functions show1 and show2 that render values of
--  * 函数 show1 和 show2，将 Operation1 和 Operation2 的值
--    Operation1 and Operation2 to strings
--    渲染为字符串
--
-- Examples:
-- 示例：
--   compute1 (Multiply1 2 3) ==> 6
--   compute1 (Multiply1 2 3) ==> 6
--   compute2 (Multiply2 2 3) ==> 6
--   compute2 (Multiply2 2 3) ==> 6
--   show1 (Add1 2 3) ==> "2+3"
--   show1 (Add1 2 3) ==> "2+3"
--   show1 (Multiply1 4 5) ==> "4*5"
--   show1 (Multiply1 4 5) ==> "4*5"
--   show2 (Subtract2 2 3) ==> "2-3"
--   show2 (Subtract2 2 3) ==> "2-3"
--   show2 (Multiply2 4 5) ==> "4*5"
--   show2 (Multiply2 4 5) ==> "4*5"

data Operation1 = Add1 Int Int
                | Subtract1 Int Int
  deriving Show

compute1 :: Operation1 -> Int
compute1 (Add1 i j) = i+j
compute1 (Subtract1 i j) = i-j

show1 :: Operation1 -> String
show1 = todo

data Add2 = Add2 Int Int
  deriving Show
data Subtract2 = Subtract2 Int Int
  deriving Show

class Operation2 op where
  compute2 :: op -> Int

instance Operation2 Add2 where
  compute2 (Add2 i j) = i+j

instance Operation2 Subtract2 where
  compute2 (Subtract2 i j) = i-j


------------------------------------------------------------------------------
-- Ex 9: validating passwords. Below you'll find a type
-- 练习9：验证密码。下面你将找到一个类型
-- PasswordRequirement describing possible requirements for passwords.
-- PasswordRequirement，描述了密码的可能要求。
--
-- Implement the function passwordAllowed that checks whether a
-- 实现函数 passwordAllowed，检查一个
-- password is allowed.
-- 密码是否被允许。
--
-- Examples:
-- 示例：
--   passwordAllowed "short" (MinimumLength 8) ==> False
--   passwordAllowed "short" (MinimumLength 8) ==> False
--   passwordAllowed "veryLongPassword" (MinimumLength 8) ==> True
--   passwordAllowed "veryLongPassword" (MinimumLength 8) ==> True
--   passwordAllowed "password" (ContainsSome "0123456789") ==> False
--   passwordAllowed "password" (ContainsSome "0123456789") ==> False
--   passwordAllowed "p4ssword" (ContainsSome "0123456789") ==> True
--   passwordAllowed "p4ssword" (ContainsSome "0123456789") ==> True
--   passwordAllowed "password" (DoesNotContain "0123456789") ==> True
--   passwordAllowed "password" (DoesNotContain "0123456789") ==> True
--   passwordAllowed "p4ssword" (DoesNotContain "0123456789") ==> False
--   passwordAllowed "p4ssword" (DoesNotContain "0123456789") ==> False
--   passwordAllowed "p4ssword" (And (ContainsSome "1234") (MinimumLength 5)) ==> True
--   passwordAllowed "p4ssword" (And (ContainsSome "1234") (MinimumLength 5)) ==> True
--   passwordAllowed "p4ss" (And (ContainsSome "1234") (MinimumLength 5)) ==> False
--   passwordAllowed "p4ss" (And (ContainsSome "1234") (MinimumLength 5)) ==> False
--   passwordAllowed "p4ss" (Or (ContainsSome "1234") (MinimumLength 5)) ==> True
--   passwordAllowed "p4ss" (Or (ContainsSome "1234") (MinimumLength 5)) ==> True

data PasswordRequirement =
  MinimumLength Int
  | ContainsSome String    -- contains at least one of given characters
  | ContainsSome String    -- 包含给定字符中的至少一个
  | DoesNotContain String  -- does not contain any of the given characters
  | DoesNotContain String  -- 不包含给定字符中的任何一个
  | And PasswordRequirement PasswordRequirement -- and'ing two requirements
  | And PasswordRequirement PasswordRequirement -- 对两个要求取与
  | Or PasswordRequirement PasswordRequirement  -- or'ing
  | Or PasswordRequirement PasswordRequirement  -- 对两个要求取或
  deriving Show

passwordAllowed :: String -> PasswordRequirement -> Bool
passwordAllowed = todo

------------------------------------------------------------------------------
-- Ex 10: a DSL for simple arithmetic expressions with addition and
-- 练习10：一个用于加法和乘法的简单算术表达式的 DSL。
-- multiplication. Define the type Arithmetic so that it can express
-- 定义 Arithmetic 类型使其能够表达
-- expressions like this. Define the functions literal and operation
-- 这样的表达式。定义函数 literal 和 operation
-- for creating Arithmetic values.
-- 用于创建 Arithmetic 值。
--
-- Define two interpreters for Arithmetic: evaluate should compute the
-- 为 Arithmetic 定义两个解释器：evaluate 应该计算
-- expression, and render should show the expression as a string.
-- 表达式的值，render 应该将表达式显示为字符串。
--
-- Examples:
-- 示例：
--   evaluate (literal 3) ==> 3
--   evaluate (literal 3) ==> 3
--   render   (literal 3) ==> "3"
--   render   (literal 3) ==> "3"
--   evaluate (operation "+" (literal 3) (literal 4)) ==> 7
--   evaluate (operation "+" (literal 3) (literal 4)) ==> 7
--   render   (operation "+" (literal 3) (literal 4)) ==> "(3+4)"
--   render   (operation "+" (literal 3) (literal 4)) ==> "(3+4)"
--   evaluate (operation "*" (literal 3) (operation "+" (literal 1) (literal 1)))
--   evaluate (operation "*" (literal 3) (operation "+" (literal 1) (literal 1)))
--     ==> 6
--     ==> 6
--   render   (operation "*" (literal 3) (operation "+" (literal 1) (literal 1)))
--   render   (operation "*" (literal 3) (operation "+" (literal 1) (literal 1)))
--     ==> "(3*(1+1))"
--     ==> "(3*(1+1))"
--

data Arithmetic = Todo
  deriving Show

literal :: Integer -> Arithmetic
literal = todo

operation :: String -> Arithmetic -> Arithmetic -> Arithmetic
operation = todo

evaluate :: Arithmetic -> Integer
evaluate = todo

render :: Arithmetic -> String
render = todo
