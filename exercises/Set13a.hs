{-# OPTIONS_GHC -Wno-noncanonical-monad-instances #-} -- this silences an uninteresting warning
-- 这消除了一个无关紧要的警告

module Set13a where

import Mooc.Todo

import Control.Monad
import Control.Monad.Trans.State
import Data.Char
import Data.List
import qualified Data.Map as Map

import Examples.Bank


------------------------------------------------------------------------------
-- Ex 1: Your task is to help implement the function readName that
-- 练习1：你的任务是帮助实现函数 readName，该函数
-- given a string like "Forename Surname" produces the pair
-- 给定一个类似 "Forename Surname" 的字符串，生成
-- ("Forename", "Surname"). readName should fail (return Nothing) in
-- 对 ("Forename", "Surname")。readName 应该在以下情况下失败（返回 Nothing）：
-- the following cases:
-- 以下情况：
--
--   1. the input string doesn't contain a space
--   1. 输入字符串不包含空格
--   2. one of the names contains numbers
--   2. 其中一个名字包含数字
--   3. one of the names doesn't start with a capital letter
--   3. 其中一个名字不以大写字母开头
--
-- The function readNames has already been implemented using the ?>
-- 函数 readNames 已经使用课程材料中的 ?>
-- operator from the course material. You need to define the helper
-- 运算符实现。你需要定义辅助
-- functions split, checkNumber and checkCapitals so that readNames
-- 函数 split、checkNumber 和 checkCapitals，使 readNames
-- works correctly.
-- 正常工作。

(?>) :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing ?> _ = Nothing   -- In case of failure, propagate failure
-- 失败时，传播失败
Just x  ?> f = f x       -- In case of success, run the next computation
-- 成功时，运行下一个计算

-- DO NOT touch this definition!
-- 不要修改此定义！
readNames :: String -> Maybe (String,String)
readNames s =
  split s
  ?>
  checkNumber
  ?>
  checkCapitals

-- split should split a string into two words. If the input doesn't
-- split 应该将字符串拆分为两个单词。如果输入不
-- contain a space, Nothing should be returned
-- 包含空格，应返回 Nothing
--
-- (NB! There are obviously other corner cases like the inputs " " and
-- （注意！显然还有其他边界情况，比如输入 " " 和
-- "a b c", but you don't need to worry about those here)
-- "a b c"，但你不需要在这里担心这些）
split :: String -> Maybe (String,String)
split = todo

-- checkNumber should take a pair of two strings and return them
-- checkNumber 应该接受一对字符串，如果它们
-- unchanged if they don't contain numbers. Otherwise Nothing is
-- 不包含数字则原样返回。否则返回
-- returned.
-- Nothing。
checkNumber :: (String, String) -> Maybe (String, String)
checkNumber = todo

-- checkCapitals should take a pair of two strings and return them
-- checkCapitals 应该接受一对字符串，如果它们都
-- unchanged if both start with a capital letter. Otherwise Nothing is
-- 以大写字母开头则原样返回。否则返回
-- returned.
-- Nothing。
checkCapitals :: (String, String) -> Maybe (String, String)
checkCapitals (for,sur) = todo

------------------------------------------------------------------------------
-- Ex 2: Given a list of players and their scores (as [(String,Int)]),
-- 练习2：给定一个玩家及其分数的列表（类型为 [(String,Int)]），
-- and two player names, return the name of the player who has more
-- 以及两个玩家名字，返回拥有更多
-- points (wrapped in a Just), or Nothing if either of the players
-- 积分的玩家名字（包装在 Just 中），如果任一玩家
-- doesn't exist.
-- 不存在则返回 Nothing。
--
-- In the case of a draw, prefer the first player.
-- 在平局的情况下，优先选择第一个玩家。
--
-- Use the function
-- 使用函数
--   lookup :: Eq a => a -> [(a, b)] -> Maybe b
--   lookup :: Eq a => a -> [(a, b)] -> Maybe b
-- and either do-notation (easier) or ?> chaining (trickier!)
-- 以及 do-notation（更容易）或 ?> 链式调用（更难！）
--
-- Examples:
-- 示例：
--   winner [("ender",13),("orson",6),("scott",5)] "ender" "orson"
--   winner [("ender",13),("orson",6),("scott",5)] "ender" "orson"
--     ==> Just "ender"
--     ==> Just "ender"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "ender"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "ender"
--     ==> Just "ender"
--     ==> Just "ender"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "scott"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "scott"
--     ==> Just "orson"
--     ==> Just "orson"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "ridley"
--   winner [("ender",13),("orson",6),("scott",5)] "orson" "ridley"
--     ==> Nothing
--     ==> Nothing
--   winner [("a",1),("b",1)] "a" "b"
--   winner [("a",1),("b",1)] "a" "b"
--     ==> Just "a"
--     ==> Just "a"

winner :: [(String,Int)] -> String -> String -> Maybe String
winner scores player1 player2 = todo

------------------------------------------------------------------------------
-- Ex 3: given a list of indices and a list of values, return the sum
-- 练习3：给定一个索引列表和一个值列表，返回
-- of the values in the given indices. You should fail if any of the
-- 给定索引处值的总和。如果任何索引
-- indices is too large or too small.
-- 过大或过小，应该失败。
--
-- Use the Maybe monad, i.e. the >>= operator or do-notation.
-- 使用 Maybe 单子，即 >>= 运算符或 do-notation。
--
-- Hint! implement a function safeIndex :: [a] -> Int -> Maybe a
-- 提示！实现一个函数 safeIndex :: [a] -> Int -> Maybe a
--
-- Examples:
-- 示例：
--  selectSum [0..10] [4,6,9]
--  selectSum [0..10] [4,6,9]
--    Just 19
--    Just 19
--  selectSum [0..10] [4,6,9,20]
--  selectSum [0..10] [4,6,9,20]
--    Nothing
--    Nothing

selectSum :: Num a => [a] -> [Int] -> Maybe a
selectSum xs is = todo

------------------------------------------------------------------------------
-- Ex 4: Here is the Logger monad from the course material. Implement
-- 练习4：这是课程材料中的 Logger 单子。实现
-- the operation countAndLog which produces the number of elements
-- 操作 countAndLog，它生成满足给定谓词的
-- from the given list that fulfil the given predicate. Additionally,
-- 列表元素的数量。此外，
-- countAndLog should log all elements that fulfil the predicate
-- countAndLog 应该记录所有满足谓词的元素
-- (using show to turn them into strings).
-- （使用 show 将它们转换为字符串）。
--
-- Examples:
-- 示例：
--   countAndLog even [0,1,2,3,4,5]
--   countAndLog even [0,1,2,3,4,5]
--     ==> Logger ["0","2","4"] 3
--     ==> Logger ["0","2","4"] 3

data Logger a = Logger [String] a
  deriving (Show, Eq)

msg :: String -> Logger ()
msg s = Logger [s] ()

instance Functor Logger where
  fmap f (Logger l a) = Logger l (f a)

instance Monad Logger where
  return x = Logger [] x
  Logger la a >>= f = Logger (la++lb) b
    where Logger lb b = f a

-- This is an Applicative instance that works for any monad, you
-- 这是一个适用于任何单子的 Applicative 实例，你
-- can just ignore it for now. We'll get back to Applicative later.
-- 现在可以忽略它。我们稍后会回到 Applicative。
instance Applicative Logger where
  pure = return
  (<*>) = ap

countAndLog :: Show a => (a -> Bool) -> [a] -> Logger Int
countAndLog = todo

------------------------------------------------------------------------------
-- Ex 5: You can find the Bank and BankOp code from the course
-- 练习5：你可以在模块 Examples.Bank（文件
-- material in the module Examples.Bank (file
-- exercises/Examples/Bank.hs）中找到课程材料中的 Bank 和 BankOp 代码，
-- exercises/Examples/Bank.hs), which has been imported into this
-- 该模块已被导入到当前
-- namespace.
-- 命名空间。
--
-- Implement a BankOp balance that produces the balance of the given
-- 实现一个 BankOp balance，生成给定
-- account. Produce 0 if the account does not exist. The balance
-- 账户的余额。如果账户不存在则返回 0。balance
-- operation shouldn't change the state of the Bank. The functions
-- 操作不应改变 Bank 的状态。来自
-- from Data.Map are available under the prefix Map.
-- Data.Map 的函数可以通过前缀 Map 使用。

exampleBank :: Bank
exampleBank = (Bank (Map.fromList [("harry",10),("cedric",7),("ginny",1)]))

balance :: String -> BankOp Int
balance accountName = todo

------------------------------------------------------------------------------
-- Ex 6: Using the operations balance, withdrawOp and depositOp, and
-- 练习6：使用操作 balance、withdrawOp 和 depositOp，以及
-- chaining (+>), implement the BankOp rob, which transfers all the
-- 链式调用 (+>)，实现 BankOp rob，它将所有
-- money from one account to another account.
-- 钱从一个账户转移到另一个账户。
--
-- Examples:
-- 示例：
--   runBankOp (balance "harry") exampleBank
--   runBankOp (balance "harry") exampleBank
--     ==> (10,Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))
--     ==> (10,Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))
--   runBankOp (balance "sean") exampleBank
--   runBankOp (balance "sean") exampleBank
--     ==> (0,Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))
--     ==> (0,Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))
--   runBankOp (rob "cedric" "ginny") exampleBank
--   runBankOp (rob "cedric" "ginny") exampleBank
--     ==> ((),Bank (fromList [("cedric",0),("ginny",8),("harry",10)]))
--     ==> ((),Bank (fromList [("cedric",0),("ginny",8),("harry",10)]))
--   runBankOp (rob "sean" "ginny") exampleBank
--   runBankOp (rob "sean" "ginny") exampleBank
--     ==> ((),Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))
--     ==> ((),Bank (fromList [("cedric",7),("ginny",1),("harry",10)]))

