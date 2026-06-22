-- Welcome to the first exercise set of part 2 of the Haskell Mooc!
-- 欢迎来到 Haskell Mooc 第二部分的第一个练习集！
-- Edit this file according to the instructions, and check your
-- 按照说明编辑此文件，并用以下命令检查你的
-- answers with
-- 答案
--
--   stack runhaskell Set9aTest.hs
--   stack runhaskell Set9aTest.hs
--
-- You can also play around with your answers in GHCi with
-- 你也可以在 GHCi 中尝试你的答案
--
--   stack ghci Set9a.hs
--   stack ghci Set9a.hs

module Set9a where

import Data.Char
import Data.List
import Data.Ord

import Mooc.Todo

------------------------------------------------------------------------------
-- Ex 1: Implement a function workload that takes in the number of
-- 练习1：实现一个函数 workload，接受
-- exercises a student has to finish, and another number that counts
-- 学生需要完成的练习数量，以及另一个数字表示
-- the number of hours each exercise takes.
-- 每个练习所需的小时数。
--
-- If the total number of hours needed for all exercises is over 100,
-- 如果所有练习所需的总小时数超过 100，
-- return "Holy moly!" if it is under 10, return "Piece of cake!".
-- 返回 "Holy moly!"；如果低于 10，返回 "Piece of cake!"。
-- Otherwise return "Ok."
-- 否则返回 "Ok."。

workload :: Int -> Int -> String
workload a b | a * b > 100 =  "Holy moly!" | a * b < 10 = "Piece of cake!" | otherwise = "Ok."

------------------------------------------------------------------------------
-- Ex 2: Implement the function echo that builds a string like this:
-- 练习2：实现函数 echo，构建如下字符串：
--
--   echo "hello!" ==> "hello!, ello!, llo!, lo!, o!, !, "
--   echo "hello!" ==> "hello!, ello!, llo!, lo!, o!, !, "
--   echo "ECHO" ==> "ECHO, CHO, HO, O, "
--   echo "ECHO" ==> "ECHO, CHO, HO, O, "
--   echo "X" ==> "X, "
--   echo "X" ==> "X, "
--   echo "" ==> ""
--   echo "" ==> ""
--
-- Hint: use recursion
-- 提示：使用递归

echo :: String -> String
echo [] = []
echo s = s ++ ", " ++ echo (tail s)


------------------------------------------------------------------------------
-- Ex 3: A country issues some banknotes. The banknotes have a serial
-- 练习3：一个国家发行了一些纸币。纸币有一个序列
-- number that can be used to check if the banknote is valid. For a
-- 号，可以用来检查纸币是否有效。要使
-- banknote to be valid, either
-- 纸币有效，需要满足以下条件之一：
--  * the third and fifth digits need to be the same
--  * 第三位和第五位数字相同
--  * or the fourth and sixth digits need to be the same
--  * 或者第四位和第六位数字相同
--
-- Given a list of bank note serial numbers (strings), count how many
-- 给定一个纸币序列号列表（字符串），计算有多少
-- are valid.
-- 是有效的。

countValid :: [String] -> Int
countValid ss = length (filter valid  ss)
  where valid s =  ( last (take 3 s )== last (take 5 s) ) ||   (last (take 4 s )== last (take 6 s))

------------------------------------------------------------------------------
-- Ex 4: Find the first element that repeats two or more times _in a
-- 练习4：找到输入列表中第一个连续重复两次或更多次的元素。
-- row_ in the input list. Return a Nothing value if no element repeats.
-- 如果没有元素重复，返回 Nothing 值。
--
-- Examples:
-- 示例：
--   repeated [1,2,3] ==> Nothing
--   repeated [1,2,3] ==> Nothing
--   repeated [1,2,2,3,3] ==> Just 2
--   repeated [1,2,2,3,3] ==> Just 2
--   repeated [1,2,1,2,3,3] ==> Just 3
--   repeated [1,2,1,2,3,3] ==> Just 3

repeated :: Eq a => [a] -> Maybe a
repeated = go
  where
    go [] =  Nothing
    go [x] =  Nothing
    go (a : b :xs )  =  if  a == b   then Just a  else go (b: xs)

