module Set9b where

import Mooc.Todo

import Data.List

--------------------------------------------------------------------------------
-- Ex 1: In this exercise set, we'll solve the N Queens problem step by step.
-- 练习1：在本练习集中，我们将逐步解决 N 皇后问题。
-- N Queens is a generalisation of the Eight Queens problem described in
-- N 皇后问题是维基百科中描述的八皇后问题的推广：
-- Wikipedia: https://en.wikipedia.org/wiki/Eight_queens_puzzle
-- 维基百科：https://en.wikipedia.org/wiki/Eight_queens_puzzle
--
-- We'll be working with a two-dimensional coordinate system for indexing the
-- 我们将使用二维坐标系来索引任意大小（正方形）棋盘上的皇后。
-- queens on a (square) chessboard of arbitrary size. (1,1) represents the top
-- (1,1) 表示左上角。(1,2) 是顶行的下一个格子，(1,3) 是再后面一个，
-- left corner. (1,2) is the next square on the top row, (1,3) is the one after
-- (2,1) 是第二行的第一个格子，(2,2) 是第二行的第二个格子，以此类推。
-- that, (2,1) is the first square on the second row, (2,2) is the second square
-- 一般来说，坐标的形式为 (行,列)。
-- in the second row, and so on. In general, the coordinates are of the form
-- 以下 8x8 棋盘上皇后的排列将被编码为坐标列表 [(1,8),(2,6),(3,4),(5,7)]：
-- (row,column). The idea is that the following arrangement of queens on a 8x8
-- board will be encoded as the list [(1,8),(2,6),(3,4),(5,7)] of coordinates:
--
--   .......Q
--   .......Q
--   .....Q..
--   .....Q..
--   ...Q....
--   ...Q....
--   ........
--   ........
--   ......Q.
--   ......Q.
--   ........
--   ........
--   ........
--   ........
--   ........
--   ........
--
-- The first exercise is warmup. We'll define two helper functions that we're
-- 第一个练习是热身。我们将定义两个后面会用到的辅助函数：
-- going to use later: nextRow, and nextCol. nextRow increases the row by one
-- nextRow 和 nextCol。nextRow 将行加一并将列重置为 1。
-- and sets column to 1. nextCol only increases the column by one. (By analogy,
-- nextCol 只将列加一。（类比来说，nextRow 的作用类似于打字机中的换行和回车，
-- nextRow works like line break and carriage return while nextCol works like
-- 而 nextCol 的作用类似于打字机中的空格键。）
-- the space bar in a typewriter.)
--
-- Examples:
-- 示例：
--   nextRow (1,1) ==> (2,1)
--   nextRow (1,1) ==> (2,1)
--   nextRow (4,7) ==> (5,1)
--   nextRow (4,7) ==> (5,1)
--   nextCol (1,1) ==> (1,2)
--   nextCol (1,1) ==> (1,2)
--   nextCol (4,7) ==> (4,8)
--   nextCol (4,7) ==> (4,8)
--
-- Before we start, remember type aliases? We define some of them just to make
-- 在开始之前，还记得类型别名吗？我们定义一些类型别名，只是为了使
-- the roles of different function arguments clearer without adding syntactical
-- 不同函数参数的角色更清晰，而不增加语法上的
-- overhead:
-- 开销：

type Row   = Int
type Col   = Int
type Coord = (Row, Col)

nextRow :: Coord -> Coord
nextRow (i,j) = (i+1, 1)

nextCol :: Coord -> Coord
nextCol (i,j) = (i,j+1)