rob :: String -> String -> BankOp ()
rob from to = todo

------------------------------------------------------------------------------
-- Ex 7: using the State monad, write the operation `update` that first
-- 练习7：使用 State 单子，编写操作 `update`，它先
-- multiplies the state by 2 and then adds one to it. The state has
-- 将状态乘以 2，然后加 1。状态的
-- type Int.
-- 类型为 Int。
--
-- Example:
-- 示例：
--  runState update 3
--  runState update 3
--    ==> ((),7)
--    ==> ((),7)

update :: State Int ()
update = todo

------------------------------------------------------------------------------
-- Ex 8: Checking that parentheses are balanced with the State monad.
-- 练习8：使用 State 单子检查括号是否平衡。
--
-- Do this by implementing the function paren, which updates the state
-- 通过实现函数 paren 来完成此操作，该函数根据
-- based on a single character. A '(' should increase the state, and a
-- 单个字符更新状态。'(' 应该增加状态，
-- ')' should decrease the state. If the state goes to -1 (there are
-- ')' 应该减少状态。如果状态变为 -1（右括号
-- more closing than opening parentheses), it should stay there to
-- 比左括号多），它应该保持在那里
-- indicate that a parenthesis error was encountered.
-- 以表示遇到了括号错误。
--
-- After you've implemented paren, the given definition of parensMatch
-- 实现了 paren 之后，给定的 parensMatch 定义
-- should work.
-- 应该可以正常工作。
--
-- Examples:
-- 示例：
--   runState (paren '(') 3    ==> ((),4)
--   runState (paren '(') 3    ==> ((),4)
--   runState (paren ')') 3    ==> ((),2)
--   runState (paren ')') 3    ==> ((),2)
--   runState (paren ')') 0    ==> ((),-1)
--   runState (paren ')') 0    ==> ((),-1)
--   runState (paren ')') (-1) ==> ((),-1)
--   runState (paren ')') (-1) ==> ((),-1)
--   runState (paren '(') (-1) ==> ((),-1)
--   runState (paren '(') (-1) ==> ((),-1)
--   parensMatch "()"          ==> True
--   parensMatch "()"          ==> True
--   parensMatch "("           ==> False
--   parensMatch "("           ==> False
--   parensMatch "())"         ==> False
--   parensMatch "())"         ==> False
--   parensMatch "(()(()()))"  ==> True
--   parensMatch "(()(()()))"  ==> True
--   parensMatch "(()((()))"   ==> False
--   parensMatch "(()((()))"   ==> False
--   parensMatch "(()))("      ==> False
--   parensMatch "(()))("      ==> False

