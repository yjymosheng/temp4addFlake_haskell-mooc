module Set14b where

-- In this exercise set, we're going to implement an HTTP API for a
-- 在这个练习集中，我们将为一个
-- simple bank. The user should be able to deposit money, withdraw
-- 简单的银行实现一个 HTTP API。用户应该能够通过 HTTP
-- money and check an accounts balance over HTTP. The balances
-- 存款、取款和查询账户余额。余额
-- themselves will be stored in an SQLite database.
-- 本身将存储在 SQLite 数据库中。
--
-- It's a good idea to study Examples/Phonebook.hs and
-- 在开始这个练习集之前，最好先学习 Examples/Phonebook.hs 和
-- Examples/PathServer.hs before jumping into this exercise set.
-- Examples/PathServer.hs。
--
-- Let's start with some imports:
-- 让我们从一些导入开始：

import Mooc.Todo

-- Utilities
-- 工具
import qualified Data.ByteString.Lazy as LB
import Data.Maybe
import qualified Data.Text as T
import qualified Data.Text.Read as TR
import Data.Text.Encoding (encodeUtf8)
import Text.Read (readMaybe)

-- HTTP server
-- HTTP 服务器
import Network.Wai (pathInfo, responseLBS, Application)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)

-- Database
-- 数据库
import Database.SQLite.Simple (open,execute,execute_,query,query_,Connection,Query(..))

------------------------------------------------------------------------------
-- Ex 1: Let's start with implementing some database operations. The
-- 练习1：让我们从实现一些数据库操作开始。
-- database will contain one table, called events, with two columns:
-- 数据库将包含一个名为 events 的表，有两列：
-- account (a string) and amount (a number).
-- account（字符串）和 amount（数字）。
--
-- The database will not be storing the balances of the accounts, but
-- 数据库不会存储账户的余额，而是
-- instead a _transaction log_: each withdrawal and deposit will be
-- 存储_交易日志_：每次取款和存款都将
-- its own row. The balance of the account can then be computed from
-- 作为单独的一行。账户的余额可以
-- these.
-- 从这些记录中计算得出。
--
-- Below, you'll find three queries:
-- 下面你会找到三个查询：
-- * initQuery creates the database
-- * initQuery 创建数据库
-- * depositQuery adds an (account, amount) row into the database
-- * depositQuery 向数据库中添加一个 (account, amount) 行
-- * getAllQuery gets all (account, amount) pairs from the database.
-- * getAllQuery 从数据库中获取所有 (account, amount) 对。
--   getAllQuery isn't needed for the implementation, but you can use it
--   getAllQuery 不是实现所必需的，但你可以用它
--   to test your answer.
--   来测试你的答案。
--
-- Your task is to implement the IO operations openDatabase and deposit.
-- 你的任务是实现 IO 操作 openDatabase 和 deposit。
-- See below for their details.
-- 详情见下文。
--
-- Tip: creating a database with the filename "" will create a
-- 提示：使用文件名 "" 创建数据库将创建一个
-- temporary database that won't get saved to disk. Useful for
-- 不会保存到磁盘的临时数据库。这对于
-- testing!
-- 测试很有用！
--
-- Example in GHCi:
-- 在 GHCi 中的示例：
--   Set14b> db <- openDatabase ""
--   Set14b> db <- openDatabase ""
--   Set14b> deposit db (T.pack "xxx") 13
--   Set14b> deposit db (T.pack "xxx") 13
--   Set14b> deposit db (T.pack "yyy") 5
--   Set14b> deposit db (T.pack "yyy") 5
--   Set14b> deposit db (T.pack "xxx") 7
--   Set14b> deposit db (T.pack "xxx") 7
--   Set14b> query_ db getAllQuery :: IO [(String,Int)]
--   Set14b> query_ db getAllQuery :: IO [(String,Int)]
--   [("xxx",13),("yyy",5),("xxx",7)]
--   [("xxx",13),("yyy",5),("xxx",7)]


initQuery :: Query
initQuery = Query (T.pack "CREATE TABLE IF NOT EXISTS events (account TEXT NOT NULL, amount NUMBER NOT NULL);")

depositQuery :: Query
depositQuery = Query (T.pack "INSERT INTO events (account, amount) VALUES (?, ?);")

getAllQuery :: Query
getAllQuery = Query (T.pack "SELECT account, amount FROM events;")

-- openDatabase should open an SQLite database using the given
-- openDatabase 应该使用给定的
-- filename, run initQuery on it, and produce a database Connection.
-- 文件名打开一个 SQLite 数据库，对其运行 initQuery，并产生一个数据库 Connection。
--
-- NOTE! Do not add anything to the name, otherwise you'll get weird
-- 注意！不要在名称中添加任何内容，否则你会在后面
-- test failures later.
-- 遇到奇怪的测试失败。
openDatabase :: String -> IO Connection
openDatabase = todo

