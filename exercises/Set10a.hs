module Set10a where

import Data.Char
import Data.List

import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: Given a list, produce a new list where each element of the
-- 练习1：给定一个列表，生成一个新列表，其中原始列表的每个
-- original list repeats twice.
-- 元素重复两次。
--
-- Make sure your function works with infinite lists.
-- 确保你的函数能处理无限列表。
--
-- Examples:
-- 示例：
--   doublify [7,1,6]          ==>  [7,7,1,1,6,6]
--   doublify [7,1,6]          ==>  [7,7,1,1,6,6]
--   take 10 (doublify [0..])  ==>  [0,0,1,1,2,2,3,3,4,4]
--   take 10 (doublify [0..])  ==>  [0,0,1,1,2,2,3,3,4,4]

doublify :: [a] -> [a]
doublify = concatMap (\x -> [x, x])

------------------------------------------------------------------------------
-- Ex 2: Implement the function interleave that takes two lists and
-- 练习2：实现函数 interleave，它接受两个列表并
-- produces a new list that takes elements alternatingly from both
-- 生成一个新列表，交替地从两个
-- lists like this:
-- 列表中取元素，如下所示：
--
--   interleave [1,2,3] [4,5,6] ==> [1,4,2,5,3,6]
--   interleave [1,2,3] [4,5,6] ==> [1,4,2,5,3,6]
--
-- If one list runs out of elements before the other, just keep adding
-- 如果一个列表在另一个列表之前用完元素，就继续添加
-- elements from the other list.
-- 另一个列表中的元素。
--
-- Make sure your function also works with infinite lists.
-- 确保你的函数也能处理无限列表。
--
-- Examples:
-- 示例：
--   interleave [1,2,3] [4,5,6]            ==> [1,4,2,5,3,6]
--   interleave [1,2,3] [4,5,6]            ==> [1,4,2,5,3,6]
--   interleave [1,2] [4,5,6,7]            ==> [1,4,2,5,6,7]
--   interleave [1,2] [4,5,6,7]            ==> [1,4,2,5,6,7]
--   take 10 (interleave [7,7,7] [1..])    ==> [7,1,7,2,7,3,4,5,6,7]
--   take 10 (interleave [7,7,7] [1..])    ==> [7,1,7,2,7,3,4,5,6,7]
--   take 10 (interleave [1..] (repeat 0)) ==> [1,0,2,0,3,0,4,0,5,0]
--   take 10 (interleave [1..] (repeat 0)) ==> [1,0,2,0,3,0,4,0,5,0]

interleave :: [a] -> [a] -> [a]
interleave [] []  = []
interleave  a [] = a
interleave  [] b = b
interleave  (a:as)  (b:bs) = a : b :  interleave as bs



------------------------------------------------------------------------------
-- Ex 3: Deal out cards. Given a list of players (strings), and a list
-- 练习3：发牌。给定一个玩家列表（字符串）和一个
-- of cards (strings), deal out the cards to the players in a cycle.
-- 卡牌列表（字符串），按循环方式将卡牌发给玩家。
--
-- Make sure your function works with infinite inputs as well!
-- 确保你的函数也能处理无限输入！
--
-- Examples:
-- 示例：
--   deal ["Hercule","Ariadne"] ["Ace","Joker","Heart"]
--   deal ["Hercule","Ariadne"] ["Ace","Joker","Heart"]
--     ==> [("Ace","Hercule"),("Joker","Ariadne"),("Heart","Hercule")]
--     ==> [("Ace","Hercule"),("Joker","Ariadne"),("Heart","Hercule")]
--   take 4 (deal ["a","b","c"] (map show [0..]))
--   take 4 (deal ["a","b","c"] (map show [0..]))
--     ==> [("0","a"),("1","b"),("2","c"),("3","a")]
--     ==> [("0","a"),("1","b"),("2","c"),("3","a")]
--   deal ("you":(repeat "me")) ["1","2","3","4"]
--   deal ("you":(repeat "me")) ["1","2","3","4"]
--     ==> [("1","you"),("2","me"),("3","me"),("4","me")]
--     ==> [("1","you"),("2","me"),("3","me"),("4","me")]
--
-- Hint: remember the functions cycle and zip?
-- 提示：还记得 cycle 和 zip 函数吗？

deal :: [String] -> [String] -> [(String,String)]
deal a b = zip   b  $ cycle a