------------------------------------------------------------------------------
-- Ex 5: A laboratory has been collecting measurements. Some of the
-- 练习5：一个实验室一直在收集测量数据。一些
-- measurements have failed, so the lab is using the type
-- 测量失败了，所以实验室使用类型
--   Either String Int
--   Either String Int
-- to track the measurements. A Left value represents a failed measurement,
-- 来跟踪测量数据。Left 值表示失败的测量，
-- while a Right value represents a successful one.
-- 而 Right 值表示成功的测量。
--
-- Compute the sum of all successful measurements. If there are
-- 计算所有成功测量的总和。如果有
-- successful measurements, return the sum wrapped in a Right, but if
-- 成功的测量，返回包装在 Right 中的总和，但如果
-- there are none, return Left "no data".
-- 没有成功的测量，返回 Left "no data"。
--
-- Examples:
-- 示例：
--   sumSuccess [Right 1, Left "it was a snake!", Right 3]
--   sumSuccess [Right 1, Left "it was a snake!", Right 3]
--     ==> Right 4
--     ==> Right 4
--   sumSuccess [Left "lab blew up", Left "I was sick"]
--   sumSuccess [Left "lab blew up", Left "I was sick"]
--     ==> Left "no data"
--     ==> Left "no data"
--   sumSuccess []
--   sumSuccess []
--     ==> Left "no data"
--     ==> Left "no data"

sumSuccess :: [Either String Int] -> Either String Int
sumSuccess es =
    let (total, hasSuccess) = foldr go (0, False) es
    in if hasSuccess then Right total else Left "no data"
  where
    go (Right x) (acc, _) = (acc + x, True)
    go (Left _)  (acc, has) = (acc, has)

------------------------------------------------------------------------------
-- Ex 6: A combination lock can either be open or closed. The lock
-- 练习6：一个密码锁可以是打开或关闭的。锁
-- also remembers a code. A closed lock can only be opened with the
-- 还记住一个密码。关闭的锁只能用正确的
-- right code. The code of an open lock can be changed.
-- 密码打开。打开的锁的密码可以更改。
--
-- Implement a datatype Lock and the functions isOpen, open, lock,
-- 实现一个数据类型 Lock 以及函数 isOpen、open、lock、
-- changeCode and the constant aLock as instructed below.
-- changeCode 和常量 aLock，如下所示。
--
-- Examples:
-- 示例：
--   isOpen aLock ==> False
--   isOpen aLock ==> False
--   isOpen (lock aLock) ==> False
--   isOpen (lock aLock) ==> False
--   isOpen (open "1234" aLock) ==> True
--   isOpen (open "1234" aLock) ==> True
--   isOpen (lock (open "1234" aLock)) ==> False
--   isOpen (lock (open "1234" aLock)) ==> False
--   isOpen (open "1235" aLock) ==> False
--   isOpen (open "1235" aLock) ==> False
--   isOpen (lock (open "1235" aLock)) ==> False
--   isOpen (lock (open "1235" aLock)) ==> False
--   isOpen (open "1234" (changeCode "0000" aLock)) ==> True
--   isOpen (open "1234" (changeCode "0000" aLock)) ==> True
--   isOpen (open "0000" (changeCode "0000" aLock)) ==> False
--   isOpen (open "0000" (changeCode "0000" aLock)) ==> False
--   isOpen (open "0000" (lock (changeCode "0000" (open "1234" aLock)))) ==> True
--   isOpen (open "0000" (lock (changeCode "0000" (open "1234" aLock)))) ==> True
--   isOpen (open "1234" (lock (changeCode "0000" (open "1234" aLock)))) ==> False
--   isOpen (open "1234" (lock (changeCode "0000" (open "1234" aLock)))) ==> False

data Status   =  Open | Closed
  deriving Show

data Lock = Lock Status String
  deriving Show

-- aLock should be a locked lock with the code "1234"
-- aLock 应该是一个密码为 "1234" 的锁定锁
aLock :: Lock
aLock = Lock Closed "1234"

-- isOpen returns True if the lock is open
-- isOpen 在锁打开时返回 True
isOpen :: Lock -> Bool
isOpen (Lock Open _)=  True
isOpen a =  False


-- open tries to open the lock with the given code. If the code is
-- open 尝试用给定的密码打开锁。如果密码
-- wrong, nothing happens.
-- 错误，则不会发生任何变化。
open :: String -> Lock -> Lock
open s (Lock Closed a )=  if s== a  then Lock Open a  else  Lock Closed a
open s (Lock Open a )=   Lock Open a