--------------------------------------------------------------------------------
-- Ex 2: Implement the function prettyPrint that, given the size of
-- 练习2：实现函数 prettyPrint，给定棋盘大小和一组互不相同的皇后坐标
-- the chessboard and a list of distinct coordinates of queens (that
-- （即 (行,列) 对的列表），打印带有皇后的棋盘。
-- is, a list of (row,col) pairs), prints the chessboard with the
-- 空格子必须打印为 '.'，皇后打印为 'Q'。
-- queens on it. Empty squares must be printed as '.'s and queens as
-- 每行末尾必须追加特殊的换行字符 '\n'。
-- 'Q's. The special line break character '\n' must be appended to the
-- end of each row.
--
-- Examples:
-- 示例：
--   prettyPrint 3 [(1,1),(2,3),(3,2)] ==> "Q..\n..Q\n.Q.\n"
--   prettyPrint 3 [(1,1),(2,3),(3,2)] ==> "Q..\n..Q\n.Q.\n"
--   prettyPrint 3 [(2,3),(1,1),(3,2)] ==> "Q..\n..Q\n.Q.\n"
--   prettyPrint 3 [(2,3),(1,1),(3,2)] ==> "Q..\n..Q\n.Q.\n"
--   prettyPrint 3 [(1,3),(2,1),(3,2)] ==> "..Q\nQ..\n.Q.\n"
--   prettyPrint 3 [(1,3),(2,1),(3,2)] ==> "..Q\nQ..\n.Q.\n"
--
-- To see how the result looks like with the line breaks correctly printed, use
-- 要查看换行符正确打印后的结果，在 GHCI 中使用 putStrLn。
-- putStrLn in GHCI. To open this module in GHCI, run 'stack ghci Set9b.hs'.
-- 要在 GHCI 中打开此模块，运行 'stack ghci Set9b.hs'。
--
-- Examples:
-- 示例：
--   *Set9b> putStrLn $ prettyPrint 4 [(1,1),(1,4),(4,1),(4,4)]
--   *Set9b> putStrLn $ prettyPrint 4 [(1,1),(1,4),(4,1),(4,4)]
--   Q..Q
--   Q..Q
--   ....
--   ....
--   ....
--   ....
--   Q..Q
--   Q..Q
--
--   *Set9b> putStrLn $ prettyPrint 4 [(4,4),(1,4),(1,1),(4,1)]
--   *Set9b> putStrLn $ prettyPrint 4 [(4,4),(1,4),(1,1),(4,1)]
--   Q..Q
--   Q..Q
--   ....
--   ....
--   ....
--   ....
--   Q..Q
--   Q..Q
--
--   *Set9b> putStrLn $ prettyPrint 7 [(1,1),(2,3),(3,5),(4,7),(5,2),(6,4),(7,6)]
--   *Set9b> putStrLn $ prettyPrint 7 [(1,1),(2,3),(3,5),(4,7),(5,2),(6,4),(7,6)]
--   Q......
--   Q......
--   ..Q....
--   ..Q....
--   ....Q..
--   ....Q..
--   ......Q
--   ......Q
--   .Q.....
--   .Q.....
--   ...Q...
--   ...Q...
--   .....Q.
--   .....Q.
--
-- Hint: Remember the function elem? elem x xs checks if the list xs contains
-- 提示：还记得函数 elem 吗？elem x xs 检查列表 xs 是否包含元素 x，
-- the element x, e.g. elem 1 [2,5,1] ==> True, elem 1 [2,5,2] ==> False.
-- 例如 elem 1 [2,5,1] ==> True，elem 1 [2,5,2] ==> False。
--
-- Challenge: Try defining prettyPrint without elem by just iterating over all
-- 挑战：尝试不使用 elem 来定义 prettyPrint，而是逐个遍历所有坐标。
-- coordinates one at a time. (For those who've had a course in data structures
-- （对于学过数据结构与算法课程的人来说，这个挑战是关于找到
-- and algorithms, this challenge is about finding an O(n^2) solution in terms
-- 一个关于棋盘宽度（或高度）n 的 O(n^2) 解决方案；
-- of the width (or height) n of the chess board; the naïve solution with elem
-- 使用 elem 的朴素解法需要 O(n^3) 时间。
-- takes O(n^3) time. Just ignore the previous sentence, if you're not familiar
-- 如果你不熟悉 O 表示法，请忽略前一句话。）
-- with the O-notation.)

type Size = Int

prettyPrint :: Size -> [Coord] -> String
prettyPrint n ds =
    let initTable = replicate n $ replicate n '.'
        setQueen table (row, col) =
            take (row - 1) table ++
            [take (col - 1) (table !! (row - 1)) ++ ['Q'] ++
             drop col (table !! (row - 1))] ++
            drop row table
        table = foldl setQueen initTable ds
    in unlines table

