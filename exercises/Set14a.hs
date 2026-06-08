module Set14a where

-- Remember to browse the docs of the Data.Text and Data.ByteString
-- 记得浏览 Data.Text 和 Data.ByteString 的文档
-- libraries while working on the exercises!
-- 库，在做练习的时候！

import Mooc.Todo

import Data.Bits
import Data.Char
import Data.Text.Encoding
import Data.Word
import Data.Int
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL

------------------------------------------------------------------------------
-- Ex 1: Greet a person. Given the name of a person as a Text, return
-- 练习1：问候一个人。给定一个人的名字作为 Text，返回
-- the Text "Hello, <name>!". However, if the name is longer than 15
-- Text "Hello, <name>!"。但是，如果名字超过 15 个
-- characters, output "Hello, <first 15 characters of the name>...!"
-- 字符，输出 "Hello, <名字的前15个字符>...!"
--
-- PS. the test outputs and examples print Text values as if they were
-- 附：测试输出和示例将 Text 值当作
-- Strings, just like GHCi prints Texts as Strings.
-- String 来打印，就像 GHCi 将 Text 打印为 String 一样。
--
-- Examples:
-- 示例：
--  greetText (T.pack "Martin Freeman") ==> "Hello, Martin Freeman!"
--  greetText (T.pack "Martin Freeman") ==> "Hello, Martin Freeman!"
--  greetText (T.pack "Benedict Cumberbatch") ==> "Hello, Benedict Cumber...!"
--  greetText (T.pack "Benedict Cumberbatch") ==> "Hello, Benedict Cumber...!"

greetText :: T.Text -> T.Text
greetText = todo

------------------------------------------------------------------------------
-- Ex 2: Capitalize every second word of a Text.
-- 练习2：将 Text 中每隔一个的单词大写。
--
-- Examples:
-- 示例：
--   shout (T.pack "hello how are you")
--   shout (T.pack "hello how are you")
--     ==> "HELLO how ARE you"
--     ==> "HELLO how ARE you"
--   shout (T.pack "word")
--   shout (T.pack "word")
--     ==> "WORD"
--     ==> "WORD"

shout :: T.Text -> T.Text
shout = todo

------------------------------------------------------------------------------
-- Ex 3: Find the longest sequence of a single character repeating in
-- 练习3：找出 Text 中单个字符重复出现的最长序列，
-- a Text, and return its length.
-- 并返回其长度。
--
-- Examples:
-- 示例：
--   longestRepeat (T.pack "") ==> 0
--   longestRepeat (T.pack "") ==> 0
--   longestRepeat (T.pack "aabbbbccc") ==> 4
--   longestRepeat (T.pack "aabbbbccc") ==> 4

longestRepeat :: T.Text -> Int
longestRepeat = todo

------------------------------------------------------------------------------
-- Ex 4: Given a lazy (potentially infinite) Text, extract the first n
-- 练习4：给定一个惰性（可能无限的）Text，从中提取前 n 个
-- characters from it and return them as a strict Text.
-- 字符，并将它们作为严格 Text 返回。
--
-- The type of the n parameter is Int64, a 64-bit Int. Can you figure
-- n 参数的类型是 Int64，一个 64 位的 Int。你能想出
-- out why this is convenient?
-- 为什么这很方便吗？
--
-- Example:
-- 示例：
--   takeStrict 15 (TL.pack (cycle "asdf"))  ==>  "asdfasdfasdfasd"
--   takeStrict 15 (TL.pack (cycle "asdf"))  ==>  "asdfasdfasdfasd"

takeStrict :: Int64 -> TL.Text -> T.Text
takeStrict = todo

------------------------------------------------------------------------------
-- Ex 5: Find the difference between the largest and smallest byte
-- 练习5：找出 ByteString 中最大和最小字节
-- value in a ByteString. Return 0 for an empty ByteString
-- 值之间的差。对于空 ByteString 返回 0
--
-- Examples:
-- 示例：
--   byteRange (B.pack [1,11,8,3]) ==> 10
--   byteRange (B.pack [1,11,8,3]) ==> 10
--   byteRange (B.pack []) ==> 0
--   byteRange (B.pack []) ==> 0
--   byteRange (B.pack [3]) ==> 0
--   byteRange (B.pack [3]) ==> 0

