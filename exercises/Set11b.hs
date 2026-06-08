module Set11b where

import Control.Monad
import Data.List
import Data.IORef
import System.IO

import Mooc.Todo


------------------------------------------------------------------------------
-- Ex 1: Given an IORef String and a list of Strings, update the value
-- 练习1：给定一个 IORef String 和一个字符串列表，更新
-- in the IORef by appending to it all the strings in the list, in
-- IORef 中的值，将列表中所有字符串按顺序追加到其中，
-- order.
-- 顺序追加。
--
-- Example:
-- 示例：
--   *Set11b> r <- newIORef "x"
--   *Set11b> r <- newIORef "x"
--   *Set11b> appendAll r ["foo","bar","quux"]
--   *Set11b> appendAll r ["foo","bar","quux"]
--   *Set11b> readIORef r
--   *Set11b> readIORef r
--   "xfoobarquux"
--   "xfoobarquux"

appendAll :: IORef String -> [String] -> IO ()
appendAll = todo

------------------------------------------------------------------------------
-- Ex 2: Given two IORefs, swap the values stored in them.
-- 练习2：给定两个 IORef，交换它们存储的值。
--
-- Example:
-- 示例：
--   *Set11b> x <- newIORef "x"
--   *Set11b> x <- newIORef "x"
--   *Set11b> y <- newIORef "y"
--   *Set11b> y <- newIORef "y"
--   *Set11b> swapIORefs x y
--   *Set11b> swapIORefs x y
--   *Set11b> readIORef x
--   *Set11b> readIORef x
--   "y"
--   "y"
--   *Set11b> readIORef y
--   *Set11b> readIORef y
--   "x"
--   "x"

swapIORefs :: IORef a -> IORef a -> IO ()
swapIORefs = todo

------------------------------------------------------------------------------
-- Ex 3: sometimes one bumps into IO operations that return IO
-- 练习3：有时会遇到返回 IO 操作的 IO 操作。
-- operations. For instance the type IO (IO Int) means an IO operation
-- 例如，类型 IO (IO Int) 表示一个 IO 操作，
-- that returns an IO operation that returns an Int.
-- 该操作返回一个返回 Int 的 IO 操作。
--
-- Implement the function doubleCall which takes an operation op and
-- 实现函数 doubleCall，它接受一个操作 op 并
--   1. runs op
--   1. 运行 op
--   2. runs the operation returned by op
--   2. 运行 op 返回的操作
--   3. returns the value returned by this operation
--   3. 返回该操作返回的值
--
-- Examples:
-- 示例：
--   - doubleCall (return (return 3)) is the same as return 3
--   - doubleCall (return (return 3)) 与 return 3 相同
--
--   - let op :: IO (IO [String])
--   - let op :: IO (IO [String])
--         op = do l <- readLn
--         op = do l <- readLn
--                 return $ replicateM l getLine
--                 return $ replicateM l getLine
--     in doubleCall op
--     in doubleCall op
--
--     works just like
--     工作方式类似于
--
--     do l <- readLn
--     do l <- readLn
--        replicateM l getLine
--        replicateM l getLine

doubleCall :: IO (IO a) -> IO a
doubleCall op = todo

------------------------------------------------------------------------------
-- Ex 4: implement the analogue of function composition (the (.)
-- 练习4：实现函数组合（(.) 运算符）在 IO 操作上的类比。
-- operator) for IO operations. That is, take an operation op1 of type
-- 也就是说，接受一个类型为
--     a -> IO b
--     a -> IO b
-- an operation op2 of type
-- 的操作 op1，一个类型为
--     c -> IO a
--     c -> IO a
-- and a value of type
-- 的操作 op2，以及一个类型为
--     c
--     c
-- and returns an operation op3 of type
-- 的值，返回一个类型为
--     IO b
--     IO b
-- 的操作 op3
--
-- op3 should of course
-- op3 当然应该
--   1. take the value of type c and pass it to op2
--   1. 将类型为 c 的值传递给 op2
--   2. take the resulting value (of type a) and pass it to op1
--   2. 将得到的值（类型为 a）传递给 op1
--   3. return the result (of type b)
--   3. 返回结果（类型为 b）

compose :: (a -> IO b) -> (c -> IO a) -> c -> IO b
compose op1 op2 c = todo

