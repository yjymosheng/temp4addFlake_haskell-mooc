module Examples.ReadTypes where

import Control.Monad (forM)
import Data.List (isInfixOf, isSuffixOf)
import System.Directory (listDirectory, doesDirectoryExist)

-- a line is a type signature if it contains :: but does not contain =
-- 如果一行包含 :: 但不包含 =，则该行是类型签名
isTypeSignature :: String -> Bool
isTypeSignature s = not (isInfixOf "=" s) && isInfixOf "::" s

-- return list of types for a .hs file
-- 返回 .hs 文件的类型列表
readTypesFile :: FilePath -> IO [String]
readTypesFile file
  | isSuffixOf ".hs" file = do content <- readFile file
                               let ls = lines content
                               return (filter isTypeSignature ls)
  | otherwise             = return []

-- list children of directory, prepend directory name
-- 列出目录的子项，并在名称前加上目录路径
qualifiedChildren :: String -> IO [String]
qualifiedChildren path = do childs <- listDirectory path
                            return (map (\name -> path++"/"++name) childs)

-- get type signatures for all entries in given directory
-- 获取给定目录中所有条目的类型签名
-- note mutual recursion with readTypes
-- 注意与 readTypes 的互递归关系
readTypesDir :: String -> IO [String]
readTypesDir path = do childs <- qualifiedChildren path
                       typess <- forM childs readTypes
                       return (concat typess)

-- recursively read types contained in a file or directory
-- 递归读取文件或目录中包含的类型
-- note mutual recursion with readTypesDir
-- 注意与 readTypesDir 的互递归关系
readTypes :: String -> IO [String]
readTypes path = do isDir <- doesDirectoryExist path
                    if isDir then readTypesDir path else readTypesFile path

-- main is the IO action that gets run when you run the program
-- main 是运行程序时执行的 IO 操作
main :: IO ()
main = do ts <- readTypes "."
          mapM_ putStrLn ts