byteRange :: B.ByteString -> Word8
byteRange = todo

------------------------------------------------------------------------------
-- Ex 6: Compute the XOR checksum of a ByteString. The XOR checksum of
-- 练习6：计算 ByteString 的 XOR 校验和。XOR 校验和是
-- a string of bytes is computed by using the bitwise XOR operation to
-- 通过使用按位 XOR 运算将所有字节
-- "sum" together all the bytes.
-- "求和"来计算的。
--
-- The XOR operation is available in Haskell as Data.Bits.xor
-- XOR 运算在 Haskell 中可用，名为 Data.Bits.xor
-- (imported into this module).
-- （已导入此模块）。
--
-- Examples:
-- 示例：
--   xorChecksum (B.pack [137]) ==> 137
--   xorChecksum (B.pack [137]) ==> 137
--   xor 1 2 ==> 3
--   xor 1 2 ==> 3
--   xorChecksum (B.pack [1,2]) ==> 3
--   xorChecksum (B.pack [1,2]) ==> 3
--   xor 1 (xor 2 4) ==> 7
--   xor 1 (xor 2 4) ==> 7
--   xorChecksum (B.pack [1,2,4]) ==> 7
--   xorChecksum (B.pack [1,2,4]) ==> 7
--   xorChecksum (B.pack [13,197,20]) ==> 220
--   xorChecksum (B.pack [13,197,20]) ==> 220
--   xorChecksum (B.pack [13,197,20,197,13,20]) ==> 0
--   xorChecksum (B.pack [13,197,20,197,13,20]) ==> 0
--   xorChecksum (B.pack []) ==> 0
--   xorChecksum (B.pack []) ==> 0

xorChecksum :: B.ByteString -> Word8
xorChecksum = todo

------------------------------------------------------------------------------
-- Ex 7: Given a ByteString, compute how many UTF-8 characters it
-- 练习7：给定一个 ByteString，计算它包含多少个 UTF-8 字符。
-- consists of. If the ByteString is not valid UTF-8, return Nothing.
-- 如果 ByteString 不是有效的 UTF-8，返回 Nothing。
--
-- Look at the docs of Data.Text.Encoding to find the right functions
-- 查看 Data.Text.Encoding 的文档以找到合适的函数
-- for this.
-- 来完成此任务。
--
-- Examples:
-- 示例：
--   countUtf8Chars (encodeUtf8 (T.pack "åäö")) ==> Just 3
--   countUtf8Chars (encodeUtf8 (T.pack "åäö")) ==> Just 3
--   countUtf8Chars (encodeUtf8 (T.pack "wxyz")) ==> Just 4
--   countUtf8Chars (encodeUtf8 (T.pack "wxyz")) ==> Just 4
--   countUtf8Chars (B.pack [195]) ==> Nothing
--   countUtf8Chars (B.pack [195]) ==> Nothing
--   countUtf8Chars (B.pack [195,184]) ==> Just 1
--   countUtf8Chars (B.pack [195,184]) ==> Just 1
--   countUtf8Chars (B.drop 1 (encodeUtf8 (T.pack "åäö"))) ==> Nothing
--   countUtf8Chars (B.drop 1 (encodeUtf8 (T.pack "åäö"))) ==> Nothing

countUtf8Chars :: B.ByteString -> Maybe Int
countUtf8Chars = todo

------------------------------------------------------------------------------
-- Ex 8: Given a (nonempty) strict ByteString b, generate an infinite
-- 练习8：给定一个（非空）严格 ByteString b，生成一个无限的
-- lazy ByteString that consists of b, reversed b, b, reversed b, and
-- 惰性 ByteString，由 b、反转的 b、b、反转的 b，
-- so on.
-- 依此类推。
--
-- Example:
-- 示例：
--   BL.unpack (BL.take 20 (pingpong (B.pack [0,1,2])))
--   BL.unpack (BL.take 20 (pingpong (B.pack [0,1,2])))
--     ==> [0,1,2,2,1,0,0,1,2,2,1,0,0,1,2,2,1,0,0,1]
--     ==> [0,1,2,2,1,0,0,1,2,2,1,0,0,1,2,2,1,0,0,1]

pingpong :: B.ByteString -> BL.ByteString
pingpong = todo