-- given a db connection, an account name, and an amount, deposit
-- 给定一个数据库连接、一个账户名和一个金额，deposit
-- should add an (account, amount) row into the database
-- 应该向数据库中添加一个 (account, amount) 行
deposit :: Connection -> T.Text -> Int -> IO ()
deposit = todo

------------------------------------------------------------------------------
-- Ex 2: Fetching an account's balance. Below you'll find
-- 练习2：获取账户余额。下面你会找到
-- balanceQuery, a query which gets all the amounts related to an
-- balanceQuery，一个查询，用于获取与某个
-- account from the database.
-- 账户相关的所有金额。
--
-- Implement the IO operation balance, which given an account, returns
-- 实现 IO 操作 balance，给定一个账户，返回
-- the sum of all the amounts related to that account.
-- 与该账户相关的所有金额的总和。
--
-- PS. if you know SQL you can do the summing in SQL by changing
-- 附：如果你了解 SQL，可以通过修改
-- balanceQuery, otherwise you can do it in the balance operation
-- balanceQuery 在 SQL 中完成求和，否则你可以在 balance 操作
-- itself. If you choose to edit the SQL query, remember that sum
-- 中完成。如果你选择编辑 SQL 查询，请记住 sum
-- can return null.
-- 可能返回 null。
--
-- Example in GHCi:
-- 在 GHCi 中的示例：
--   Set14b> db <- openDatabase ""
--   Set14b> db <- openDatabase ""
--   Set14b> deposit db (T.pack "xxx") 13
--   Set14b> deposit db (T.pack "xxx") 13
--   Set14b> deposit db (T.pack "yyy") 5
--   Set14b> deposit db (T.pack "yyy") 5
--   Set14b> deposit db (T.pack "xxx") 7
--   Set14b> deposit db (T.pack "xxx") 7
--   Set14b> balance db (T.pack "xxx")
--   Set14b> balance db (T.pack "xxx")
--   20
--   20
--   Set14b> balance db (T.pack "yyy")
--   Set14b> balance db (T.pack "yyy")
--   5
--   5
--   Set14b> balance db (T.pack "zzz")
--   Set14b> balance db (T.pack "zzz")
--   0
--   0

balanceQuery :: Query
balanceQuery = Query (T.pack "SELECT amount FROM events WHERE account = ?;")

balance :: Connection -> T.Text -> IO Int
balance = todo

------------------------------------------------------------------------------
-- Ex 3: Now that we have the database part covered, let's think about
-- 练习3：现在我们已经处理了数据库部分，让我们来思考
-- our API next. The datatype Command represents the various commands
-- 我们的 API。Command 数据类型表示用户可以发出的各种命令：
-- users can issue: Deposit and Balance.
-- Deposit 和 Balance。
--
-- The HTTP API will use paths like the following:
-- HTTP API 将使用如下路径：
-- * /deposit/smith/3 will deposit 3 into the account "smith"
-- * /deposit/smith/3 将向账户 "smith" 存入 3
-- * /balance/lopez will query the balance of the account "lopez"
-- * /balance/lopez 将查询账户 "lopez" 的余额
--
-- Your task is to implement the function parseCommand that takes the
-- 你的任务是实现函数 parseCommand，它接受请求的
-- pathInfo (remember: a list of Texts) of a request, and returns the
-- pathInfo（记住：一个 Text 列表），并返回
-- Command it corresponds to.
-- 对应的 Command。
--
-- The return type of this function is Maybe Command instead of
-- 这个函数的返回类型是 Maybe Command 而不是
-- Command so that we can add error handling later. For now, you can
-- Command，这样我们以后可以添加错误处理。目前你可以
-- assume the input to parseCommand is always valid, and the return
-- 假设 parseCommand 的输入总是有效的，返回
-- value is always Just someCommand.
-- 值总是 Just someCommand。
--
-- The function parseInt that reads an Int from a Text is provided for
-- 从 Text 中读取 Int 的函数 parseInt 已经为你
-- you.
-- 提供。
--
-- PS. the test outputs print Text values as if they were Strings,
-- 附：测试输出将 Text 值像 String 一样打印，
-- just like GHCi prints Texts as Strings.
-- 就像 GHCi 将 Text 打印为 String 一样。
--
-- Examples:
-- 示例：
--   parseCommand [T.pack "balance", T.pack "madoff"]
--   parseCommand [T.pack "balance", T.pack "madoff"]
--     ==> Just (Balance "madoff")
--     ==> Just (Balance "madoff")
--   parseCommand [T.pack "deposit", T.pack "madoff", T.pack "123456"]
--   parseCommand [T.pack "deposit", T.pack "madoff", T.pack "123456"]
--     ==> Just (Deposit "madoff" 123456)
--     ==> Just (Deposit "madoff" 123456)

