module Set12 where

import Data.Functor
import Data.Foldable
import Data.List
import Data.Monoid

import Mooc.Todo


------------------------------------------------------------------------------
-- Ex 1: Implement the function incrementAll that takes a functor
-- 练习1：实现函数 incrementAll，它接受一个包含数字的 functor
-- value containing numbers and increments each number inside by one.
-- 值，并将其中的每个数字加一。
--
-- Examples:
-- 示例：
--   incrementAll [1,2,3]     ==>  [2,3,4]
--   incrementAll [1,2,3]     ==>  [2,3,4]
--   incrementAll (Just 3.0)  ==>  Just 4.0
--   incrementAll (Just 3.0)  ==>  Just 4.0

incrementAll :: (Functor f, Num n) => f n -> f n
incrementAll x = (+1 ) <$> x

------------------------------------------------------------------------------
-- Ex 2: Sometimes one wants to fmap multiple levels deep. Implement
-- 练习2：有时需要对多层嵌套的 functor 进行 fmap。实现
-- the functions fmap2 and fmap3 that map over nested functors.
-- 函数 fmap2 和 fmap3，对嵌套的 functor 进行映射。
--
-- Examples:
-- 示例：
--   fmap2 on [[Int]]:
--   fmap2 作用于 [[Int]]：
--     fmap2 negate [[1,2],[3]]
--     fmap2 negate [[1,2],[3]]
--       ==> [[-1,-2],[-3]]
--       ==> [[-1,-2],[-3]]
--   fmap2 on [Maybe String]:
--   fmap2 作用于 [Maybe String]：
--     fmap2 head [Just "abcd",Nothing,Just "efgh"]
--     fmap2 head [Just "abcd",Nothing,Just "efgh"]
--       ==> [Just 'a',Nothing,Just 'e']
--       ==> [Just 'a',Nothing,Just 'e']
--   fmap3 on [[[Int]]]:
--   fmap3 作用于 [[[Int]]]：
--     fmap3 negate [[[1,2],[3]],[[4],[5,6]]]
--     fmap3 negate [[[1,2],[3]],[[4],[5,6]]]
--       ==> [[[-1,-2],[-3]],[[-4],[-5,-6]]]
--       ==> [[[-1,-2],[-3]],[[-4],[-5,-6]]]
--   fmap3 on Maybe [Maybe Bool]
--   fmap3 作用于 Maybe [Maybe Bool]
--     fmap3 not (Just [Just False, Nothing])
--     fmap3 not (Just [Just False, Nothing])
--       ==> Just [Just True,Nothing]
--       ==> Just [Just True,Nothing]

fmap2 :: (Functor f, Functor g) => (a -> b) -> f (g a) -> f (g b)
fmap2  = fmap . fmap

fmap3 :: (Functor f, Functor g, Functor h) => (a -> b) -> f (g (h a)) -> f (g (h b))
fmap3  =fmap . fmap . fmap

------------------------------------------------------------------------------
-- Ex 3: below you'll find a type Result that works a bit like Maybe,
-- 练习3：下面你会找到一个类型 Result，它的工作方式有点像 Maybe，
-- but there are two different types of "Nothings": one with and one
-- 但有两种不同类型的"Nothing"：一种带有错误描述，
-- without an error description.
-- 一种没有错误描述。
--
-- Implement the instance Functor Result
-- 实现 Functor Result 实例

data Result a = MkResult a | NoResult | Failure String
  deriving Show

instance Functor Result where
  fmap f (MkResult a)  =  MkResult $ f a
  fmap f NoResult  =  NoResult
  fmap f (Failure s )=   Failure s

------------------------------------------------------------------------------
-- Ex 4: Here's a reimplementation of the Haskell list type. You might
-- 练习4：这是 Haskell 列表类型的重新实现。你可能
-- remember it from Set6. Implement the instance Functor List.
-- 在 Set6 中见过它。实现 Functor List 实例。
--
-- Example:
-- 示例：
--   fmap (+2) (LNode 0 (LNode 1 (LNode 2 Empty)))
--   fmap (+2) (LNode 0 (LNode 1 (LNode 2 Empty)))
--     ==> LNode 2 (LNode 3 (LNode 4 Empty))
--     ==> LNode 2 (LNode 3 (LNode 4 Empty))

data List a = Empty | LNode a (List a)
  deriving Show

instance Functor List where
  fmap f Empty = Empty
  fmap f ( LNode a as ) =  LNode  (f a) (fmap f as)