-- lock closes a lock. If the lock is already closed, nothing happens.
-- lock 关闭锁。如果锁已经关闭，则不会发生任何变化。
lock :: Lock -> Lock
lock (Lock Open a )=   Lock Closed a
lock (Lock Closed a )=   Lock Closed a

-- changeCode changes the code of an open lock. If the lock is closed,
-- changeCode 更改打开锁的密码。如果锁是关闭的，
-- nothing happens.
-- 则不会发生任何变化。
changeCode :: String -> Lock -> Lock
changeCode s (Lock Open a )=   Lock Open s
changeCode s (Lock Closed a )=   Lock Closed a

------------------------------------------------------------------------------
-- Ex 7: Here's a type Text that just wraps a String. Implement an Eq
-- 练习7：这里有一个类型 Text，它只是包装了一个 String。实现一个 Eq
-- instance for Text that ignores all white space (space characters
-- 实例给 Text，忽略所有空白字符（空格字符
-- and line returns).
-- 和换行符）。
--
-- Hint: Data.Char.isSpace
-- 提示：Data.Char.isSpace
--
-- Examples
-- 示例
--   Text "abc"  == Text "abc"      ==> True
--   Text "abc"  == Text "abc"      ==> True
--   Text "a bc" == Text "ab  c\n"  ==> True
--   Text "a bc" == Text "ab  c\n"  ==> True
--   Text "abc"  == Text "abcd"     ==> False
--   Text "abc"  == Text "abcd"     ==> False
--   Text "a bc" == Text "ab  d\n"  ==> False
--   Text "a bc" == Text "ab  d\n"  ==> False

data Text = Text String
  deriving Show

instance Eq Text where
  (Text a )==(Text b ) =  filter (not . isSpace) a ==  filter (not . isSpace) b

------------------------------------------------------------------------------
-- Ex 8: We can represent functions or mappings as lists of pairs.
-- 练习8：我们可以用键值对列表来表示函数或映射。
-- For example the list [("bob",13),("mary",8)] means that "bob" maps
-- 例如列表 [("bob",13),("mary",8)] 表示 "bob" 映射
-- to 13 and "mary" maps to 8.
-- 到 13，"mary" 映射到 8。
--
-- Implement _composition_ for mappings like this. You compose two
-- 实现这种映射的_组合_。你通过在第二个映射中
-- mappings by looking up each result of the first mapping in the
-- 查找第一个映射的每个结果来组合两个
-- second mapping.
-- 映射。
--
-- You may assume there are no repeated first elements of tuples in
-- 你可以假设参数列表中的元组的第一个元素没有重复，
-- the argument lists, that is.
-- 也就是说。
--
-- The ordering of the output doesn't matter.
-- 输出的顺序无关紧要。
--
-- Hint: remember the function `lookup` from Prelude?
-- 提示：还记得 Prelude 中的 `lookup` 函数吗？
--
-- Note! The order of arguments to `compose` is the other way around
-- 注意！`compose` 的参数顺序与例如 (.) 相反：
-- compared to e.g. (.): `compose f g` should apply `f` first, then
-- `compose f g` 应该先应用 `f`，再应用 `g`，
-- `g`, but `f.g` applies `g` first, then `f`.
-- 但 `f.g` 先应用 `g`，再应用 `f`。
--
-- Examples:
-- 示例：
--   composing two mappings of size 1:
--   组合两个大小为 1 的映射：
--     compose [("a",1)] [(1,True)]
--     compose [("a",1)] [(1,True)]
--       ==> [("a",True)]
--       ==> [("a",True)]
--   nonmatching mappings get ignored:
--   不匹配的映射被忽略：
--     compose [("a",1),("b",2)] [(3,False),(4,True)]
--     compose [("a",1),("b",2)] [(3,False),(4,True)]
--       ==> []
--       ==> []
--   a more complex example: note how "omicron" and "c" are ignored
--   一个更复杂的示例：注意 "omicron" 和 "c" 是如何被忽略的
--     compose [("a","alpha"),("b","beta"),("c","gamma")] [("alpha",1),("beta",2),("omicron",15)]
--     compose [("a","alpha"),("b","beta"),("c","gamma")] [("alpha",1),("beta",2),("omicron",15)]
--       ==> [("a",1),("b",2)]
--       ==> [("a",1),("b",2)]

