-- Exercise set 5a
-- 练习集 5a
--
-- * defining algebraic datatypes
-- * 定义代数数据类型
-- * recursive datatypes
-- * 递归数据类型

module Set5a where

import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: Define the type Vehicle that has four constructors: Bike,
-- 练习 1：定义类型 Vehicle，它有四个构造器：Bike、
-- Bus, Tram and Train.
-- Bus、Tram 和 Train。
--
-- The constructors don't need any fields.
-- 这些构造器不需要任何字段。


------------------------------------------------------------------------------
-- Ex 2: Define the type BusTicket that can represent values like these:
-- 练习 2：定义类型 BusTicket，它可以表示以下值：
--  - SingleTicket
--  - SingleTicket
--  - MonthlyTicket "January"
--  - MonthlyTicket "January"
--  - MonthlyTicket "December"
--  - MonthlyTicket "December"


------------------------------------------------------------------------------
-- Ex 3: Here's the definition for a datatype ShoppingEntry that
-- 练习 3：下面是一个数据类型 ShoppingEntry 的定义，它
-- represents an entry in a shopping basket. It has an item name (a
-- 表示购物篮中的一个条目。它包含商品名称（
-- String), an item price (a Double) and a count (an Int). You'll also
-- String）、商品价格（Double）和数量（Int）。你还会
-- find two examples of ShoppingEntry values.
-- 看到两个 ShoppingEntry 值的示例。
--
-- Implement the functions totalPrice and buyOneMore below.
-- 请在下面实现函数 totalPrice 和 buyOneMore。

data ShoppingEntry = MkShoppingEntry String Double Int
  deriving Show

threeApples :: ShoppingEntry
threeApples = MkShoppingEntry "Apple" 0.5 3

twoBananas :: ShoppingEntry
twoBananas = MkShoppingEntry "Banana" 1.1 2

-- totalPrice should return the total price for an entry
-- totalPrice 应返回一个条目的总价格
--
-- Hint: you'll probably need fromIntegral to convert the Int into a
-- 提示：你可能需要使用 fromIntegral 将 Int 转换为
-- Double
-- Double
--
-- Examples:
-- 示例：
--   totalPrice threeApples  ==> 1.5
--   totalPrice threeApples  ==> 1.5
--   totalPrice twoBananas   ==> 2.2
--   totalPrice twoBananas   ==> 2.2

totalPrice :: ShoppingEntry -> Double
totalPrice = todo

-- buyOneMore should increment the count in an entry by one
-- buyOneMore 应将条目中的数量加一
--
-- Example:
-- 示例：
--   buyOneMore twoBananas    ==> MkShoppingEntry "Banana" 1.1 3
--   buyOneMore twoBananas    ==> MkShoppingEntry "Banana" 1.1 3

buyOneMore :: ShoppingEntry -> ShoppingEntry
buyOneMore = todo

------------------------------------------------------------------------------
-- Ex 4: define a datatype Person, which should contain the age (an
-- 练习 4：定义一个数据类型 Person，它应该包含年龄（
-- Int) and the name (a String) of a person.
-- Int）和姓名（String）。
--
-- Also define a Person value fred, and the functions getAge, getName,
-- 同时定义一个 Person 值 fred，以及函数 getAge、getName、
-- setAge and setName (see below).
-- setAge 和 setName（见下方）。

data Person = PersonUndefined
  deriving Show

-- fred is a person whose name is Fred and age is 90
-- fred 是一个名字叫 Fred、年龄为 90 的人
fred :: Person
fred = todo

-- getName returns the name of the person
-- getName 返回此人的姓名
getName :: Person -> String
getName p = todo

-- getAge returns the age of the person
-- getAge 返回此人的年龄
getAge :: Person -> Int
getAge p = todo

-- setName takes a person and returns a new person with the name changed
-- setName 接受一个人，返回一个更改了姓名的新人
setName :: String -> Person -> Person
setName name p = todo

-- setAge does likewise for age
-- setAge 对年龄做同样的操作
setAge :: Int -> Person -> Person
setAge age p = todo

------------------------------------------------------------------------------
-- Ex 5: define a datatype Position which contains two Int values, x
-- 练习 5：定义一个数据类型 Position，它包含两个 Int 值，x
-- and y. Also define the functions below for operating on a Position.
-- 和 y。同时定义以下用于操作 Position 的函数。
--
-- Examples:
-- 示例：
--   getY (up (up origin))    ==> 2
--   getY (up (up origin))    ==> 2
--   getX (up (right origin)) ==> 1
--   getX (up (right origin)) ==> 1