paren :: Char -> State Int ()
paren = todo

parensMatch :: String -> Bool
parensMatch s = count == 0
  where (_,count) = runState (mapM_ paren s) 0

------------------------------------------------------------------------------
-- Ex 9: using a state of type [(a,Int)] we can keep track of the
-- 练习9：使用类型为 [(a,Int)] 的状态，我们可以跟踪
-- numbers of occurrences of elements of type a. For instance
-- 类型 a 的元素的出现次数。例如
-- [('a',1),('x',3)] means that we've seen one 'a' and three 'x's.
-- [('a',1),('x',3)] 表示我们看到了一个 'a' 和三个 'x'。
--
-- Implement a State monad operation count that registers the
-- 实现一个 State 单子操作 count，用于记录
-- occurrence of the given value.
-- 给定值的出现。
--
-- That is, the operation `count x` should fetch the pair `(x,n)` from
-- 也就是说，操作 `count x` 应该从状态中获取对 `(x,n)`，
-- the state, and replace it with the pair `(x,n+1)`. If no such pair
-- 并将其替换为对 `(x,n+1)`。如果没有找到这样的对，
-- is found, the operation should add `(x,1)` to the state.
-- 操作应该将 `(x,1)` 添加到状态中。
--
-- Examples:
-- 示例：
--  runState (count True) []
--  runState (count True) []
--    ==> ((),[(True,1)])
--    ==> ((),[(True,1)])
--  runState (count 7) []
--  runState (count 7) []
--    ==> ((),[(7,1)])
--    ==> ((),[(7,1)])
--  runState (count 'a') [('a',1),('b',3)]
--  runState (count 'a') [('a',1),('b',3)]
--    ==> ((),[('a',2),('b',3)])
--    ==> ((),[('a',2),('b',3)])
--  runState (count 'a' >> count 'b' >> count 'a') []
--  runState (count 'a' >> count 'b' >> count 'a') []
--    ==> ((),[('a',2),('b',1)])
--    ==> ((),[('a',2),('b',1)])
--
-- PS. The order of the list of pairs doesn't matter
-- 附：对的列表顺序不重要