------------------------------------------------------------------------------
-- Ex 4: Compute a running average. Go through a list of Doubles and
-- 练习4：计算运行平均值。遍历一个 Double 列表并
-- output a list of averages: the average of the first number, the
-- 输出一个平均值列表：第一个数的平均值，
-- average of the first two numbers, the first three numbers, and so
-- 前两个数的平均值，前三个数的平均值，以此
-- on.
-- 类推。
--
-- Make sure your function works with infinite inputs as well!
-- 确保你的函数也能处理无限输入！
--
-- Examples:
-- 示例：
--   averages [] ==> []
--   averages [] ==> []
--   averages [3,2,1] ==> [3.0,2.5,2.0]
--   averages [3,2,1] ==> [3.0,2.5,2.0]
--   take 10 (averages [1..]) ==> [1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5]
--   take 10 (averages [1..]) ==> [1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5]



averages :: [Double] -> [Double]
averages xs  =  go xs 0 0
    where
        go [] _ _ =  []
        go (x : xs ) s len  = (s + x) / (len+1) : go  xs (s + x) (len+1)


------------------------------------------------------------------------------
-- Ex 5: Given two lists, xs and ys, and an element z, generate an
-- 练习5：给定两个列表 xs 和 ys，以及一个元素 z，生成一个
-- infinite list that consists of
-- 无限列表，由以下内容组成
--
--  * the elements of xs
--  * xs 的元素
--  * z
--  * z
--  * the elements of ys
--  * ys 的元素
--  * z
--  * z
--  * the elements of xs
--  * xs 的元素
--  * ... and so on
--  * ... 以此类推
--
-- Examples:
-- 示例：
--   take 20 (alternate "abc" "def" ',') ==> "abc,def,abc,def,abc,"
--   take 20 (alternate "abc" "def" ',') ==> "abc,def,abc,def,abc,"
--   take 10 (alternate [1,2] [3,4,5] 0) ==> [1,2,0,3,4,5,0,1,2,0]
--   take 10 (alternate [1,2] [3,4,5] 0) ==> [1,2,0,3,4,5,0,1,2,0]

alternate :: [a] -> [a] -> a -> [a]
alternate xs ys z =  cycle ( xs ++[z] ++ ys ++[z]    )

------------------------------------------------------------------------------
-- Ex 6: Check if the length of a list is at least n. Make sure your
-- 练习6：检查列表的长度是否至少为 n。确保你的
-- function works for infinite inputs.
-- 函数能处理无限输入。
--
-- Examples:
-- 示例：
--   lengthAtLeast 2 [1,2,3] ==> True
--   lengthAtLeast 2 [1,2,3] ==> True
--   lengthAtLeast 7 [1,2,3] ==> False
--   lengthAtLeast 7 [1,2,3] ==> False
--   lengthAtLeast 10 [0..]  ==> True
--   lengthAtLeast 10 [0..]  ==> True

lengthAtLeast :: Int -> [a] -> Bool
lengthAtLeast x as =  go x as 0
    where
        go x [] count =  count >= x
        go x (a:as) count = (count == x) || go x as  (count + 1)


------------------------------------------------------------------------------
-- Ex 7: The function chunks should take in a list, and a number n,
-- 练习7：函数 chunks 应该接受一个列表和一个数字 n，
-- and return all sublists of length n of the original list. The
-- 并返回原始列表中所有长度为 n 的子列表。
-- sublists should be in the order that they appear in the original
-- 子列表应按照它们在原始列表中出现的顺序排列。
-- list. A sublist means a slice, that is, a list of elements
-- 子列表指的是一个切片，即一组在原始列表中相邻且
-- a,b,c,... that occur in the original list next to each other and in
-- 顺序相同的元素 a,b,c,...
-- the same order.
--
-- Make sure your function works with infinite inputs. The function
-- 确保你的函数能处理无限输入。函数
-- lengthAtLeast can help with this.
-- lengthAtLeast 可以帮助你实现这一点。
--
-- Examples:
-- 示例：
--   chunks 2 [1,2,3,4] ==> [[1,2],[2,3],[3,4]]
--   chunks 2 [1,2,3,4] ==> [[1,2],[2,3],[3,4]]
--   take 4 (chunks 3 [0..]) ==> [[0,1,2],[1,2,3],[2,3,4],[3,4,5]]
--   take 4 (chunks 3 [0..]) ==> [[0,1,2],[1,2,3],[2,3,4],[3,4,5]]

chunks :: Int -> [a] -> [[a]]
chunks _ []  = []
chunks n xs  = map (take n) $ takeWhile (lengthAtLeast n) (tails xs)