data Position = PositionUndefined

-- origin is a Position value with x and y set to 0
-- origin 是一个 x 和 y 都设为 0 的 Position 值
origin :: Position
origin = todo

-- getX returns the x of a Position
-- getX 返回 Position 的 x 值
getX :: Position -> Int
getX = todo

-- getY returns the y of a position
-- getY 返回 Position 的 y 值
getY :: Position -> Int
getY = todo

-- up increases the y value of a position by one
-- up 将位置的 y 值增加一
up :: Position -> Position
up = todo

-- right increases the x value of a position by one
-- right 将位置的 x 值增加一
right :: Position -> Position
right = todo

------------------------------------------------------------------------------
-- Ex 6: Here's a datatype that represents a student. A student can
-- 练习 6：下面是一个表示学生的数据类型。一个学生可以
-- either be a freshman, a nth year student, or graduated.
-- 是新生、第 n 年学生或已毕业。

data Student = Freshman | NthYear Int | Graduated
  deriving (Show,Eq)

-- Implement the function study, which changes a Freshman into a 1st
-- 实现函数 study，它将新生变为第 1 年
-- year student, a 1st year student into a 2nd year student, and so
-- 学生，将第 1 年学生变为第 2 年学生，以此
-- on. A 7th year student gets changed to a graduated student. A
-- 类推。第 7 年学生变为已毕业学生。
-- graduated student stays graduated even if he studies.
-- 已毕业的学生即使继续学习也保持毕业状态。

study :: Student -> Student
study = todo

------------------------------------------------------------------------------
-- Ex 7: define a datatype UpDown that represents a counter that can
-- 练习 7：定义一个数据类型 UpDown，表示一个可以
-- either be in increasing or decreasing mode. Also implement the
-- 处于递增或递减模式的计数器。同时实现
-- functions zero, toggle, tick and get below.
-- 下面的函数 zero、toggle、tick 和 get。
--
-- NB! Define _two_ constructors for your datatype (feel free to name the
-- 注意！为你的数据类型定义_两个_构造器（可以自由命名
-- constructors however you want)
-- 构造器）
--
-- Examples:
-- 示例：
--
-- get (tick zero)
-- get (tick zero)
--   ==> 1
--   ==> 1
-- get (tick (tick zero))
-- get (tick (tick zero))
--   ==> 2
--   ==> 2
-- get (tick (tick (toggle (tick zero))))
-- get (tick (tick (toggle (tick zero))))
--   ==> -1
--   ==> -1

data UpDown = UpDownUndefined1 | UpDownUndefined2

-- zero is an increasing counter with value 0
-- zero 是一个值为 0 的递增计数器
zero :: UpDown
zero = todo

-- get returns the counter value
-- get 返回计数器的值
get :: UpDown -> Int
get ud = todo

-- tick increases an increasing counter by one or decreases a
-- tick 将递增计数器加一或将
-- decreasing counter by one
-- 递减计数器减一
tick :: UpDown -> UpDown
tick ud = todo

-- toggle changes an increasing counter into a decreasing counter and
-- toggle 将递增计数器变为递减计数器，
-- vice versa
-- 反之亦然
toggle :: UpDown -> UpDown
toggle ud = todo

------------------------------------------------------------------------------
-- Ex 8: you'll find a Color datatype below. It has the three basic
-- 练习 8：下面是一个 Color 数据类型。它有三种基本
-- colours Red, Green and Blue, and two color transformations, Mix and
-- 颜色 Red、Green 和 Blue，以及两种颜色变换 Mix 和
-- Invert.
-- Invert。
--
-- Mix means the average of the two colors in each rgb channel.
-- Mix 表示两种颜色在每个 rgb 通道上的平均值。
--
-- Invert means subtracting all rgb values from 1.
-- Invert 表示用 1 减去所有 rgb 值。
--
-- Implement the function rgb :: Color -> [Double] that returns a list
-- 实现函数 rgb :: Color -> [Double]，它返回一个长度为三的列表，
-- of length three that represents the rgb value of the given color.
-- 表示给定颜色的 rgb 值。
--
-- Examples:
-- 示例：
--
-- rgb Red   ==> [1,0,0]
-- rgb Red   ==> [1,0,0]
-- rgb Green ==> [0,1,0]
-- rgb Green ==> [0,1,0]
-- rgb Blue  ==> [0,0,1]
-- rgb Blue  ==> [0,0,1]
--
-- rgb (Mix Red Green)                    ==> [0.5,0.5,0]
-- rgb (Mix Red Green)                    ==> [0.5,0.5,0]
-- rgb (Mix Red (Mix Red Green))          ==> [0.75,0.25,0]
-- rgb (Mix Red (Mix Red Green))          ==> [0.75,0.25,0]
-- rgb (Invert Red)                       ==> [0,1,1]
-- rgb (Invert Red)                       ==> [0,1,1]
-- rgb (Invert (Mix Red (Mix Red Green))) ==> [0.25,0.75,1]
-- rgb (Invert (Mix Red (Mix Red Green))) ==> [0.25,0.75,1]
-- rgb (Mix (Invert Red) (Invert Green))  ==> [0.5,0.5,1]
-- rgb (Mix (Invert Red) (Invert Green))  ==> [0.5,0.5,1]