--------------------------------------------------------------------------------
-- Ex 3: The task in this exercise is to define the relations sameRow, sameCol,
-- 练习3：本练习的任务是定义关系 sameRow、sameCol、sameDiag 和 sameAntidiag，
-- sameDiag, and sameAntidiag that check whether or not two coordinates of the
-- 它们检查形式为 (i,j) :: (Row, Col) 的两个坐标，在不确定大小的棋盘上
-- form (i,j) :: (Row, Col) on a table of indeterminate size are on the same
-- 是否位于同一行、同一列、同一对角线（左上到右下）或同一反对角线（左下到右上）。
-- column, diagonal (top left to bottom right), or antidiagonal (bottom left to
-- 棋盘大小不确定意味着这些关系应该适用于所有大小的棋盘。
-- top right) respectively. Indeterminate size of the table means that these
-- （你可以假设所有坐标都是正数。）
-- relations should work for tables of all sizes. (You may assume that all
-- coordinates will be positive.)
--
-- Examples:
-- 示例：
--   sameRow (1,1) (1,1) ==> True
--   sameRow (1,1) (1,1) ==> True
--   sameRow (1,1) (2,1) ==> False
--   sameRow (1,1) (2,1) ==> False
--   sameRow (1,1) (1,2) ==> True
--   sameRow (1,1) (1,2) ==> True
--   sameCol (1,1) (4,1) ==> True
--   sameCol (1,1) (4,1) ==> True
--   sameCol (1,1) (4,2) ==> False
--   sameCol (1,1) (4,2) ==> False
--   sameDiag (1,1) (2,2) ==> True
--   sameDiag (1,1) (2,2) ==> True
--   sameDiag (1,1) (1,2) ==> False
--   sameDiag (1,1) (1,2) ==> False
--   sameAntidiag (1,1) (1,2) ==> False
--   sameAntidiag (1,1) (1,2) ==> False
--   sameAntidiag (2,10) (5,7) ==> True
--   sameAntidiag (2,10) (5,7) ==> True
--   sameAntidiag (500,5) (5,500) ==> True
--   sameAntidiag (500,5) (5,500) ==> True

sameRow :: Coord -> Coord -> Bool
sameRow (i,j) (k,l) = i == k

sameCol :: Coord -> Coord -> Bool
sameCol (i,j) (k,l) = j == l

sameDiag :: Coord -> Coord -> Bool
sameDiag (i,j) (k,l) = k - i == l - j

sameAntidiag :: Coord -> Coord -> Bool
sameAntidiag (i,j) (k,l) = i - k == l - j