------------------------------------------------------------------------------
-- Ex 8: Define a newtype called IgnoreCase, that wraps a value of
-- 练习8：定义一个名为 IgnoreCase 的 newtype，它包装一个
-- type String. Define an `Eq` instance for IgnoreCase so that it
-- String 类型的值。为 IgnoreCase 定义一个 `Eq` 实例，使其
-- compares strings in a case-insensitive way.
-- 以不区分大小写的方式比较字符串。
--
-- To help the tests, also implement the function
-- 为了帮助测试，还要实现函数
--   ignorecase :: String -> IgnoreCase
--   ignorecase :: String -> IgnoreCase
--
-- Hint: remember Data.Char.toLower
-- 提示：还记得 Data.Char.toLower
--
-- Examples:
-- 示例：
--   ignorecase "abC" == ignorecase "ABc"  ==>  True
--   ignorecase "abC" == ignorecase "ABc"  ==>  True
--   ignorecase "acC" == ignorecase "ABc"  ==>  False
--   ignorecase "acC" == ignorecase "ABc"  ==>  False

newtype IgnoreCase= IgnoreCase  String

instance Eq IgnoreCase where
    ( IgnoreCase a )== ( IgnoreCase b ) =  map toLower a  ==   map toLower  b

ignorecase :: String -> IgnoreCase
ignorecase = IgnoreCase

------------------------------------------------------------------------------
-- Ex 9: Here's the Room type and some helper functions from the
-- 练习9：这是课程材料中的 Room 类型和一些辅助函数。
-- course material. Define a cyclic Room structure like this:
-- 定义一个循环的 Room 结构，如下所示：
--
--  * maze1 has the description "Maze"
--  * maze1 的描述为 "Maze"
--    * The direction "Left" goes to maze2
--    * 方向 "Left" 通向 maze2
--    * "Right" goes to maze3
--    * "Right" 通向 maze3
--  * maze2 has the description "Deeper in the maze"
--  * maze2 的描述为 "Deeper in the maze"
--    * "Left" goes to maze3
--    * "Left" 通向 maze3
--    * "Right" goes to maze1
--    * "Right" 通向 maze1
--  * maze3 has the description "Elsewhere in the maze"
--  * maze3 的描述为 "Elsewhere in the maze"
--    * "Left" goes to maze1
--    * "Left" 通向 maze1
--    * "Right" goes to maze2
--    * "Right" 通向 maze2
--
-- The variable maze should point to the room maze1.
-- 变量 maze 应该指向房间 maze1。
--
-- Examples:
-- 示例：
--   play maze ["Left","Left","Left"]
--   play maze ["Left","Left","Left"]
--      ==> ["Maze","Deeper in the maze","Elsewhere in the maze","Maze"]
--      ==> ["Maze","Deeper in the maze","Elsewhere in the maze","Maze"]
--   play maze ["Right","Right","Right","Right"]
--   play maze ["Right","Right","Right","Right"]
--      ==> ["Maze","Elsewhere in the maze","Deeper in the maze","Maze","Elsewhere in the maze"]
--      ==> ["Maze","Elsewhere in the maze","Deeper in the maze","Maze","Elsewhere in the maze"]
--   play maze ["Left","Left","Right"]
--   play maze ["Left","Left","Right"]
--      ==> ["Maze","Deeper in the maze","Elsewhere in the maze","Deeper in the maze"]
--      ==> ["Maze","Deeper in the maze","Elsewhere in the maze","Deeper in the maze"]

data Room = Room String [(String,Room)]

-- Do not modify describe, move or play. The tests will use the
-- 不要修改 describe、move 或 play。测试将使用
-- original definitions of describe, move and play regardless of your
-- describe、move 和 play 的原始定义，无论你做了什么
-- modifications.
-- 修改。

describe :: Room -> String
describe (Room s _) = s

move :: Room -> String -> Maybe Room
move (Room _ directions) direction = lookup direction directions

play :: Room -> [String] -> [String]
play room [] = [describe room]
play room (d:ds) = case move room d of Nothing -> [describe room]
                                       Just r -> describe room : play r ds

maze :: Room
maze = maze1
  where
    maze1 = Room "Maze" [("Left", maze2), ("Right", maze3)]
    maze2 = Room "Deeper in the maze" [("Left", maze3), ("Right", maze1)]
    maze3 = Room "Elsewhere in the maze" [("Left", maze1), ("Right", maze2)]
