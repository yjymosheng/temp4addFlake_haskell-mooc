-- Exercise set 5b: playing with binary trees
-- 练习集 5b：玩转二叉树

module Set5b where

import Mooc.Todo

-- The next exercises use the binary tree type defined like this:
-- 接下来的练习使用如下定义的二叉树类型：

data Tree a = Empty | Node a (Tree a) (Tree a)
  deriving (Show, Eq)

------------------------------------------------------------------------------
-- Ex 1: implement the function valAtRoot which returns the value at
-- 练习1：实现函数 valAtRoot，返回树的
-- the root (top-most node) of the tree. The return value is Maybe a
-- 根（最顶部节点）的值。返回值为 Maybe a
-- because the tree might be empty (i.e. just a Empty)
-- 因为树可能为空（即只有 Empty）

valAtRoot :: Tree a -> Maybe a
valAtRoot Empty = Nothing
valAtRoot (Node a _ _ ) = Just a


------------------------------------------------------------------------------
-- Ex 2: compute the size of a tree, that is, the number of Node
-- 练习2：计算树的大小，即 Node
-- constructors in it
-- 构造子的数量
--
-- Examples:
-- 示例：
--   treeSize (Node 3 (Node 7 Empty Empty) Empty)  ==>  2
--   treeSize (Node 3 (Node 7 Empty Empty) Empty)  ==>  2
--   treeSize (Node 3 (Node 7 Empty Empty) (Node 1 Empty Empty))  ==>  3
--   treeSize (Node 3 (Node 7 Empty Empty) (Node 1 Empty Empty))  ==>  3

treeSize :: Tree a -> Int
treeSize Empty  =  0
treeSize (Node _ l r )  =   1 + treeSize l + treeSize r


------------------------------------------------------------------------------
-- Ex 3: get the largest value in a tree of positive Ints. The
-- 练习3：获取正整数树中的最大值。
-- largest value of an empty tree should be 0.
-- 空树的最大值应为 0。
--
-- Examples:
-- 示例：
--   treeMax Empty  ==>  0
--   treeMax Empty  ==>  0
--   treeMax (Node 3 (Node 5 Empty Empty) (Node 4 Empty Empty))  ==>  5
--   treeMax (Node 3 (Node 5 Empty Empty) (Node 4 Empty Empty))  ==>  5

treeMax :: Tree Int -> Int
treeMax  t = go t  0
  where
    go Empty a  = max  0 a
    go (Node x  l r ) a  =  max x  ( max (go l a) ( go r a) ) 

------------------------------------------------------------------------------
-- Ex 4: implement a function that checks if all tree values satisfy a
-- 练习4：实现一个函数，检查树中所有值是否满足
-- condition.
-- 某个条件。
--
-- Examples:
-- 示例：
--   allValues (>0) Empty  ==>  True
--   allValues (>0) Empty  ==>  True
--   allValues (>0) (Node 1 Empty (Node 2 Empty Empty))  ==>  True
--   allValues (>0) (Node 1 Empty (Node 2 Empty Empty))  ==>  True
--   allValues (>0) (Node 1 Empty (Node 0 Empty Empty))  ==>  False
--   allValues (>0) (Node 1 Empty (Node 0 Empty Empty))  ==>  False

allValues :: (a -> Bool) -> Tree a -> Bool
allValues condition Empty = True
allValues condition (Node  x l r  )= condition x  &&  allValues condition l && allValues condition r 


------------------------------------------------------------------------------
-- Ex 5: implement map for trees.
-- 练习5：为树实现 map。
--
-- Examples:
-- 示例：
--
-- mapTree (+1) Empty  ==>  Empty
-- mapTree (+1) Empty  ==>  Empty
-- mapTree (+2) (Node 0 (Node 1 Empty Empty) (Node 2 Empty Empty))
-- mapTree (+2) (Node 0 (Node 1 Empty Empty) (Node 2 Empty Empty))
--   ==> (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty))
--   ==> (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty))

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f t = todo