--------------------------------------------------------------------------------
-- Ex 4: In chess, a queen may capture another piece in the same row, column,
-- 练习4：在国际象棋中，皇后可以一步吃掉同一行、同一列、同一对角线
-- diagonal, or antidiagonal in one step. This danger zone, where pieces can be
-- 或同一反对角线上的另一个棋子。这个危险区域（棋子可以被皇后吃掉的区域，
-- captured by a queen (indicated here with the character '#') looks like this:
-- 这里用字符 '#' 表示）看起来像这样：
--
--   .#.#.#..
--   .#.#.#..
--   ..###...
--   ..###...
--   ###Q####
--   ###Q####
--   ..###...
--   ..###...
--   .#.#.#..
--   .#.#.#..
--   #..#..#.
--   #..#..#.
--   ...#...#
--   ...#...#
--   ...#....
--   ...#....
--
-- For multiple queens, the danger zone is the union of the danger zones for
-- 对于多个皇后，危险区域是各个皇后危险区域的并集。
-- individual queens. This means that all coordinates belonging to the danger
-- 这意味着属于一个或多个单独皇后危险区域的所有坐标也属于棋盘上所有皇后的
-- zones of one or more individual queens also belongs to the collective danger
-- 集体危险区域。例如，如果我们在坐标 (4,6) 处添加第二个皇后，危险区域会扩大：
-- zone of all queens on the board. For example, if we add a second queen to the
-- coordinates (4,6), the danger zone grows:
--
--   .###.#..
--   .###.#..
--   ..####.#
--   ..####.#
--   ###Q####
--   ###Q####
--   #####Q##
--   #####Q##
--   .#.####.
--   .#.####.
--   #..#.###
--   #..#.###
--   ..##.#.#
--   ..##.#.#
--   .#.#.#..
--   .#.#.#..
--
-- Implement the function danger that checks if a coordinate belongs to the
-- 实现函数 danger，检查一个坐标是否属于给定皇后（坐标）列表的集体危险区域。
-- collective danger zone of the given list of (coordinates of) queens.
-- 从图形上来说，我们要检查给定坐标处的格子看起来是 '.' 而不是 '#'。
-- Graphically speaking, we want to check if the square at the given coordinates
-- （你可以假设给定坐标与栈中所有坐标都不同。）
-- looks like '.' rather than '#'. (You may assume that the given coordinate
-- will be different from all the coordinates in the stack.)
--
-- Examples:
-- 示例：
--  danger (5,2) [] ==> False
--  danger (5,2) [] ==> False
--  danger (5,2) [(1,2)] ==> True
--  danger (5,2) [(1,2)] ==> True
--  danger (5,2) [(4,3)] ==> True
--  danger (5,2) [(4,3)] ==> True
--  danger (4,5) [(3,4),(4,6)] ==> True
--  danger (4,5) [(3,4),(4,6)] ==> True
--  danger (5,3) [(3,4),(4,6)] ==> False
--  danger (5,3) [(3,4),(4,6)] ==> False
--  danger (5,3) [(3,4),(4,6),(7,5),(6,2),(8,1)] ==> True
--  danger (5,3) [(3,4),(4,6),(7,5),(6,2),(8,1)] ==> True
--
-- Hint: Use the relations of the previous exercise!
-- 提示：使用上一个练习中的关系！
--
-- Lists of coordinates of queens will be later used in a Last In
-- 皇后坐标列表之后将以后进先出（LIFO）的方式使用，因此我们给这个类型取别名 Stack：
-- First Out (LIFO) manner, so we give this type the alias Stack:
-- https://en.wikipedia.org/wiki/Stack_(abstract_data_type)
-- https://en.wikipedia.org/wiki/Stack_(abstract_data_type)

type Candidate = Coord
type Stack     = [Coord]

danger :: Candidate -> Stack -> Bool
danger s = any (\x -> sameCol x s || sameRow x s || sameAntidiag x s || sameDiag x s)

--------------------------------------------------------------------------------
-- Ex 5: In this exercise, the task is to write a modified version of
-- 练习5：在本练习中，任务是编写 prettyPrint 的修改版本，
-- prettyPrint that marks those empty squares with '#' that are in the
-- 将处于给定皇后栈的集体危险区域中的空格子标记为 '#'。
-- collective danger zone of the given stack of queens. You may assume that
-- 你可以假设栈中没有皇后处于另一个皇后的危险区域中。
-- none of the queens in the stack are in the danger zone of another queen.
--
-- Examples:
-- 示例：
--   *Set9b> putStrLn $ prettyPrint2 3 []
--   *Set9b> putStrLn $ prettyPrint2 3 []
--   ...
--   ...
--   ...
--   ...
--   ...
--   ...
--
--   *Set9b> putStrLn $ prettyPrint2 4 [(1,2),(2,4)]
--   *Set9b> putStrLn $ prettyPrint2 4 [(1,2),(2,4)]
--   #Q##
--   #Q##
--   ###Q
--   ###Q
--   .###
--   .###
--   .#.#
--   .#.#
--
--   *Set9b> putStrLn $ prettyPrint2 9 [(5,5)]
--   *Set9b> putStrLn $ prettyPrint2 9 [(5,5)]
--   #...#...#
--   #...#...#
--   .#..#..#.
--   .#..#..#.
--   ..#.#.#..
--   ..#.#.#..
--   ...###...
--   ...###...
--   ####Q####
--   ####Q####
--   ...###...
--   ...###...
--   ..#.#.#..
--   ..#.#.#..
--   .#..#..#.
--   .#..#..#.
--   #...#...#
--   #...#...#
--
-- (For those that did the challenge in exercise 2, there's probably no O(n^2)
-- （对于做了练习2中挑战的人来说，这个版本可能没有 O(n^2) 的解决方案。
-- solution to this version. Any working solution is okay in this exercise.)
-- 任何可行的解决方案在本练习中都可以。）