count :: Eq a => a -> State [(a,Int)] ()
count x = todo

------------------------------------------------------------------------------
-- Ex 10: Implement the operation occurrences, which
-- 练习10：实现操作 occurrences，它
--   1. runs the count operation on each element in the input list
--   1. 对输入列表中的每个元素运行 count 操作
--   2. finally produces the number of different items stored in the
--   2. 最终生成存储在状态中的不同项的
--      state
--      数量
--
-- In other words, use the state monad to count how many unique values
-- 换句话说，使用状态单子来计算列表中有多少
-- occur in a list.
-- 唯一值。
--
-- Examples:
-- 示例：
--  runState (occurrences [True,True,True,False,False]) []
--  runState (occurrences [True,True,True,False,False]) []
--    ==> (2,[(True,3),(False,2)])
--    ==> (2,[(True,3),(False,2)])
--  runState (occurrences [5,5,6,6,5,6,7]) []
--  runState (occurrences [5,5,6,6,5,6,7]) []
--    ==> (3,[(5,3),(6,3),(7,1)])
--    ==> (3,[(5,3),(6,3),(7,1)])
--  runState (occurrences [True,False]) [(True,1)]
--  runState (occurrences [True,False]) [(True,1)]
--    ==> (2,[(True,2),(False,1)])
--    ==> (2,[(True,2),(False,1)])
--  runState (occurrences [4,7]) [(2,1),(3,1)]
--  runState (occurrences [4,7]) [(2,1),(3,1)]
--    ==> (4,[(2,1),(3,1),(4,1),(7,1)])
--    ==> (4,[(2,1),(3,1),(4,1),(7,1)])

occurrences :: (Eq a) => [a] -> State [(a,Int)] Int
occurrences xs = todo