data Color = Red | Green | Blue | Mix Color Color | Invert Color
  deriving Show

rgb :: Color -> [Double]
rgb col = todo

------------------------------------------------------------------------------
-- Ex 9: define a parameterized datatype OneOrTwo that contains one or
-- 练习 9：定义一个参数化数据类型 OneOrTwo，包含一个或
-- two values of the given type. The constructors should be called One and Two.
-- 两个给定类型的值。构造器应命名为 One 和 Two。
--
-- Examples:
-- 示例：
--   One True         ::  OneOrTwo Bool
--   One True         ::  OneOrTwo Bool
--   Two "cat" "dog"  ::  OneOrTwo String
--   Two "cat" "dog"  ::  OneOrTwo String


------------------------------------------------------------------------------
-- Ex 10: define a recursive datatype KeyVals for storing a set of
-- 练习 10：定义一个递归数据类型 KeyVals，用于存储一组
-- key-value pairs. There should be two constructors: Empty and Pair.
-- 键值对。应该有两个构造器：Empty 和 Pair。
--
-- Empty represents an empty collection. It should have no fields.
-- Empty 表示空集合。它没有字段。
--
-- Pair should have three fields, one for the key, one for the value,
-- Pair 应该有三个字段，一个用于键，一个用于值，
-- and one for the rest of the collection (of type KeyVals)
-- 一个用于集合的其余部分（类型为 KeyVals）
--
-- The KeyVals datatype is parameterized by the key type k and
-- KeyVals 数据类型由键类型 k 和
-- the value type v.
-- 值类型 v 参数化。
--
-- For example:
-- 例如：
--
--  Pair "cat" True (Pair "dog" False Empty)  ::  KeyVals String Bool
--  Pair "cat" True (Pair "dog" False Empty)  ::  KeyVals String Bool
--
-- Also define the functions toList and fromList that convert between
-- 同时定义函数 toList 和 fromList，用于在
-- KeyVals and lists of pairs.
-- KeyVals 和键值对列表之间进行转换。

data KeyVals k v = KeyValsUndefined
  deriving Show

toList :: KeyVals k v -> [(k,v)]
toList = todo

fromList :: [(k,v)] -> KeyVals k v
fromList = todo

------------------------------------------------------------------------------
-- Ex 11: The data type Nat is the so called Peano
-- 练习 11：数据类型 Nat 是所谓的皮亚诺
-- representation for natural numbers. Define functions fromNat and
-- 自然数表示。定义函数 fromNat 和
-- toNat that convert natural numbers to Ints and vice versa.
-- toNat，用于在自然数和 Int 之间相互转换。
--
-- Examples:
-- 示例：
--   fromNat (PlusOne (PlusOne (PlusOne Zero)))  ==>  3
--   fromNat (PlusOne (PlusOne (PlusOne Zero)))  ==>  3
--   toNat 3    ==> Just (PlusOne (PlusOne (PlusOne Zero)))
--   toNat 3    ==> Just (PlusOne (PlusOne (PlusOne Zero)))
--   toNat (-3) ==> Nothing
--   toNat (-3) ==> Nothing
--

data Nat = Zero | PlusOne Nat
  deriving (Show,Eq)

fromNat :: Nat -> Int
fromNat n = todo

toNat :: Int -> Maybe Nat
toNat z = todo

