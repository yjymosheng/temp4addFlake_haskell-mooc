{-# OPTIONS_GHC -Wno-noncanonical-monad-instances #-} -- this silences an uninteresting warning
-- 这消除了一个无关紧要的警告

module Set13b where

import Mooc.Todo

import Control.Monad
import Control.Monad.Trans.State
import Data.Char
import Data.IORef
import Data.List


------------------------------------------------------------------------------
-- Ex 1: implement the function ifM, that takes three monadic
-- 练习1：实现函数 ifM，它接受三个单子
-- operations. If the first of the operations returns True, the second
-- 操作。如果第一个操作返回 True，则第二个
-- operation should be run. Otherwise the third operation should be
-- 操作应该被执行。否则第三个操作应该
-- run.
-- 被执行。
--
-- Note the polymorphic `Monad m =>` type signature. Your operation
-- 注意多态的 `Monad m =>` 类型签名。你的操作
-- should work on all monads, and thus needs to be implemented with
-- 应该适用于所有单子，因此需要使用
-- Monad operations like do and >>=. Don't try to pattern match on
-- Monad 操作（如 do 和 >>=）来实现。不要尝试模式匹配
-- Maybes.
-- Maybe。
--
-- Examples (test is defined below):
-- 示例（test 在下面定义）：
--   In the Maybe Monad:
--   在 Maybe 单子中：
--     ifM (Just True) (Just '1') (Just '2')  ==>  Just '1'
--     ifM (Just True) (Just '1') (Just '2')  ==>  Just '1'
--     ifM (Just False) (Just '1') (Just '2') ==>  Just '2'
--     ifM (Just False) (Just '1') (Just '2') ==>  Just '2'
--     ifM Nothing (Just '1') (Just '2')      ==>  Nothing
--     ifM Nothing (Just '1') (Just '2')      ==>  Nothing
--     ifM (Just True) (Just '1') Nothing     ==>  Just '1'
--     ifM (Just True) (Just '1') Nothing     ==>  Just '1'
--   In the State Monad (test is defined below):
--   在 State 单子中（test 在下面定义）：
--     runState (ifM get (return 'a') (return 'b')) False
--     runState (ifM get (return 'a') (return 'b')) False
--       ==> ('b',False)
--       ==> ('b',False)
--     runState (put 11 >> ifM test (return 'a') (return 'b')) 0
--     runState (put 11 >> ifM test (return 'a') (return 'b')) 0
--       ==> ('b',11)
--       ==> ('b',11)
--     runState (put 9 >> ifM test (return 'a') (return 'b')) 0
--     runState (put 9 >> ifM test (return 'a') (return 'b')) 0
--       ==> ('a',9)
--       ==> ('a',9)

test :: State Int Bool
test = do
  x <- get
  return (x<10)

ifM :: Monad m => m Bool -> m a -> m a -> m a
ifM opBool opThen opElse = todo

------------------------------------------------------------------------------
-- Ex 2: the standard library function Control.Monad.mapM defines a
-- 练习2：标准库函数 Control.Monad.mapM 定义了
-- monadic map operation. Some examples of using it (safeDiv is defined
-- 单子映射操作。一些使用它的示例（safeDiv 在
-- below):
-- 下面定义）：
--
-- mapM (safeDiv 10.0) [1.0,5.0,2.0]  =>  Just [10.0,2.0,5.0]
-- mapM (safeDiv 10.0) [1.0,5.0,2.0]  =>  Just [10.0,2.0,5.0]
-- mapM (safeDiv 10.0) [1.0,0.0,2.0]  =>  Nothing
-- mapM (safeDiv 10.0) [1.0,0.0,2.0]  =>  Nothing
--
-- Your task is to implement the function mapM2 that works like mapM,
-- 你的任务是实现函数 mapM2，它的工作方式类似于 mapM，
-- but there are two lists and the operation takes two arguments. More
-- 但有两个列表，操作接受两个参数。更
-- concretely, running `mapM2 op xs ys` should run `op`, giving it the
-- 具体地说，运行 `mapM2 op xs ys` 应该运行 `op`，将
-- first element of xs and the first element of ys. Then, it should
-- xs 的第一个元素和 ys 的第一个元素传给它。然后，它应该
-- run `op` on the second elements of xs and ys, and so forth.
-- 对 xs 和 ys 的第二个元素运行 `op`，依此类推。
-- Finally, all the values produced by `op` are returned, in order, as
-- 最后，`op` 产生的所有值按顺序作为
-- a list.
-- 列表返回。
--
-- If the lists are of different length, you can stop processing them
-- 如果列表长度不同，你可以在较短的列表
-- once the shorter one ends.
-- 结束时停止处理。
--
-- Examples:
-- 示例：
--  mapM2 safeDiv [6.0,10.0,12.0] [3.0,2.0,4.0]
--  mapM2 safeDiv [6.0,10.0,12.0] [3.0,2.0,4.0]
--    ==> Just [2.0,5.0,3.0]
--    ==> Just [2.0,5.0,3.0]
--  mapM2 safeDiv [6.0,10.0,12.0] [3.0,0.0,4.0]
--  mapM2 safeDiv [6.0,10.0,12.0] [3.0,0.0,4.0]
--    ==> Nothing
--    ==> Nothing
--  mapM2 (\x y -> Just (x+y)) [1,2,3] [6,7]
--  mapM2 (\x y -> Just (x+y)) [1,2,3] [6,7]
--    ==> Just [7,9]
--    ==> Just [7,9]
--  runState (mapM2 perhapsIncrement [True,False,True] [1,2,4]) 0
--  runState (mapM2 perhapsIncrement [True,False,True] [1,2,4]) 0
--    ==> ([(),(),()],5)
--    ==> ([(),(),()],5)

-- Do not change safeDiv or perhapsIncrement, they're used by the
-- 不要修改 safeDiv 或 perhapsIncrement，它们被
-- examples & test outputs.
-- 示例和测试输出使用。
safeDiv :: Double -> Double -> Maybe Double
safeDiv x 0.0 = Nothing
safeDiv x y = Just (x/y)

perhapsIncrement :: Bool -> Int -> State Int ()
perhapsIncrement True x = modify (+x)
perhapsIncrement False _ = return ()

mapM2 :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m [c]
mapM2 op xs ys = todo

------------------------------------------------------------------------------
-- Ex 3: Finding paths.
-- 练习3：寻找路径。
--
-- In this exercise, you'll process mazes, described as lists like this:
-- 在这个练习中，你将处理迷宫，描述为如下列表：

maze1 :: [(String,[String])]
maze1 = [("Entry",["Pit","Corridor 1"])
        ,("Pit",[])
        ,("Corridor 1",["Entry","Dead end"])
        ,("Dead end",["Corridor 1"])
        ,("Corridor 2",["Corridor 3"])
        ,("Corridor 3",["Corridor 2"])]

-- This means that you can get from Entry to Pit or Corridor 1, and
-- 这意味着你可以从 Entry 到达 Pit 或 Corridor 1，
-- from Corridor 1 you can get back to Entry or the Dead end, and so
-- 从 Corridor 1 你可以返回 Entry 或到达 Dead end，以此
-- forth. Here's a drawing of what maze1 looks like. Note how you
-- 类推。下面是 maze1 的示意图。注意你
-- can't get out of the Pit, and Corridors 2 and 3 aren't connected to
-- 无法从 Pit 出来，而且 Corridor 2 和 3 没有连接到
-- the Entry.
-- Entry。
--
--  Entry <--> Corridor 1 <--> Dead end
--  Entry <--> Corridor 1 <--> Dead end
--   |
--   |
--   v         Corridor 2 <--> Corridor 3
--   v         Corridor 2 <--> Corridor 3
--  Pit
--  Pit
--
-- Your task is to implement the function path that checks if there is
-- 你的任务是实现函数 path，检查是否存在
-- a path from one location to another.
-- 从一个位置到另一个位置的路径。
--
--   path maze1 "Entry" "Pit"        ==> True
--   path maze1 "Entry" "Pit"        ==> True
--   path maze1 "Entry" "Dead end"   ==> True
--   path maze1 "Entry" "Dead end"   ==> True
--   path maze1 "Pit"   "Entry"      ==> False
--   path maze1 "Pit"   "Entry"      ==> False
--   path maze1 "Entry" "Corridor 2" ==> False
--   path maze1 "Entry" "Corridor 2" ==> False
--
-- To implement path, we'll need some helper functions. We'll work in
-- 为了实现 path，我们需要一些辅助函数。我们将在
-- the State monad, with a state of type [String]. This tracks which
-- State 单子中工作，状态类型为 [String]。它跟踪我们
-- places we've been to.
-- 去过哪些地方。
--
-- The operation `visit maze place1` should work like this:
-- 操作 `visit maze place1` 应该这样工作：
--   * if place1 is in the state (i.e. we've visited it before), do nothing
--   * 如果 place1 在状态中（即我们之前访问过它），什么都不做
--   * otherwise, add place1 to the state (it has now been visited), and:
--   * 否则，将 place1 添加到状态中（现在它已被访问），然后：
--      * for all neighbouring places of place1, run visit
--      * 对 place1 的所有相邻位置，运行 visit
--
-- PS. You might recognize this as a Depth-First Search, but if you
-- 附：你可能认出这是深度优先搜索，但如果你
-- haven't heard the term, don't worry.
-- 没听过这个术语，也不必担心。
--
-- Examples:
-- 示例：
--   runState (visit maze1 "Pit") []
--   runState (visit maze1 "Pit") []
--     ==> ((),["Pit"])
--     ==> ((),["Pit"])
--   runState (visit maze1 "Corridor 2") []
--   runState (visit maze1 "Corridor 2") []
--     ==> ((),["Corridor 3","Corridor 2"])
--     ==> ((),["Corridor 3","Corridor 2"])
--   runState (visit maze1 "Entry") []
--   runState (visit maze1 "Entry") []
--     ==> ((),["Dead end","Corridor 1","Pit","Entry"])
--     ==> ((),["Dead end","Corridor 1","Pit","Entry"])
--   runState (visit maze1 "Entry") ["Corridor 1"]
--   runState (visit maze1 "Entry") ["Corridor 1"]
--     ==> ((),["Pit","Entry","Corridor 1"])
--     ==> ((),["Pit","Entry","Corridor 1"])


visit :: [(String,[String])] -> String -> State [String] ()
visit maze place = todo

-- Now you should be able to implement path using visit. If you run
-- 现在你应该能够使用 visit 来实现 path。如果你
-- visit on a place using an empty state, you'll get a state that
-- 使用空状态对某个位置运行 visit，你将得到一个
-- lists all the places that are reachable from the starting place.
-- 列出从起始位置可达的所有位置的状态。

path :: [(String,[String])] -> String -> String -> Bool
path maze place1 place2 = todo

------------------------------------------------------------------------------
-- Ex 4: Given two lists, ks and ns, find numbers i and j from ks,
-- 练习4：给定两个列表 ks 和 ns，从 ks 中找到数字 i 和 j，
-- such that their sum i+j=n is in ns. Return all such triples
-- 使得它们的和 i+j=n 在 ns 中。返回所有这样的三元组
-- (i,j,n).
-- (i,j,n)。
--
-- Use the list monad!
-- 使用列表单子！
--
-- Examples:
-- 示例：
--  findSum2 [1,2,3,4] [6,7]
--  findSum2 [1,2,3,4] [6,7]
--    ==> [(2,4,6),(3,3,6),(3,4,7),(4,2,6),(4,3,7)]
--    ==> [(2,4,6),(3,3,6),(3,4,7),(4,2,6),(4,3,7)]
--
-- PS. The tests don't care about the order of results.
-- 附：测试不关心结果的顺序。

findSum2 :: [Int] -> [Int] -> [(Int,Int,Int)]
findSum2 ks ns = todo

------------------------------------------------------------------------------
-- Ex 5: compute all possible sums of elements from the given
-- 练习5：计算给定列表中元素的所有可能
-- list. Use the list monad.
-- 求和。使用列表单子。
--
-- Hint! a list literal like [True,False] or [x,0] can be useful when
-- 提示！像 [True,False] 或 [x,0] 这样的列表字面量在与
-- combined with do-notation!
-- do-notation 结合使用时很有用！
--
-- The order of the returned list does not matter and it may contain
-- 返回列表的顺序不重要，且可以包含
-- duplicates.
-- 重复项。
--
-- Examples:
-- 示例：
--   allSums []
--   allSums []
--     ==> [0]
--     ==> [0]
--   allSums [1]
--   allSums [1]
--     ==> [1,0]
--     ==> [1,0]
--   allSums [1,2,4]
--   allSums [1,2,4]
--     ==> [7,3,5,1,6,2,4,0]
--     ==> [7,3,5,1,6,2,4,0]

allSums :: [Int] -> [Int]
allSums xs = todo

------------------------------------------------------------------------------
-- Ex 6: the standard library defines the function
-- 练习6：标准库定义了函数
--
--   foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
--   foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
--
-- This function behaves like foldl, but the operation used is
-- 这个函数的行为类似于 foldl，但使用的操作是
-- monadic. foldM f acc xs works by running f for each element in xs,
-- 单子的。foldM f acc xs 通过对 xs 中的每个元素运行 f 来工作，
-- giving it also the result of the previous invocation of f.
-- 同时将上一次调用 f 的结果也传给它。
--
-- Your task is to implement the functions f1 and f2 so that the
-- 你的任务是实现函数 f1 和 f2，使得
-- functions sumBounded and sumNotTwice work.
-- 函数 sumBounded 和 sumNotTwice 能正常工作。
--
-- Do not change the definitions of sumBounded and sumNotTwice. The
-- 不要修改 sumBounded 和 sumNotTwice 的定义。
-- tests have their own copies of the definitions anyway.
-- 测试中反正有它们自己的副本。

-- sumBounded computes the sum of a list. However if the sum at any
-- sumBounded 计算列表的总和。但是如果总和在任何
-- point during the execution goes over the given bound, Nothing is
-- 执行时刻超过了给定的界限，则返回
-- returned.
-- Nothing。
--
-- Examples:
-- 示例：
--  sumBounded 5 [1,2,1,-2,3]
--  sumBounded 5 [1,2,1,-2,3]
--    ==> Just 5
--    ==> Just 5
--  sumBounded 5 [1,2,3,1,-2]   -- 1+2+3=6 which results in Nothing
--  sumBounded 5 [1,2,3,1,-2]   -- 1+2+3=6 这会导致 Nothing
--    ==> Nothing
--    ==> Nothing
sumBounded :: Int -> [Int] -> Maybe Int
sumBounded k xs = foldM (f1 k) 0 xs

f1 :: Int -> Int -> Int -> Maybe Int
f1 k acc x = todo

-- sumNotTwice computes the sum of a list, but counts only the first
-- sumNotTwice 计算列表的总和，但只计算每个值的
-- occurrence of each value.
-- 第一次出现。
--
-- Examples:
-- 示例：
--  sumNotTwice [1,2,3]          ==> 6
--  sumNotTwice [1,2,3]          ==> 6
--  sumNotTwice [1,1,2,3,2,2,3]  ==> 6
--  sumNotTwice [1,1,2,3,2,2,3]  ==> 6
--  sumNotTwice [3,-2,3]         ==> 1
--  sumNotTwice [3,-2,3]         ==> 1
--  sumNotTwice [1,2,-2,3]       ==> 4
--  sumNotTwice [1,2,-2,3]       ==> 4
sumNotTwice :: [Int] -> Int
sumNotTwice xs = fst $ runState (foldM f2 0 xs) []

f2 :: Int -> Int -> State [Int] Int
f2 acc x = todo

------------------------------------------------------------------------------
-- Ex 7: here is the Result type from Set12. Implement a Monad Result
-- 练习7：这是 Set12 中的 Result 类型。实现一个 Monad Result
-- instance that behaves roughly like the Monad Maybe instance.
-- 实例，其行为大致类似于 Monad Maybe 实例。
--
-- That is,
-- 即，
--   1. MkResult behave like Just
--   1. MkResult 的行为类似于 Just
--   2. If part of computation produces NoResult, the whole computation
--   2. 如果部分计算产生了 NoResult，整个计算
--      produces NoResult (just like Nothing)
--      产生 NoResult（就像 Nothing 一样）
--   3. Similarly, if we get a Failure "reason" value, the whole
--   3. 类似地，如果我们得到一个 Failure "reason" 值，整个
--      computation produces Failure "reason"
--      计算产生 Failure "reason"
--
-- Examples:
-- 示例：
--   MkResult 1 >> Failure "boom" >> MkResult 2
--   MkResult 1 >> Failure "boom" >> MkResult 2
--     ==> Failure "boom"
--     ==> Failure "boom"
--   MkResult 1 >> NoResult >> Failure "not reached"
--   MkResult 1 >> NoResult >> Failure "not reached"
--     ==> NoResult
--     ==> NoResult
--   MkResult 1 >>= (\x -> MkResult (x+1))
--   MkResult 1 >>= (\x -> MkResult (x+1))
--     ==> MkResult 2
--     ==> MkResult 2

data Result a = MkResult a | NoResult | Failure String deriving (Show,Eq)

instance Functor Result where
  -- The same Functor instance you used in Set12 works here.
  -- 你在 Set12 中使用的相同 Functor 实例在这里也适用。
  fmap = todo

-- This is an Applicative instance that works for any monad, you
-- 这是一个适用于任何单子的 Applicative 实例，你
-- can just ignore it for now. We'll get back to Applicative later.
-- 现在可以忽略它。我们稍后会回到 Applicative。
instance Applicative Result where
  pure = return
  (<*>) = ap

instance Monad Result where
  -- implement return and >>=
  -- 实现 return 和 >>=
  return = todo
  (>>=) = todo

------------------------------------------------------------------------------
-- Ex 8: Here is the type SL that combines the State and Logger
-- 练习8：这是结合了 State 和 Logger
-- types. Implement an instance Monad SL, that behaves like the
-- 类型的 SL 类型。实现一个 Monad SL 实例，其行为类似于
-- combination of State and Logger. That is, state is propagated from
-- State 和 Logger 的组合。即，状态从一个操作
-- one operation to the next, and log messages are stored in the order
-- 传播到下一个操作，日志消息按产生的顺序
-- they are produced.
-- 存储。
--
-- To simplify the type signatures, the type of the state has been set
-- 为了简化类型签名，状态的类型被设置为
-- to Int, instead of being a parameter like in the standard State
-- Int，而不是像标准 State 单子那样
-- monad.
-- 作为参数。
--
-- This is a tough one, probably the hardest exercise on this course!
-- 这是一道难题，可能是本课程中最难的练习！
-- You can come back to it later if you don't get it now.
-- 如果你现在做不出来，可以稍后再回来。
--
-- You might find it easier to start with the Functor instance
-- 你可能会发现从 Functor 实例开始更容易
--
-- Examples:
-- 示例：
--   runSL (putSL 2 >> msgSL "hello" >> getSL) 0
--   runSL (putSL 2 >> msgSL "hello" >> getSL) 0
--      ==> (2,2,["hello"])
--      ==> (2,2,["hello"])
--   runSL (replicateM_ 5 (modifySL (+1) >> getSL >>= \x -> msgSL ("got "++show x))) 1
--   runSL (replicateM_ 5 (modifySL (+1) >> getSL >>= \x -> msgSL ("got "++show x))) 1
--      ==> ((),6,["got 2","got 3","got 4","got 5","got 6"])
--      ==> ((),6,["got 2","got 3","got 4","got 5","got 6"])

data SL a = SL (Int -> (a,Int,[String]))

-- Run an SL operation with the given starting state
-- 使用给定的初始状态运行 SL 操作
runSL :: SL a -> Int -> (a,Int,[String])
runSL (SL f) state = f state

-- Write a log message
-- 写入一条日志消息
msgSL :: String -> SL ()
msgSL msg = SL (\s -> ((),s,[msg]))

-- Fetch the state
-- 获取状态
getSL :: SL Int
getSL = SL (\s -> (s,s,[]))

-- Overwrite the state
-- 覆盖状态
putSL :: Int -> SL ()
putSL s' = SL (\s -> ((),s',[]))