compose :: (Eq a, Eq b) => [(a,b)] -> [(b,c)] -> [(a,c)]
compose xs ys = [(a,c) | (a,b) <- xs, (b',c) <- ys, b == b']

------------------------------------------------------------------------------
-- Ex 9: Reorder a list using a list of indices.
-- 练习9：使用索引列表重新排列列表。
--
-- You are given a list of indices (numbers from 0 to n) and an input
-- 给定一个索引列表（从 0 到 n 的数字）和一个
-- list (of length n). Each index in the index list tells you where to
-- 输入列表（长度为 n）。索引列表中的每个索引告诉你
-- place the corresponding element from the input list in the output
-- 将输入列表中对应元素放在输出列表的
-- list.
-- 什么位置。
--
-- For example, if the 3rd element of the index list is 7, and the 3rd
-- 例如，如果索引列表的第 3 个元素是 7，而
-- element of the input list is 'a', the output list should have 'a'
-- 输入列表的第 3 个元素是 'a'，那么输出列表应该
-- at index 7.
-- 在索引 7 处有 'a'。
--
-- (The index lists discussed in this exercise correspond to permutations in
-- （本练习中讨论的索引列表对应于数学中的排列。
-- math. In fact, permutations can be multiplied which is a special case of
-- 实际上，排列可以相乘，这是上一个练习中
-- the compose function in the previous exercise. For more information on
-- compose 函数的一个特例。有关排列的更多信息，
-- permutations, see https://en.wikipedia.org/wiki/Permutation)
-- 请参见 https://en.wikipedia.org/wiki/Permutation）
--
-- Examples:
-- 示例：
--   permute [0,1] [True, False] ==> [True, False]
--   permute [0,1] [True, False] ==> [True, False]
--   permute [1,0] [True, False] ==> [False, True]
--   permute [1,0] [True, False] ==> [False, True]
--   permute [0,1,2,3] "hask" ==> "hask"
--   permute [0,1,2,3] "hask" ==> "hask"
--   permute [2,0,1,3] "hask" ==> "ashk"
--   permute [2,0,1,3] "hask" ==> "ashk"
--   permute [1,2,3,0] "hask" ==> "khas"
--   permute [1,2,3,0] "hask" ==> "khas"
--   permute [2, 1, 0] (permute [2, 1, 0] "foo") ==> "foo"
--   permute [2, 1, 0] (permute [2, 1, 0] "foo") ==> "foo"
--   permute [1, 0, 2] (permute [0, 2, 1] [9,3,5]) ==> [5,9,3]
--   permute [1, 0, 2] (permute [0, 2, 1] [9,3,5]) ==> [5,9,3]
--   permute [0, 2, 1] (permute [1, 0, 2] [9,3,5]) ==> [3,5,9]
--   permute [0, 2, 1] (permute [1, 0, 2] [9,3,5]) ==> [3,5,9]
--   permute ([1, 0, 2] `multiply` [0, 2, 1]) [9,3,5] ==> [5,9,3]
--   permute ([1, 0, 2] `multiply` [0, 2, 1]) [9,3,5] ==> [5,9,3]
--   permute ([0, 2, 1] `multiply` [1, 0, 2]) [9,3,5] ==> [3,5,9]
--   permute ([0, 2, 1] `multiply` [1, 0, 2]) [9,3,5] ==> [3,5,9]

-- A type alias for index lists.
-- 索引列表的类型别名。
type Permutation = [Int]

-- Permuting a list with the identity permutation should change nothing.
-- 用恒等排列对列表进行排列不应该改变任何东西。
identity :: Int -> Permutation
identity n = [0 .. n - 1]

-- This function shows how permutations can be composed. Do not edit this
-- 此函数展示了排列如何组合。不要编辑此
-- function.
-- 函数。
multiply :: Permutation -> Permutation -> Permutation
multiply p q = map (\i -> p !! (q !! i)) (identity (length p))

permute :: Permutation -> [a] -> [a]
permute p xs = [ xs !! i | j <- [0 .. length p - 1], let i = head [idx | (idx, val) <- zip [0..] p, val == j] ]