------------------------------------------------------------------------------
-- Ex 12: While pleasingly simple in its definition, the Nat datatype is not
-- 练习 12：虽然 Nat 数据类型的定义简洁优雅，但它
-- very efficient computationally. Instead of the unary Peano natural numbers,
-- 在计算上并不高效。计算机不使用一元皮亚诺自然数，
-- computers use binary numbers.
-- 而是使用二进制数。
--
-- Binary numbers are like decimal numbers, except that binary numbers have
-- 二进制数类似于十进制数，不同之处在于二进制数只有
-- only two digits (called bits), 0 and 1. The table below gives some
-- 两个数字（称为位），0 和 1。下表给出了一些
-- examples:
-- 示例：
--
--   decimal | binary
--   十进制 | 二进制
--   --------+-------
--   --------+-------
--         0 |      0
--         0 |      0
--         1 |      1
--         1 |      1
--         2 |     10
--         2 |     10
--         7 |    111
--         7 |    111
--        44 | 101100
--        44 | 101100
--
-- For allowing arbitrarily long binary numbers, our representation, the
-- 为了允许任意长度的二进制数，我们的表示——
-- datatype Bin, includes a special End constructor for denoting the end of
-- 数据类型 Bin，包含一个特殊的 End 构造器，用于表示
-- the binary number. In order to make computation with Bin easier, the bits
-- 二进制数的末尾。为了使 Bin 的计算更简单，位
-- are represented in increasing order by significance (i.e. "backwards").
-- 按有效位递增的顺序表示（即"反向"）。
-- Consider the Bin numbers O (I (I End)), representing 110 in binary or
-- 考虑 Bin 数 O (I (I End))，表示二进制的 110 或
-- 6 in decimal, and I (I (O End)) that represents 011 in binary or 3 in
-- 十进制的 6，以及 I (I (O End))，表示二进制的 011 或十进制的 3。
-- decimal. The most significant (last) bit, the bit I, of O (I (I End)) is
-- O (I (I End)) 的最高有效（最后）位 I
-- greater than the bit O, which is the most significant bit of I (I (O End)).
-- 大于 I (I (O End)) 的最高有效位 O。
-- Therefore, O (I (I End)) is greater than I (I (O End)).
-- 因此，O (I (I End)) 大于 I (I (O End))。
--
-- Your task is to write functions prettyPrint, fromBin, and toBin that
-- 你的任务是编写函数 prettyPrint、fromBin 和 toBin，
-- convert Bin to human-readable string, Bin to Int, and Int to Bin
-- 分别将 Bin 转换为人类可读的字符串、Bin 转换为 Int、Int 转换为 Bin。
-- respectively.
-- 分别。
--
-- Examples:
-- 示例：
--   prettyPrint End                     ==> ""
--   prettyPrint End                     ==> ""
--   prettyPrint (O End)                 ==> "0"
--   prettyPrint (O End)                 ==> "0"
--   prettyPrint (I End)                 ==> "1"
--   prettyPrint (I End)                 ==> "1"
--   prettyPrint (O (O (I (O (I End))))) ==> "10100"
--   prettyPrint (O (O (I (O (I End))))) ==> "10100"
--   map fromBin [O End, I End, O (I End), I (I End), O (O (I End)),
--   map fromBin [O End, I End, O (I End), I (I End), O (O (I End)),
--                  I (O (I End))]
--                  I (O (I End))]
--     ==> [0, 1, 2, 3, 4, 5]
--     ==> [0, 1, 2, 3, 4, 5]
--   fromBin (I (I (O (O (I (O (I (O End)))))))) ==> 83
--   fromBin (I (I (O (O (I (O (I (O End)))))))) ==> 83
--   fromBin (I (I (O (O (I (O (I End)))))))     ==> 83
--   fromBin (I (I (O (O (I (O (I End)))))))     ==> 83
--   map toBin [0..5] ==>
--   map toBin [0..5] ==>
--     [O End,I End,O (I End),I (I End),O (O (I End)),I (O (I End))]
--     [O End,I End,O (I End),I (I End),O (O (I End)),I (O (I End))]
--   toBin 57 ==> I (O (O (I (I (I End)))))
--   toBin 57 ==> I (O (O (I (I (I End)))))
--
-- Challenge: Can you implement toBin by directly converting its input into a
-- 挑战：你能通过直接将输入转换为
-- sequence of bits instead of repeatedly applying inc?
-- 位序列来实现 toBin，而不是重复应用 inc 吗？
--
data Bin = End | O Bin | I Bin
  deriving (Show, Eq)

-- This function increments a binary number by one.
-- 此函数将二进制数加一。
inc :: Bin -> Bin
inc End   = I End
inc (O b) = I b
inc (I b) = O (inc b)

prettyPrint :: Bin -> String
prettyPrint = todo

fromBin :: Bin -> Int
fromBin = todo

toBin :: Int -> Bin
toBin = todo