prettyPrint2 :: Size -> Stack -> String
prettyPrint2 n ss = unlines $ [[if (row,col) `elem` ss then 'Q' else if danger (row,col) ss then '#' else '.' | col <- [1..n]] | row <- [1..n]]

--------------------------------------------------------------------------------
-- Ex 6: Now that we can check if a piece can be safely placed into a square in
-- 练习6：现在我们可以检查一个棋子是否能安全地放置在棋盘上的某个格子中，
-- the chessboard, it's time to write the first piece of the actual solution.
-- 是时候编写实际解决方案的第一部分了。
--
-- Given the size of the chessboard and a stack, the function fixFirst
-- 给定棋盘大小和一个栈，函数 fixFirst 应该取出栈顶的皇后，
-- should take the queen on the top of the stack, and if it is in
-- 如果它处于危险中，就沿同一行向右（列递增方向）移动它，
-- danger, move it right _along the same row_ (in the direction of
-- 直到它不再处于危险中。
-- increasing columns) until it is not in danger.
--
-- If no safe spot is found for the queen on that row, fixFirst should
-- 如果在该行上没有为皇后找到安全位置，fixFirst 应该返回 Nothing。
-- return Nothing.
--
-- Note: this means in particular that if the queen is already outside
-- 注意：这特别意味着如果皇后已经在棋盘之外，应该返回 Nothing。
-- the board, Nothing should be returned.
--
-- Examples:
-- 示例：
--   fixFirst 5 [(1,1)] ==> Just [(1,1)]
--   fixFirst 5 [(1,1)] ==> Just [(1,1)]
--   fixFirst 5 [(3,4)] ==> Just [(3,4)]
--   fixFirst 5 [(3,4)] ==> Just [(3,4)]
--   fixFirst 5 [(1,1),(1,5)] ==> Nothing
--   fixFirst 5 [(1,1),(1,5)] ==> Nothing
--   fixFirst 5 [(1,6)] ==> Nothing
--   fixFirst 5 [(1,6)] ==> Nothing
--   fixFirst 5 [(1,1),(3,3)] ==> Just [(1,2),(3,3)]
--   fixFirst 5 [(1,1),(3,3)] ==> Just [(1,2),(3,3)]
--   fixFirst 5 [(1,3),(3,3)] ==> Just [(1,4),(3,3)]
--   fixFirst 5 [(1,3),(3,3)] ==> Just [(1,4),(3,3)]
--   fixFirst 5 [(2,1),(3,3)] ==> Just [(2,1),(3,3)]
--   fixFirst 5 [(2,1),(3,3)] ==> Just [(2,1),(3,3)]
--   fixFirst 8 [(8,1),(1,1)] ==> Just [(8,2),(1,1)]
--   fixFirst 8 [(8,1),(1,1)] ==> Just [(8,2),(1,1)]
--   fixFirst 8 [(4,1),(3,4),(4,6)] ==> Nothing
--   fixFirst 8 [(4,1),(3,4),(4,6)] ==> Nothing
--   fixFirst 8 [(6,1),(3,4),(4,6)] ==> Just [(6,2),(3,4),(4,6)]
--   fixFirst 8 [(6,1),(3,4),(4,6)] ==> Just [(6,2),(3,4),(4,6)]
--   fixFirst 8 [(5,1),(3,8),(4,6),(7,5),(6,2),(8,1)] ==> Nothing
--   fixFirst 8 [(5,1),(3,8),(4,6),(7,5),(6,2),(8,1)] ==> Nothing
--
-- Hint: Remember prettyPrint and prettyPrint2? They might be useful
-- 提示：还记得 prettyPrint 和 prettyPrint2 吗？它们可能对调试有用。
-- for debugging. For example we can run this to see what's happening
-- 例如，我们可以运行以下命令来查看最后一个示例中发生了什么。
-- in that last example. The whole fifth row is in danger zone.
-- 整个第五行都在危险区域中。
--
--   putStrLn $ prettyPrint2 8 [(3,8),(4,6),(7,5),(6,2),(8,1)]
--   putStrLn $ prettyPrint2 8 [(3,8),(4,6),(7,5),(6,2),(8,1)]
--     ###.####
--     ###.####
--     ##.#####
--     ##.#####
--     #######Q
--     #######Q
--     #####Q##
--     #####Q##
--     ########
--     ########
--     #Q######
--     #Q######
--     ####Q###
--     ####Q###
--     Q#######
--     Q#######