-- Modify the state
-- 修改状态
modifySL :: (Int->Int) -> SL ()
modifySL f = SL (\s -> ((),f s,[]))

instance Functor SL where
  -- implement fmap
  -- 实现 fmap
  fmap = todo

-- This is an Applicative instance that works for any monad, you
-- 这是一个适用于任何单子的 Applicative 实例，你
-- can just ignore it for now. We'll get back to Applicative later.
-- 现在可以忽略它。我们稍后会回到 Applicative。
instance Applicative SL where
  pure = return
  (<*>) = ap

instance Monad SL where
  -- implement return and >>=
  -- 实现 return 和 >>=
  return = todo
  (>>=) = todo

------------------------------------------------------------------------------
-- Ex 9: Implement the operation mkCounter that produces the IO operations
-- 练习9：实现操作 mkCounter，它产生 IO 操作
-- inc :: IO () and get :: IO Int. These operations should work like this:
-- inc :: IO () 和 get :: IO Int。这些操作应该这样工作：
--
--   get returns the number of times inc has been called
--   get 返回 inc 被调用的次数
--
-- In other words, a simple stateful counter. Use an IORef to store the count.
-- 换句话说，一个简单的有状态计数器。使用 IORef 来存储计数值。
--
-- Note: this is an IO operation that produces two IO operations. Thus
-- 注意：这是一个产生两个 IO 操作的 IO 操作。因此
-- the type of mkCounter is IO (IO (), IO Int).
-- mkCounter 的类型是 IO (IO (), IO Int)。
--
-- This exercise is tricky. Feel free to leave it until later.
-- 这个练习比较棘手。可以留到以后再做。
--
-- An example of how mkCounter works in GHCi:
-- mkCounter 在 GHCi 中工作的示例：
--
--  *Set11b> (inc,get) <- mkCounter
--  *Set11b> (inc,get) <- mkCounter
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> get
--  *Set11b> get
--  2
--  2
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> inc
--  *Set11b> get
--  *Set11b> get
--  4
--  4

mkCounter :: IO (IO (), IO Int)
mkCounter = todo