------------------------------------------------------------------------------
-- Ex 5: Here's another list type. This time every node contains two
-- 练习5：这是另一种列表类型。这次每个节点包含两个
-- values, so it's a type for a list of pairs. Implement the instance
-- 值，所以它是一个对列表的类型。实现
-- Functor TwoList.
-- Functor TwoList 实例。
--
-- Example:
-- 示例：
--   fmap (+2) (TwoNode 0 1 (TwoNode 2 3 TwoEmpty))
--   fmap (+2) (TwoNode 0 1 (TwoNode 2 3 TwoEmpty))
--     ==> TwoNode 2 3 (TwoNode 4 5 TwoEmpty)
--     ==> TwoNode 2 3 (TwoNode 4 5 TwoEmpty)

data TwoList a = TwoEmpty | TwoNode a a (TwoList a)
  deriving Show

instance Functor TwoList where
  fmap f TwoEmpty = TwoEmpty
  fmap f ( TwoNode  a b  x ) = TwoNode  (f a ) (f b )  (fmap f x ) 

------------------------------------------------------------------------------
-- Ex 6: Count all occurrences of a given element inside a Foldable.
-- 练习6：计算给定元素在 Foldable 中出现的所有次数。
--
-- Hint: you might find some useful functions from Data.Foldable.
-- 提示：你可能会在 Data.Foldable 中找到一些有用的函数。
-- Check the docs! Or then you can just implement count directly.
-- 查看文档！或者你也可以直接实现 count。
--
-- Examples:
-- 示例：
--   count True [True,False,True] ==> 2
--   count True [True,False,True] ==> 2
--   count 'c' (Just 'c') ==> 1
--   count 'c' (Just 'c') ==> 1

count :: (Eq a, Foldable f) => a -> f a -> Int
count = todo

------------------------------------------------------------------------------
-- Ex 7: Return all elements that are in two Foldables, as a list.
-- 练习7：返回两个 Foldable 中共同存在的所有元素，以列表形式。
--
-- Examples:
-- 示例：
--   inBoth "abcd" "fobar" ==> "ab"
--   inBoth "abcd" "fobar" ==> "ab"
--   inBoth [1,2] (Just 2) ==> [2]
--   inBoth [1,2] (Just 2) ==> [2]
--   inBoth Nothing [3]    ==> []
--   inBoth Nothing [3]    ==> []

inBoth :: (Foldable f, Foldable g, Eq a) => f a -> g a -> [a]
inBoth = todo

------------------------------------------------------------------------------
-- Ex 8: Implement the instance Foldable List.
-- 练习8：实现 Foldable List 实例。
--
-- Remember what the minimal complete definitions for Foldable were:
-- 记住 Foldable 的最小完整定义是什么：
-- you should only need to implement one function.
-- 你应该只需要实现一个函数。
--
-- After defining the instance, you'll be able to compute:
-- 定义实例后，你将能够计算：
--   sum (LNode 1 (LNode 2 (LNode 3 Empty)))    ==> 6
--   sum (LNode 1 (LNode 2 (LNode 3 Empty)))    ==> 6
--   length (LNode 1 (LNode 2 (LNode 3 Empty))) ==> 3
--   length (LNode 1 (LNode 2 (LNode 3 Empty))) ==> 3

instance Foldable List where
  foldr = todo

------------------------------------------------------------------------------
-- Ex 9: Implement the instance Foldable TwoList.
-- 练习9：实现 Foldable TwoList 实例。
--
-- After defining the instance, you'll be able to compute:
-- 定义实例后，你将能够计算：
--   sum (TwoNode 0 1 (TwoNode 2 3 TwoEmpty))    ==> 6
--   sum (TwoNode 0 1 (TwoNode 2 3 TwoEmpty))    ==> 6
--   length (TwoNode 0 1 (TwoNode 2 3 TwoEmpty)) ==> 4
--   length (TwoNode 0 1 (TwoNode 2 3 TwoEmpty)) ==> 4

instance Foldable TwoList where
  foldr = todo

------------------------------------------------------------------------------
-- Ex 10: (Tricky!) Fun a is a type that wraps a function Int -> a.
-- 练习10：（有难度！）Fun a 是一个包装了函数 Int -> a 的类型。
-- Implement a Functor instance for it.
-- 为它实现 Functor 实例。
--
-- Figuring out what the Functor instance should do is most of the
-- 弄清楚 Functor 实例应该做什么是这个
-- puzzle.
-- 谜题的主要部分。

data Fun a = Fun (Int -> a)

runFun :: Fun a -> Int -> a
runFun (Fun f) x = f x

instance Functor Fun where