fixFirst :: Size -> Stack -> Maybe Stack
fixFirst n [] = Nothing
fixFirst n ((row,col):rest)
    | col > n = Nothing
    | not (danger (row,col) rest) = Just ((row,col):rest)
    | otherwise = fixFirst n ((row, col+1):rest)

--------------------------------------------------------------------------------
-- Ex 7: We need two helper functions for stack management.
-- 练习7：我们需要两个用于栈管理的辅助函数。
--
-- * continue moves on to a new row. It pushes a new candidate to the
-- * continue 移到新的一行。它将一个新的候选位置压入栈顶（列表前端）。
--   top of the stack (front of the list). The new candidate should be
--   新候选位置应该在之前栈顶皇后的下一行的起始位置。
--   at the beginning of the next row with respect to the queen
--   之前在栈顶的皇后。
--   previously on top of the stack.
--
-- * backtrack moves back to the previous row. It removes the top
-- * backtrack 回到上一行。它移除栈顶元素，并调整新的栈顶元素使其
--   element of the stack, and adjusts the new top element so that it
--   移到下一列。
--   is in the next column.
--
-- Examples:
-- 示例：
--   continue [(1,1)] ==> [(2,1),(1,1)]
--   continue [(1,1)] ==> [(2,1),(1,1)]
--   continue [(2,3),(1,1)] ==> [(3,1),(2,3),(1,1)]
--   continue [(2,3),(1,1)] ==> [(3,1),(2,3),(1,1)]
--   backtrack [(8,1),(7,5),(6,2),(4,6),(3,4)] ==> [(7,6),(6,2),(4,6),(3,4)]
--   backtrack [(8,1),(7,5),(6,2),(4,6),(3,4)] ==> [(7,6),(6,2),(4,6),(3,4)]
--
-- Hint: Remember nextRow and nextCol? Use them!
-- 提示：还记得 nextRow 和 nextCol 吗？使用它们！

continue :: Stack -> Stack
continue [] = [(1,1)]
continue (x : xs) = nextRow x : x : xs

backtrack :: Stack -> Stack
backtrack [] = []
backtrack [_] = []
backtrack (_ : b : xs) = nextCol b : xs