------------------------------------------------------------------------------
-- Ex 6: given a value and a tree, build a new tree that is the same,
-- 练习6：给定一个值和一棵树，构建一棵相同的新树，
-- except all nodes that contain the value have been removed. Also
-- 但包含该值的所有节点已被移除。同时
-- remove the subnodes of the removed nodes.
-- 移除被删除节点的子节点。
--
-- Examples:
-- 示例：
--
--     1          1
--     1          1
--    / \   ==>    \
--    / \   ==>    \
--   2   0          0
--   2   0          0
--
--  cull 2 (Node 1 (Node 2 Empty Empty)
--  cull 2 (Node 1 (Node 2 Empty Empty)
--                 (Node 0 Empty Empty))
--                 (Node 0 Empty Empty))
--     ==> (Node 1 Empty
--     ==> (Node 1 Empty
--                 (Node 0 Empty Empty))
--                 (Node 0 Empty Empty))
--
--      1           1
--      1           1
--     / \           \
--     / \           \
--    2   0   ==>     0
--    2   0   ==>     0
--   / \
--   / \
--  3   4
--  3   4
--
--  cull 2 (Node 1 (Node 2 (Node 3 Empty Empty)
--  cull 2 (Node 1 (Node 2 (Node 3 Empty Empty)
--                         (Node 4 Empty Empty))
--                         (Node 4 Empty Empty))
--                 (Node 0 Empty Empty))
--                 (Node 0 Empty Empty))
--     ==> (Node 1 Empty
--     ==> (Node 1 Empty
--                 (Node 0 Empty Empty)
--                 (Node 0 Empty Empty)
--
--    1              1
--    1              1
--   / \              \
--   / \              \
--  0   3    ==>       3
--  0   3    ==>       3
--   \   \
--   \   \
--    2   0
--    2   0
--
--  cull 0 (Node 1 (Node 0 Empty
--  cull 0 (Node 1 (Node 0 Empty
--                         (Node 2 Empty Empty))
--                         (Node 2 Empty Empty))
--                 (Node 3 Empty
--                 (Node 3 Empty
--                         (Node 0 Empty Empty)))
--                         (Node 0 Empty Empty)))
--     ==> (Node 1 Empty
--     ==> (Node 1 Empty
--                 (Node 3 Empty Empty))
--                 (Node 3 Empty Empty))

cull :: Eq a => a -> Tree a -> Tree a
cull val tree@(Node  a l r )= if a == val then  Empty else  Node a  (cull val  l) (cull val  r ) 
cull val tree = tree

------------------------------------------------------------------------------
-- Ex 7: check if a tree is ordered. A tree is ordered if:
-- 练习7：检查树是否有序。一棵树是有序的如果：
--  * all values to the left of the root are smaller than the root value
--  * 根左侧的所有值都小于根的值
--  * all of the values to the right of the root are larger than the root value
--  * 根右侧的所有值都大于根的值
--  * and the left and right subtrees are ordered.
--  * 并且左右子树也是有序的。
--
-- Hint: allValues will help you here!
-- 提示：allValues 会在这里帮助你！
--
-- Examples:
-- 示例：
--         1
--         1
--        / \   is ordered:
--        / \   是有序的：
--       0   2
--       0   2
--   isOrdered (Node 1 (Node 0 Empty Empty)
--   isOrdered (Node 1 (Node 0 Empty Empty)
--                     (Node 2 Empty Empty))   ==>   True
--                     (Node 2 Empty Empty))   ==>   True
--
--         1
--         1
--        / \   is not ordered:
--        / \   不是有序的：
--       2   3
--       2   3
--   isOrdered (Node 1 (Node 2 Empty Empty)
--   isOrdered (Node 1 (Node 2 Empty Empty)
--                     (Node 3 Empty Empty))   ==>   False
--                     (Node 3 Empty Empty))   ==>   False
--
--           2
--           2
--         /   \
--         /   \
--        1     3   is not ordered:
--        1     3   不是有序的：
--         \
--          \
--          0
--          0
--   isOrdered (Node 2 (Node 1 Empty
--   isOrdered (Node 2 (Node 1 Empty
--                             (Node 0 Empty Empty))
--                             (Node 0 Empty Empty))
--                     (Node 3 Empty Empty))   ==>   False
--                     (Node 3 Empty Empty))   ==>   False
--
--           2
--           2
--         /   \
--         /   \
--        0     3   is ordered:
--        0     3   是有序的：
--         \
--          \
--          1
--          1
--   isOrdered (Node 2 (Node 0 Empty
--   isOrdered (Node 2 (Node 0 Empty
--                             (Node 1 Empty Empty))
--                             (Node 1 Empty Empty))
--                     (Node 3 Empty Empty))   ==>   True
--                     (Node 3 Empty Empty))   ==>   True

isOrdered :: Ord a => Tree a -> Bool
isOrdered Empty = True 
isOrdered (Node  a  l r )=  allValues (<a ) l  &&   allValues (>a ) r && isOrdered l && isOrdered r

------------------------------------------------------------------------------
-- Ex 8: a path in a tree can be represented as a list of steps that
-- 练习8：树中的路径可以表示为一系列步骤，
-- go either left or right.
-- 每个步骤向左或向右走。

data Step = StepL | StepR
  deriving (Show, Eq)

-- Define a function walk that takes a tree and a list of steps, and
-- 定义一个函数 walk，接受一棵树和一系列步骤，
-- returns the value at that point. Return Nothing if you fall of the
-- 返回该位置的值。如果你走出了树
-- tree (i.e. hit a Empty).
-- （即遇到 Empty），则返回 Nothing。
--
-- Examples:
-- 示例：
--   walk [] (Node 1 (Node 2 Empty Empty) Empty)       ==>  Just 1
--   walk [] (Node 1 (Node 2 Empty Empty) Empty)       ==>  Just 1
--   walk [StepL] (Node 1 (Node 2 Empty Empty) Empty)  ==>  Just 2
--   walk [StepL] (Node 1 (Node 2 Empty Empty) Empty)  ==>  Just 2
--   walk [StepL,StepL] (Node 1 (Node 2 Empty Empty) Empty)  ==>  Nothing
--   walk [StepL,StepL] (Node 1 (Node 2 Empty Empty) Empty)  ==>  Nothing

walk :: [Step] -> Tree a -> Maybe a
walk = todo

------------------------------------------------------------------------------
-- Ex 9: given a tree, a path and a value, set the value at the end of
-- 练习9：给定一棵树、一条路径和一个值，将路径末尾的值
-- the path to the given value. Since Haskell datastructures are
-- 设置为给定值。由于 Haskell 数据结构是
-- immutable, you'll need to build a new tree.
-- 不可变的，你需要构建一棵新树。
--
-- If the path falls off the tree, do nothing.
-- 如果路径走出了树，则不做任何操作。
--
-- Examples:
-- 示例：
--   set [] 1 (Node 0 Empty Empty)  ==>  (Node 1 Empty Empty)
--   set [] 1 (Node 0 Empty Empty)  ==>  (Node 1 Empty Empty)
--   set [StepL,StepL] 1 (Node 0 (Node 0 (Node 0 Empty Empty)
--   set [StepL,StepL] 1 (Node 0 (Node 0 (Node 0 Empty Empty)
--                                       (Node 0 Empty Empty))
--                                       (Node 0 Empty Empty))
--                               (Node 0 Empty Empty))
--                               (Node 0 Empty Empty))
--                  ==>  (Node 0 (Node 0 (Node 1 Empty Empty)
--                  ==>  (Node 0 (Node 0 (Node 1 Empty Empty)
--                                       (Node 0 Empty Empty))
--                                       (Node 0 Empty Empty))
--                               (Node 0 Empty Empty))
--                               (Node 0 Empty Empty))
--
--   set [StepL,StepR] 1 (Node 0 Empty Empty)  ==>  (Node 0 Empty Empty)
--   set [StepL,StepR] 1 (Node 0 Empty Empty)  ==>  (Node 0 Empty Empty)

set :: [Step] -> a -> Tree a -> Tree a
set path val tree = todo

------------------------------------------------------------------------------
-- Ex 10: given a value and a tree, return a path that goes from the
-- 练习10：给定一个值和一棵树，返回从根
-- root to the value. If the value doesn't exist in the tree, return Nothing.
-- 到该值的路径。如果值不存在于树中，则返回 Nothing。
--
-- You may assume the value occurs in the tree at most once.
-- 你可以假设该值在树中最多出现一次。
--
-- Examples:
-- 示例：
--   search 1 (Node 2 (Node 1 Empty Empty) (Node 3 Empty Empty))  ==>  Just [StepL]
--   search 1 (Node 2 (Node 1 Empty Empty) (Node 3 Empty Empty))  ==>  Just [StepL]
--   search 1 (Node 2 (Node 4 Empty Empty) (Node 3 Empty Empty))  ==>  Nothing
--   search 1 (Node 2 (Node 4 Empty Empty) (Node 3 Empty Empty))  ==>  Nothing
--   search 1 (Node 2 (Node 3 (Node 4 Empty Empty)
--   search 1 (Node 2 (Node 3 (Node 4 Empty Empty)
--                            (Node 1 Empty Empty))
--                            (Node 1 Empty Empty))
--                    (Node 5 Empty Empty))                     ==>  Just [StepL,StepR]
--                    (Node 5 Empty Empty))                     ==>  Just [StepL,StepR]

search :: Eq a => a -> Tree a -> Maybe [Step]
search = todo
