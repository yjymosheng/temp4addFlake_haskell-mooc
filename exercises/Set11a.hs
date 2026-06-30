module Set11a where

import Control.Monad
import Data.List
import System.IO

import Mooc.Todo

-- Lecture 11:
-- 第11讲：
--   * The IO type
--   * IO 类型
--   * do-notation
--   * do 记法
--
-- Useful functions / operations:
-- 有用的函数/操作：
--   * putStrLn
--   * putStrLn
--   * getLine
--   * getLine
--   * readLn
--   * readLn
--   * replicateM
--   * replicateM
--   * readFile
--   * readFile
--   * lines
--   * lines
--
-- Do not add any new imports! E.g. Data.IORef is forbidden.
-- 不要添加任何新的导入！例如 Data.IORef 是被禁止的。

------------------------------------------------------------------------------
-- Ex 1: define an IO operation hello that prints two lines. The
-- 练习1：定义一个 IO 操作 hello，打印两行。第一行
-- first line should be HELLO and the second one WORLD
-- 应该是 HELLO，第二行是 WORLD

hello :: IO ()
hello =do
    putStrLn "HELLO"
    putStrLn "WORLD"


------------------------------------------------------------------------------
-- Ex 2: define the IO operation greet that takes a name as an
-- 练习2：定义 IO 操作 greet，接受一个名字作为
-- argument and prints a line "HELLO name".
-- 参数，并打印一行 "HELLO name"。

greet :: String -> IO ()
greet name = putStrLn $ "HELLO " ++ name


------------------------------------------------------------------------------
-- Ex 3: define the IO operation greet2 that reads a name from the
-- 练习3：定义 IO 操作 greet2，从键盘读取一个名字，
-- keyboard and then greets that name like the in the previous
-- 然后像上一个练习那样问候该名字。
-- exercise.
--
-- Try to use the greet operation in your solution.
-- 尝试在你的解决方案中使用 greet 操作。

greet2 :: IO ()
greet2 = do
    line <- getLine
    greet line

------------------------------------------------------------------------------
-- Ex 4: define the IO operation readWords n which reads n lines from
-- 练习4：定义 IO 操作 readWords n，从用户读取 n 行，
-- the user and produces them as a list, in alphabetical order.
-- 并将它们按字母顺序生成一个列表。
--
-- Example in GHCi:
-- 在 GHCi 中的示例：
--   Set11> readWords 3
--   Set11> readWords 3
--   bob
--   bob
--   alice
--   alice
--   carl
--   carl
--   ["alice","bob","carl"]
--   ["alice","bob","carl"]

readWords :: Int -> IO [String]
readWords n = sort <$> replicateM n getLine

------------------------------------------------------------------------------
-- Ex 5: define the IO operation readUntil f, which reads lines from
-- 练习5：定义 IO 操作 readUntil f，从用户读取行，
-- the user and returns them as a list. Reading is stopped when f
-- 并将它们作为列表返回。当 f 对某一行返回 True 时停止读取。
-- returns True for a line. (The value for which f returns True is not
-- （f 返回 True 的那个值不会
-- returned.)
-- 被返回。）
--
-- Example in GHCi:
-- 在 GHCi 中的示例：
--   *Set11> readUntil (=="STOP")
--   *Set11> readUntil (=="STOP")
--   bananas
--   bananas
--   garlic
--   garlic
--   pakchoi
--   pakchoi
--   STOP
--   STOP
--   ["bananas","garlic","pakchoi"]
--   ["bananas","garlic","pakchoi"]

readUntil :: (String -> Bool) -> IO [String]
readUntil f = do
    line <- getLine
    (if f line then return [] else (do
        res <- readUntil f
        return (line:res)))

------------------------------------------------------------------------------
-- Ex 6: given n, print the numbers from n to 0, one per line
-- 练习6：给定 n，打印从 n 到 0 的数字，每行一个

countdownPrint :: Int -> IO ()
countdownPrint n = mapM_ (print ) [n,n-1..0]

------------------------------------------------------------------------------
-- Ex 7: isums n should read n numbers from the user (one per line) and
-- 练习7：isums n 应该从用户读取 n 个数字（每行一个），并
--   1) after each number, print the running sum up to that number
--   1) 在每个数字之后，打印到该数字为止的累计和
--   2) finally, produce the sum of all numbers
--   2) 最终，产生所有数字的总和
--
-- Example:
-- 示例：
--   1. run `isums 3`
--   1. 运行 `isums 3`
--   2. user enters '3', should print '3'
--   2. 用户输入 '3'，应打印 '3'
--   3. user enters '5', should print '8' (3+5)
--   3. 用户输入 '5'，应打印 '8' (3+5)
--   4. user enters '1', should print '9' (3+5+1)
--   4. 用户输入 '1'，应打印 '9' (3+5+1)
--   5. produces 9
--   5. 产生 9

isums :: Int -> IO Int
isums n = foldM go 0 [1..n]
    where
        go b _  = do
            a <- readLn
            let res = a + b
            print res
            return res

------------------------------------------------------------------------------
-- Ex 8: when is a useful function, but its first argument has type
-- 练习8：when 是一个有用的函数，但它的第一个参数类型是
-- Bool. Write a function that behaves similarly but the first
-- Bool。编写一个行为类似但第一个
-- argument has type IO Bool.
-- 参数类型为 IO Bool 的函数。

whenM :: IO Bool -> IO () -> IO ()
whenM cond op = do
    a <- cond
    when a op

------------------------------------------------------------------------------
-- Ex 9: implement the while loop. while condition operation should
-- 练习9：实现 while 循环。while condition operation 应该
-- run operation as long as condition returns True.
-- 在 condition 返回 True 时持续运行 operation。
--
-- Examples:
-- 示例：
--   -- prints nothing
--   -- 不打印任何内容
--   while (return False) (putStrLn "IMPOSSIBLE")
--   while (return False) (putStrLn "IMPOSSIBLE")
--
--   -- prints YAY! as long as the user keeps answering Y
--   -- 只要用户持续回答 Y 就打印 YAY!
--   while ask (putStrLn "YAY!")
--   while ask (putStrLn "YAY!")

-- used in an example
-- 在示例中使用
ask :: IO Bool
ask = do putStrLn "Y/N?"
         line <- getLine
         return $ line == "Y"

while :: IO Bool -> IO () -> IO ()
while cond op = whenM cond (op >> while cond op )


------------------------------------------------------------------------------
-- Ex 10: given a string and an IO operation, print the string, run
-- 练习10：给定一个字符串和一个 IO 操作，打印字符串，运行
-- the IO operation, print the string again, and finally return what
-- IO 操作，再次打印字符串，最后返回
-- the operation returned.
-- 操作返回的结果。
--
-- Note! the operation should be run only once
-- 注意！操作应该只运行一次
--
-- Examples:
-- 示例：
--   debug "CIAO" (return 3)
--   debug "CIAO" (return 3)
--     - prints two lines that contain CIAO
--     - 打印两行包含 CIAO 的内容
--     - returns the value 3
--     - 返回值 3
--   debug "BOOM" getLine
--   debug "BOOM" getLine
--     1. prints "BOOM"
--     1. 打印 "BOOM"
--     2. reads a line from the user
--     2. 从用户读取一行
--     3. prints "BOOM"
--     3. 打印 "BOOM"
--     4. returns the line read from the user
--     4. 返回从用户读取的那一行

debug :: String -> IO a -> IO a
debug s op = do 
    putStrLn s 
    a <- op
    putStrLn s 
    return a 