------------------------------------------------------------------------------
-- Ex 5: Reading lines from a file. The module System.IO defines
-- 练习5：从文件中读取行。模块 System.IO 定义了
-- operations for Handles, which represent open files that can be read
-- Handle 的操作，Handle 表示可以从中读取
-- from or written to. Here are some functions that might be useful:
-- 或写入的已打开文件。以下是一些可能有用的函数：
--
-- * hGetLine :: Handle -> IO String
-- * hGetLine :: Handle -> IO String
--   Reads one line from the Handle. Will fail if the Handle is at the
--   从 Handle 中读取一行。如果 Handle 已到达文件末尾则会失败
--   end of the file
--   文件末尾则会失败
-- * hIsEOF :: Handle -> IO Bool
-- * hIsEOF :: Handle -> IO Bool
--   Produces True if the Handle is at the end of the file.
--   如果 Handle 已到达文件末尾则返回 True。
-- * hGetContents :: Handle -> IO String
-- * hGetContents :: Handle -> IO String
--   Reads content from Handle until the end of the file.
--   从 Handle 中读取内容直到文件末尾。
--
-- Implement the function hFetchLines which returns the contents of
-- 实现函数 hFetchLines，返回给定 Handle 的内容
-- the given handle as a sequence of lines.
-- 作为一个行序列。
--
-- There are multiple ways to implement this function. You can either
-- 实现此函数有多种方式。你可以逐行读取，
-- read the lines one by one, or read the whole file and then worry
-- 也可以读取整个文件然后再处理
-- about splitting lines. Both approaches are fine, and you can even
-- 行的拆分。两种方式都可以，你甚至可以
-- try out both!
-- 两种都试试！
--
-- Example:
-- 示例：
--   *Set11b> h <- openFile "Set11b.hs" ReadMode
--   *Set11b> h <- openFile "Set11b.hs" ReadMode
--   *Set11b> ls <- hFetchLines h
--   *Set11b> ls <- hFetchLines h
--   *Set11b> take 3 ls
--   *Set11b> take 3 ls
--   ["module Set11b where","","import Control.Monad"]
--   ["module Set11b where","","import Control.Monad"]

hFetchLines :: Handle -> IO [String]
hFetchLines = todo

------------------------------------------------------------------------------
-- Ex 6: Given a Handle and a list of line indexes, produce the lines
-- 练习6：给定一个 Handle 和一个行索引列表，从文件中
-- at those indexes from the file.
-- 生成对应索引的行。
--
-- Line indexing starts from 1.
-- 行索引从 1 开始。
--
-- Here too, there are multiple ways to implement this. You can try
-- 这里同样有多种实现方式。你可以尝试
-- using hFetchLines, or writing out a loop that gets lines from the
-- 使用 hFetchLines，或者编写一个从 handle 中获取行的循环。
-- handle.
-- handle 中获取行的循环。

hSelectLines :: Handle -> [Int] -> IO [String]
hSelectLines h nums = todo

------------------------------------------------------------------------------
-- Ex 7: In this exercise we see how a program can be split into a
-- 练习7：在本练习中，我们将看到如何将程序拆分为
-- pure part that does all of the work, and a simple IO wrapper that
-- 完成所有工作的纯函数部分，以及驱动纯逻辑的
-- drives the pure logic.
-- 简单 IO 包装器。
--
-- Implement the function interact' that takes a pure function f of
-- 实现函数 interact'，它接受一个纯函数 f，
-- type
-- 类型为
--   (String, st) -> (Bool, String, st)
--   (String, st) -> (Bool, String, st)
-- and a starting state of type st and returns an IO operation of type
-- 以及一个类型为 st 的起始状态，返回一个类型为
-- IO st
-- IO st
-- 的 IO 操作
--
-- interact' should read a line from the user, feed the line and the
-- interact' 应该从用户读取一行，将该行和
-- current state to f. f then returns a boolean, a string to print and
-- 当前状态传递给 f。f 随后返回一个布尔值、一个要打印的字符串和
-- a new state. The string is printed, and if the boolean is True, we
-- 一个新状态。字符串被打印，如果布尔值为 True，我们
-- continue running with the new state. If the boolean is False, the
-- 继续使用新状态运行。如果布尔值为 False，
-- execution has ended and the state should be returned.
-- 执行结束并返回状态。
--
-- Example:
-- 示例：
--   *Set11b> interact' counter 1
--   *Set11b> interact' counter 1
--   print
--   print
--   1
--   1
--   inc
--   inc
--   done
--   done
--   inc
--   inc
--   done
--   done
--   print
--   print
--   3
--   3
--   quit
--   quit
--   bye bye
--   bye bye
--   3
--   3
--   *Set11b>
--   *Set11b>

-- This is used in the example above. Don't change it!
-- 这是上面示例中使用的函数。不要修改它！
counter :: (String,Integer) -> (Bool,String,Integer)
counter ("inc",n)   = (True,"done",n+1)
counter ("print",n) = (True,show n,n)
counter ("quit",n)  = (False,"bye bye",n)

interact' :: ((String,st) -> (Bool,String,st)) -> st -> IO st
interact' f state = todo