--------------------------------------------------------------------------------
-- Ex 8: Let's take a step. Our algorithm solves the problem (in a
-- 练习8：让我们走一步。我们的算法（以贪心的方式）一次解决一行的
-- greedy manner) one row at a time, backtracking when needed. The
-- 问题，在需要时进行回溯。需要回溯的原因如下。
-- reason why we need backtracking is the following. We can greedily
-- 我们可以贪心地将皇后放在 (1,1) 和 (2,3)，但结果在第三行没有安全位置：
-- put the queens to (1,1) and (2,3) and end up with no safe spot on
-- the third row:
--
--   Q###
--   Q###
--   ##Q#
--   ##Q#
--   ####
--   ####
--   #.##
--   #.##
--
-- However if we backtrack and move the queen from (2,3) to (2,4), we
-- 然而，如果我们回溯并将皇后从 (2,3) 移到 (2,4)，
-- are able to place the third queen:
-- 我们就能放置第三个皇后：
--
--   Q###
--   Q###
--   ###Q
--   ###Q
--   #.##
--   #.##
--   ##.#
--   ##.#
--
-- Implement the function step that takes the size of a board and a
-- 实现函数 step，它接受棋盘大小和一个栈，
-- stack, and tries to fix the position of the queen on the top of the
-- 并尝试修正栈顶皇后的位置（使用 fixFirst）。
-- stack (using fixFirst). If a new position is found, the function
-- 如果找到了新位置，函数应该调用 continue 返回带有新候选位置的栈。
-- should call continue to return a stack with a new candidate. If a
-- 如果没有找到安全位置，函数应该调用 backtrack 返回新的栈。
-- safe position is not found, the function should call backtrack to
-- return a new stack.
--
-- Examples:
-- 示例：
--
--   The first candidate is safe so we continue directly:
--   第一个候选位置是安全的，所以我们直接继续：
--     step 4 [(1,1)] ==> [(2,1),(1,1)]
--     step 4 [(1,1)] ==> [(2,1),(1,1)]
--
--     Q...     Q...
--     Q...     Q...
--     .... ==> Q...
--     .... ==> Q...
--     ....     ....
--     ....     ....
--     ....     ....
--     ....     ....
--
--   The second candidate needs to be adjusted a bit before a third is added:
--   第二个候选位置需要稍作调整才能添加第三个：
--     step 4 [(2,1),(1,1)] ==> [(3,1),(2,3),(1,1)]
--     step 4 [(2,1),(1,1)] ==> [(3,1),(2,3),(1,1)]
--
--     Q...     Q...
--     Q...     Q...
--     Q... ==> ..Q.
--     Q... ==> ..Q.
--     ....     Q...
--     ....     Q...
--     ....     ....
--     ....     ....
--
--   No safe position is found for the third queen so we backtrack:
--   第三个皇后没有找到安全位置，所以我们回溯：
--     step 4 [(3,1),(2,3),(1,1)] ==> [(2,4),(1,1)]
--     step 4 [(3,1),(2,3),(1,1)] ==> [(2,4),(1,1)]
--
--     Q...     Q...
--     Q...     Q...
--     ..Q. ==> ...Q
--     ..Q. ==> ...Q
--     Q...     ....
--     Q...     ....
--     ....     ....
--     ....     ....
--
--   The new position of the second queen is ok so we move to the third row:
--   第二个皇后的新位置没问题，所以我们移到第三行：
--     step 4 [(2,4),(1,1)] ==> [(3,1),(2,4),(1,1)]
--     step 4 [(2,4),(1,1)] ==> [(3,1),(2,4),(1,1)]
--
--     Q...     Q...
--     Q...     Q...
--     ...Q ==> ...Q
--     ...Q ==> ...Q
--     ....     Q...
--     ....     Q...
--     ....     ....
--     ....     ....
--
--   More examples:
--   更多示例：
--     step 8 [(4,2),(3,5),(2,3),(1,1)] ==> [(5,1),(4,2),(3,5),(2,3),(1,1)]
--     step 8 [(4,2),(3,5),(2,3),(1,1)] ==> [(5,1),(4,2),(3,5),(2,3),(1,1)]
--     step 8 [(5,1),(4,2),(3,5),(2,3),(1,1)] ==> [(6,1),(5,4),(4,2),(3,5),(2,3),(1,1)]
--     step 8 [(5,1),(4,2),(3,5),(2,3),(1,1)] ==> [(6,1),(5,4),(4,2),(3,5),(2,3),(1,1)]
--     step 8 [(6,1),(5,4),(4,2),(3,5),(2,3),(1,1)] ==> [(5,5),(4,2),(3,5),(2,3),(1,1)]
--     step 8 [(6,1),(5,4),(4,2),(3,5),(2,3),(1,1)] ==> [(5,5),(4,2),(3,5),(2,3),(1,1)]

step :: Size -> Stack -> Stack
step n s = case fixFirst n s of
    Just s' -> continue s'
    Nothing -> backtrack s

--------------------------------------------------------------------------------
-- Ex 9: Let's solve our puzzle! The function finish takes a partial
-- 练习9：让我们解决这个谜题！函数 finish 接受一个部分解（栈），
-- solution (stack) and repeatedly step until a complete solution is
-- 并反复执行 step 直到找到完整的解。
-- found.
--
-- Reminder: a complete solution has n queens that don't threaten each
-- 提醒：完整的解有 n 个互不威胁的皇后。判断是否得到有效解的一个简单方法是
-- other. One easy way to know you have a valid solution is when step
-- 当 step 添加第 (n+1) 个皇后时。
-- adds the (n+1)th queen.
--
-- After this, it's just a matter of calling `finish n [(1,1)]` to
-- 之后，只需调用 `finish n [(1,1)]` 即可解决 n 皇后问题。
-- solve the n queens problem.

finish :: Size -> Stack -> Stack
finish n s
    | length s <= n = finish n $ step n s
    | otherwise = tail s

solve :: Size -> Stack
solve n = finish n [(1,1)]
