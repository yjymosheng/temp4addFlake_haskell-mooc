module Examples.Bank where

import qualified Data.Map as Map

data Bank = Bank (Map.Map String Int)
  deriving (Show,Eq)

deposit :: String -> Int -> Bank -> Bank
deposit accountName amount (Bank accounts) =
  Bank (Map.adjust (\x -> x+amount) accountName accounts)

withdraw :: String -> Int -> Bank -> (Int,Bank)
withdraw accountName amount (Bank accounts) =
  let balance = Map.findWithDefault 0 accountName accounts  -- balance is 0 for a nonexistant account
                                                                  -- 不存在的账户余额为0
      withdrawal = min amount balance                       -- can't withdraw over balance
                                                                  -- 不能提取超过余额的金额
      newAccounts = Map.adjust (\x -> x-withdrawal) accountName accounts
  in (withdrawal, Bank newAccounts)

-- `BankOp a` is an operation that transforms a Bank value, while returning a value of type `a`
-- `BankOp a` 是一个转换 Bank 值的操作，同时返回一个类型为 `a` 的值
data BankOp a = BankOp (Bank -> (a,Bank))

-- running a BankOp on a Bank
-- 在 Bank 上运行 BankOp
runBankOp :: BankOp a -> Bank -> (a,Bank)
runBankOp (BankOp f) bank = f bank

-- Running one BankOp after another
-- 依次运行两个 BankOp
(+>>) :: BankOp a -> BankOp b -> BankOp b
op1 +>> op2 = BankOp combined
  where combined bank = let (_,bank1) = runBankOp op1 bank
                        in runBankOp op2 bank1

-- Running a parameterized BankOp, using the value returned by a previous BankOp
-- 运行一个参数化的 BankOp，使用前一个 BankOp 返回的值
-- The implementation is a bit tricky but it's enough to understand how +> is used for now.
-- 实现有点复杂，但目前只需理解 +> 的用法即可。
(+>) :: BankOp a -> (a -> BankOp b) -> BankOp b
op +> parameterized = BankOp combined
  where combined bank = let (a,bank1) = runBankOp op bank
                        in runBankOp (parameterized a) bank1

-- Make a BankOp out of deposit. There is no return value so we use ().
-- 将 deposit 转换为 BankOp。没有返回值，因此使用 ()。
depositOp :: String -> Int -> BankOp ()
depositOp accountName amount = BankOp depositHelper
  where depositHelper bank = ((), deposit accountName amount bank)

-- Make a BankOp out of withdraw. Note how
-- 将 withdraw 转换为 BankOp。注意
--   withdraw accountName amount :: Bank -> (Int,Bank)
--   withdraw accountName amount :: Bank -> (Int,Bank)
-- is almost a BankOp already!
-- 已经几乎是一个 BankOp 了！
withdrawOp :: String -> Int -> BankOp Int
withdrawOp accountName amount = BankOp (withdraw accountName amount)

-- distribute amount to two accounts
-- 将金额分配到两个账户
distributeOp :: String -> String -> Int -> BankOp ()
distributeOp to1 to2 amount =
  depositOp to1 half
  +>>
  depositOp to2 rest
  where half = div amount 2
        rest = amount - half

-- withdraw up to 100 units from one account, and distribute it evenly among two accounts
-- 从一个账户中提取最多100个单位，并均匀分配到两个账户中
shareOp :: String -> String -> String -> BankOp ()
shareOp from to1 to2 =
  withdrawOp from 100
  +>
  distributeOp to1 to2
