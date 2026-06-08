module Examples.Phonebook where

import Control.Monad
import qualified Data.Text as T
import Database.SQLite.Simple

-- A query for creating a table in the database. Does nothing if the table exists already.
-- 一个用于在数据库中创建表的查询。如果表已存在则不执行任何操作。
createQuery :: Query
createQuery = Query (T.pack "CREATE TABLE IF NOT EXISTS phonebook (name TEXT, phone TEXT);")

-- A query for adding a (name, phonenumber) pair into the database.
-- 一个用于向数据库中添加（姓名，电话号码）对的查询。
addQuery :: Query
addQuery = Query (T.pack "INSERT INTO phonebook (name, phone) VALUES (?, ?);")

addToPhonebook :: Connection -> String -> String -> IO ()
addToPhonebook db name phone = execute db addQuery (name,phone)

-- A query for getting all numbers associated with a given name from the database.
-- 一个用于从数据库中获取与给定姓名关联的所有电话号码的查询。
getQuery :: Query
getQuery = Query (T.pack "SELECT phone FROM phonebook WHERE name = ?;")

getNumbersFor :: Connection -> String -> IO [[String]]
getNumbersFor db name = query db getQuery [name]

openDatabase :: IO Connection
openDatabase = do
  db <- open "phonebook.db"
  execute_ db createQuery
  return db

addMode :: Connection -> IO ()
addMode db = do
  putStrLn "Name?"
  name <- getLine
  when (not (null name)) $ do
    putStrLn "Phone?"
    phone <- getLine
    addToPhonebook db name phone

queryMode :: Connection -> IO ()
queryMode db = do
  putStrLn "Name?"
  name <- getLine
  when (not (null name)) $ do
    numbers <- getNumbersFor db name
    putStrLn (show (length numbers) ++ " numbers:")
    mapM_ print numbers

main :: IO ()
main = do
  db <- openDatabase
  putStrLn "(a)dd or (q)uery?"
  choice <- getLine
  case choice of "a" -> addMode db
                 "q" -> queryMode db
                 _ -> return ()