------------------------------------------------------------------------------
-- Ex 11: (Tricky!) You'll find the binary tree type from Set 5b
-- 练习11：（有难度！）你会在下面找到来自 Set 5b 的二叉树类型
-- below. We'll implement a `Foldable` instance for it!
-- 我们将为它实现一个 `Foldable` 实例！
--
-- Implementing `foldr` directly for the Tree type is complicated.
-- 直接为 Tree 类型实现 `foldr` 比较复杂。
-- However, there is another method in Foldable we can define instead:
-- 不过，Foldable 中有另一个方法可以替代定义：
--
--   foldMap :: Monoid m => (a -> m) -> Tree a -> m
--   foldMap :: Monoid m => (a -> m) -> Tree a -> m
--
-- There's a default implementation for `foldr` in Foldable that uses
-- Foldable 中有一个使用 `foldMap` 的 `foldr` 默认实现。
-- `foldMap`.
--
-- Instead of implementing `foldMap` directly, we can build it with
-- 与其直接实现 `foldMap`，我们可以用
-- these functions:
-- 这些函数来构建它：
--
--   fmap :: (a -> m) -> Tree a -> Tree m
--   fmap :: (a -> m) -> Tree a -> Tree m
--   sumTree :: Monoid m => Tree m -> m
--   sumTree :: Monoid m => Tree m -> m
--
-- So your task is to define a `Functor` instance and the `sumTree`
-- 所以你的任务是定义一个 `Functor` 实例和 `sumTree`
-- function.
-- 函数。
--
-- Examples:
-- 示例：
--   using the [] Monoid with the (++) operation:
--   使用带有 (++) 操作的 [] Monoid：
--     sumTree Leaf :: [a]
--     sumTree Leaf :: [a]
--       ==> []
--       ==> []
--     sumTree (Node [3,4,5] (Node [1,2] Leaf Leaf) (Node [6] Leaf Leaf))
--     sumTree (Node [3,4,5] (Node [1,2] Leaf Leaf) (Node [6] Leaf Leaf))
--       ==> [1,2,3,4,5,6]
--       ==> [1,2,3,4,5,6]
--   using the Sum Monoid
--   使用 Sum Monoid
--     sumTree Leaf :: Sum Int
--     sumTree Leaf :: Sum Int
--       ==> Sum 0
--       ==> Sum 0
--     sumTree (Node (Sum 3) (Node (Sum 2) Leaf Leaf) (Node (Sum 1) Leaf Leaf))
--     sumTree (Node (Sum 3) (Node (Sum 2) Leaf Leaf) (Node (Sum 1) Leaf Leaf))
--       ==> Sum 6
--       ==> Sum 6
--
-- Once you're done, foldr should operate like this:
-- 完成后，foldr 应该这样运作：
--   foldr (:) [] Leaf   ==>   []
--   foldr (:) [] Leaf   ==>   []
--   foldr (:) [] (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))  ==>   [1,2,3]
--   foldr (:) [] (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))  ==>   [1,2,3]
--
--   foldr (:) [] (Node 4 (Node 2 (Node 1 Leaf Leaf)
--   foldr (:) [] (Node 4 (Node 2 (Node 1 Leaf Leaf)
--                                (Node 3 Leaf Leaf))
--                                (Node 3 Leaf Leaf))
--                        (Node 5 Leaf
--                        (Node 5 Leaf
--                                (Node 6 Leaf Leaf)))
--                                (Node 6 Leaf Leaf)))
--      ==> [1,2,3,4,5,6]
--      ==> [1,2,3,4,5,6]
--
-- The last example more visually:
-- 最后一个示例更直观地表示：
--
--        .4.
--        .4.
--       /   \
--       /   \
--      2     5     ====>  1 2 3 4 5 6
--      2     5     ====>  1 2 3 4 5 6
--     / \     \
--     / \     \
--    1   3     6
--    1   3     6

data Tree a = Leaf | Node a (Tree a) (Tree a)
  deriving Show

instance Functor Tree where
  fmap = todo

sumTree :: Monoid m => Tree m -> m
sumTree = todo

instance Foldable Tree where
  foldMap f t = sumTree (fmap f t)

------------------------------------------------------------------------------
-- Bonus! If you enjoyed the two last exercises (not everybody will),
-- 附加题！如果你喜欢最后两个练习（不是每个人都会喜欢），
-- you'll like the `loeb` function:
-- 你会喜欢 `loeb` 函数：
--
--   https://github.com/quchen/articles/blob/master/loeb-moeb.md
--   https://github.com/quchen/articles/blob/master/loeb-moeb.md