data Command = Deposit T.Text Int | Balance T.Text
  deriving (Show, Eq)

parseInt :: T.Text -> Maybe Int
parseInt = readMaybe . T.unpack

parseCommand :: [T.Text] -> Maybe Command
parseCommand = todo

------------------------------------------------------------------------------
-- Ex 4: Running commands. Implement the IO operation perform that takes a
-- 练习4：运行命令。实现 IO 操作 perform，它接受一个
-- database Connection, the result of parseCommand (a Maybe Command),
-- 数据库 Connection、parseCommand 的结果（一个 Maybe Command），
-- and runs the command in the database. Remember to use the
-- 并在数据库中运行该命令。记得使用
-- operations you implemented in exercises 1 and 2.
-- 你在练习1和2中实现的操作。
--
-- The perform operation should produce a Text that describes the result
-- perform 操作应该产生一个描述命令结果的 Text。
-- of the command. The result of a Deposit command should be "OK" and
-- Deposit 命令的结果应该是 "OK"，
-- the result of a Balance command should be the balance, as a Text.
-- Balance 命令的结果应该是余额，以 Text 形式返回。
--
-- You don't need to handle the case where the command is Nothing yet,
-- 你暂时不需要处理命令为 Nothing 的情况，
-- you'll get to deal with that in exercise 8.
-- 你将在练习8中处理这个问题。
--
-- Example in GHCi:
-- 在 GHCi 中的示例：
--   Set14b> perform db (Just (Deposit (T.pack "madoff") 123456))
--   Set14b> perform db (Just (Deposit (T.pack "madoff") 123456))
--   "OK"
--   "OK"
--   Set14b> perform db (Just (Deposit (T.pack "madoff") 654321))
--   Set14b> perform db (Just (Deposit (T.pack "madoff") 654321))
--   "OK"
--   "OK"
--   Set14b> perform db (Just (Balance (T.pack "madoff")))
--   Set14b> perform db (Just (Balance (T.pack "madoff")))
--   "777777"
--   "777777"
--   Set14b> perform db (Just (Balance (T.pack "unknown")))
--   Set14b> perform db (Just (Balance (T.pack "unknown")))
--   "0"
--   "0"

perform :: Connection -> Maybe Command -> IO T.Text
perform = todo

------------------------------------------------------------------------------
-- Ex 5: Next up, let's set up a simple HTTP server. Implement a WAI
-- 练习5：接下来，让我们搭建一个简单的 HTTP 服务器。实现一个 WAI
-- Application simpleServer that always responds with a HTTP status
-- Application simpleServer，它总是以 HTTP 状态码
-- 200 and a text "BANK" to any request.
-- 200 和文本 "BANK" 响应任何请求。
--
-- You can use the function encodeResponse to convert a Text into the
-- 你可以使用函数 encodeResponse 将 Text 转换为
-- right kind of ByteString to give to responseLBS.
-- 正确类型的 ByteString 以传递给 responseLBS。
--
-- Example:
-- 示例：
--   - In GHCi: run 8899 simpleServer
--   - 在 GHCi 中：run 8899 simpleServer
--   - Go to <http://localhost:8899> in your browser, you should see the text BANK
--   - 在浏览器中打开 <http://localhost:8899>，你应该看到文本 BANK

encodeResponse :: T.Text -> LB.ByteString
encodeResponse t = LB.fromStrict (encodeUtf8 t)

-- Remember:
-- 记住：
-- type Application = Request -> (Response -> IO ResponseReceived) -> IO ResponseReceived
-- type Application = Request -> (Response -> IO ResponseReceived) -> IO ResponseReceived
simpleServer :: Application
simpleServer request respond = todo

------------------------------------------------------------------------------
-- Ex 6: Now we finally have all the pieces we need to actually
-- 练习6：现在我们终于有了实际
-- implement our API. Implement a WAI Application called server that
-- 实现 API 所需的所有部分。实现一个名为 server 的 WAI Application，
-- receives a request, parses the Command it refers to, and runs the
-- 它接收请求，解析其对应的 Command，并运行
-- command. Use the parseCommand, perform and encodeResponse
-- 该命令。使用 parseCommand、perform 和 encodeResponse
-- functions.
-- 函数。
--
-- After you've implemented server, you can run the bank API from the
-- 实现 server 之后，你可以通过命令行
-- command line with
-- 运行银行 API
--   stack runhaskell Set14b.hs
--   stack runhaskell Set14b.hs
-- This uses the main function provided below.
-- 这使用了下面提供的 main 函数。
--
-- Tip: it can make debugging easier if you print the command before
-- 提示：在执行命令之前打印它
-- performing it.
-- 可以让调试更容易。
--
-- Example:
-- 示例：
--   - Run the server with "stack runhaskell Set14b.hs"
--   - 使用 "stack runhaskell Set14b.hs" 运行服务器
--   - Open <http://localhost:3421/deposit/lopez/17> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/deposit/lopez/17>。
--     You should see the text OK.
--     你应该看到文本 OK。
--   - Open <http://localhost:3421/deposit/lopez/8> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/deposit/lopez/8>。
--     You should see the text OK.
--     你应该看到文本 OK。
--   - Open <http://localhost:3421/balance/lopez> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/balance/lopez>。
--     You should see the text 25.
--     你应该看到文本 25。

-- Remember:
-- 记住：
-- type Application = Request -> (Response -> IO ResponseReceived) -> IO ResponseReceived
-- type Application = Request -> (Response -> IO ResponseReceived) -> IO ResponseReceived
server :: Connection -> Application
server db request respond = todo

port :: Int
port = 3421

main :: IO ()
main = do
  db <- openDatabase "bank.db"
  putStr "Running on port: "
  print port
  run port (server db)

------------------------------------------------------------------------------
-- Ex 7: Add the possibility to withdraw funds to the API. Withdrawing
-- 练习7：为 API 添加取款功能。取款
-- should happen via a /withdraw/<account>/<amount> path, similarly to
-- 应该通过 /withdraw/<account>/<amount> 路径进行，与
-- deposit. The response to a withdraw should be "OK", just like for a
-- 存款类似。取款的响应应该是 "OK"，就像
-- deposit. You'll need to edit the Command datatype, and the
-- 存款一样。你需要编辑 Command 数据类型，以及
-- parseCommand and run functions to support this new command.
-- parseCommand 和 run 函数来支持这个新命令。
--
-- Hint: you can just use deposit IO operation to implement the
-- 提示：你可以直接使用 deposit IO 操作来实现
-- withdraw. You don't need new SQL queries.
-- 取款。你不需要新的 SQL 查询。
--
-- Example:
-- 示例：
--   - Run the server with "stack runhaskell Set14b.hs"
--   - 使用 "stack runhaskell Set14b.hs" 运行服务器
--   - Open <http://localhost:3421/deposit/simon/17> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/deposit/simon/17>。
--     You should see the text OK.
--     你应该看到文本 OK。
--   - Open <http://localhost:3421/withdraw/simon/6> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/withdraw/simon/6>。
--     You should see the text OK.
--     你应该看到文本 OK。
--   - Open <http://localhost:3421/balance/simon> in your browser.
--   - 在浏览器中打开 <http://localhost:3421/balance/simon>。
--     You should see the text 11.
--     你应该看到文本 11。


------------------------------------------------------------------------------
-- Ex 8: Error handling. Modify the parseCommand function so that it
-- 练习8：错误处理。修改 parseCommand 函数，使其
-- returns Nothing when the input is not valid. Modify the perform
-- 在输入无效时返回 Nothing。修改 perform
-- function so that it produces an "ERROR" response given a Nothing.
-- 函数，使其在收到 Nothing 时产生 "ERROR" 响应。
--
-- Hint: the Maybe monad can help you with parseCommand, but you can
-- 提示：Maybe 单子可以帮助你处理 parseCommand，但你也可以
-- also just write normal code instead.
-- 直接写普通代码。
--
-- Examples:
-- 示例：
--  - Run the server with "stack runhaskell Set14b.hs"
--  - 使用 "stack runhaskell Set14b.hs" 运行服务器
--  - All of these URLs should produce the text ERROR:
--  - 所有这些 URL 都应该产生文本 ERROR：
--    - http://localhost:3421/unknown/path
--    - http://localhost:3421/unknown/path
--    - http://localhost:3421/deposit/pekka
--    - http://localhost:3421/deposit/pekka
--    - http://localhost:3421/deposit/pekka/x
--    - http://localhost:3421/deposit/pekka/x
--    - http://localhost:3421/deposit/pekka/1x
--    - http://localhost:3421/deposit/pekka/1x
--    - http://localhost:3421/deposit/pekka/1/3
--    - http://localhost:3421/deposit/pekka/1/3
--    - http://localhost:3421/balance
--    - http://localhost:3421/balance
--    - http://localhost:3421/balance/matti/pekka
--    - http://localhost:3421/balance/matti/pekka
