module Set8 where

import Data.Char (intToDigit)

import Mooc.Todo

-- This is the final project for Introduction to Functional
-- 这是《函数式编程导论》第一部分的最终项目。
-- Programming, part 1. We'll be developing a sort of functional image
-- 我们将一起开发一种函数式图像库。
-- library together. This file is made up of explanations (like this)
-- 本文件由说明（像这样）和一些预备代码组成。
-- and some prepared code. Some definitions you'll have to fill in
-- 一些定义你需要自己填写，
-- yourself, just like in the previous exercise sets.
-- 就像之前的练习集一样。

-- We'll use the JuicyPixels library to generate images. The library
-- 我们将使用 JuicyPixels 库来生成图像。该库
-- exposes the Codec.Picture module that has everything we need.
-- 暴露了 Codec.Picture 模块，其中包含我们需要的一切。
import Codec.Picture

-- Let's start by defining Colors and Pictures.
-- 让我们从定义颜色和图片开始。

-- A Color is just three numbers: the red, green and blue components.
-- 颜色就是三个数字：红色、绿色和蓝色分量。
-- We use Ints for convenience even though the valid range is only
-- 我们为了方便使用 Int，尽管有效范围仅为
-- 0-255.
-- 0-255。
data Color = Color Int Int Int
  deriving (Show,Eq)

getRed :: Color -> Int
getRed (Color r _ _) = r
getGreen :: Color -> Int
getGreen (Color _ g _) = g
getBlue :: Color -> Int
getBlue (Color _ _ b) = b

-- Here are some colors
-- 这里是一些颜色

black :: Color
black = Color 0 0 0

white :: Color
white = Color 255 255 255

pink :: Color
pink = Color 255 105 180

red :: Color
red = Color 255 0 0

yellow :: Color
yellow = Color 255 240 0

-- A coordinate is two Ints, x and y. In this project, the (0,0)
-- 坐标是两个 Int，x 和 y。在本项目中，(0,0)
-- coordinate is in the top left corner of the image. The x coordinate
-- 坐标位于图像的左上角。x 坐标
-- increases to the right, and the y coordinate increases down.
-- 向右递增，y 坐标向下递增。

data Coord = Coord Int Int

-- A Picture is a wrapper for a function of type Coord -> Color.
-- 图片是类型为 Coord -> Color 的函数的包装器。
-- The function takes in x and y coordinates and returns a color.
-- 该函数接收 x 和 y 坐标并返回一个颜色。

data Picture = Picture (Coord -> Color)

-- Here's a picture that's just a white dot at 10,10
-- 这是一个在 (10,10) 处只有一个白点的图片
justADot = Picture f
  where f (Coord 10 10) = white
        f _             = black

-- Here's a picture that's just a solid color
-- 这是一个纯色的图片
solid :: Color -> Picture
solid color = Picture (\coord -> color)

-- Here's a simple picture:
-- 这是一个简单的图片：
examplePicture1 = Picture f
  where f (Coord x y) | abs (x+y) < 100 = pink    -- top corner is pink
                      | max x y < 200 = white     -- surrounded by a white square
                      | otherwise = black         -- rest of the picture is black


-- In order to find out what our example picture looks like, here's a
-- 为了查看我们的示例图片，这里有一个
-- function that renders a Picture into a png file.
-- 将图片渲染为 png 文件的函数。
--
-- In addition to the Picture it takes a width and a height.
-- 除了图片外，它还接收宽度和高度。
--
-- The return type is IO (). Check Lecture 8 for a short introduction
-- 返回类型是 IO ()。请查看第 8 讲了解
-- to IO
-- IO 的简要介绍

render :: Picture -> Int -> Int -> String -> IO ()
render (Picture f) w h name = writePng name (generateImage (\x y -> colorToPixel (f (Coord x y))) w h)
  where colorToPixel :: Color -> PixelRGB8
        colorToPixel (Color r g b) = PixelRGB8 (fromIntegral r) (fromIntegral g) (fromIntegral b)

-- To see examplePicture1, run this in GHCi:
-- 要查看 examplePicture1，在 GHCi 中运行：
--
--   render examplePicture1 400 300 "example1.png"
--   render examplePicture1 400 300 "example1.png"
--
-- This should produce an example1.png file.
-- 这应该会生成一个 example1.png 文件。
--
-- Remember: You can get open GHCi with `stack ghci Set8.hs`
-- 记住：你可以用 `stack ghci Set8.hs` 打开 GHCi

-- For testing purposes, let's also define some functions for drawing
-- 为了测试目的，我们再定义一些将图片绘制为
-- pictures as lists. It's customary to show colours as hexadecimal
-- 列表的函数。通常将颜色显示为十六进制
-- strings. This is what colorToHex does.
-- 字符串。这就是 colorToHex 所做的。

showHex :: Int -> String
showHex i = [digit (div i 16), digit (mod i 16)]
  where digit x | x>=0 && x<16 = intToDigit x
                | otherwise    = 'X'

colorToHex :: Color -> String
colorToHex (Color r g b) = showHex r ++ showHex g ++ showHex b

getPixel :: Picture -> Int -> Int -> String
getPixel (Picture f) x y = colorToHex (f (Coord x y))
renderList :: Picture -> (Int,Int) -> (Int,Int) -> [[String]]
renderList picture (minx,maxx) (miny,maxy) =
  [[getPixel picture x y | x <- [minx..maxx]] | y <- [miny..maxy]]

-- renderListExample evaluates to
-- renderListExample 的值为
-- [["000000","000000","000000"],
-- [["000000","000000","000000"],
--  ["000000","ffffff","000000"],
--  ["000000","ffffff","000000"],
--  ["000000","000000","000000"]]
--  ["000000","000000","000000"]]
renderListExample = renderList justADot (9,11) (9,11)

------------------------------------------------------------------------------
-- Ex 1: define a picture dotAndLine that has a white dot at (3,4) and
-- 练习1：定义一个图片 dotAndLine，在 (3,4) 处有一个白点，
-- a pink line at y=8. Everywhere else, the picture is black.
-- 在 y=8 处有一条粉线。其他地方图片为黑色。
--
-- Example:
-- 示例：
--   renderList dotAndLine (2,4) (3,9) ==>
--   renderList dotAndLine (2,4) (3,9) ==>
--     [["000000","000000","000000"],
--     [["000000","000000","000000"],
--      ["000000","ffffff","000000"],
--      ["000000","ffffff","000000"],
--      ["000000","000000","000000"],
--      ["000000","000000","000000"],
--      ["000000","000000","000000"],
--      ["000000","000000","000000"],
--      ["000000","000000","000000"],
--      ["ff69b4","ff69b4","ff69b4"],
--      ["ff69b4","ff69b4","ff69b4"],
--      ["000000","000000","000000"]]
--      ["000000","000000","000000"]]

dotAndLine :: Picture
dotAndLine = Picture f
  where
    f (Coord 3 4 ) =  white
    f (Coord _ 8) = pink
    f _ = black
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Ex 2: blending colors and images.
-- 练习2：混合颜色和图像。
--
-- Implement the function blendColor that averages two Colors,
-- 实现函数 blendColor，对两个颜色逐分量取平均值，
-- component by component.
-- 即分别对红、绿、蓝分量取平均。
--
-- Implement the function combine that takes a function and two images
-- 实现函数 combine，它接收一个函数和两个图像，
-- and makes a new image by applying the function to the corresponding
-- 通过将函数应用于原始图像的对应像素来生成新图像。
-- pixels of the original images. For example,
-- 例如，
--
--   combine blendColor p1 p2
--   combine blendColor p1 p2
--
-- should average two images, pixel by pixel.
-- 应该逐像素地平均两个图像。
--
-- PS. Use rounding down integer division (i.e. the div function) for
-- 附：使用向下取整的整数除法（即 div 函数）来
-- the average.
-- 计算平均值。
--
-- Examples:
-- 示例：
--   blendColor (Color 10 100 0) (Color 0 200 40)
--   blendColor (Color 10 100 0) (Color 0 200 40)
--     ==> Color 5 150 20
--     ==> Color 5 150 20
--   renderList (combine (\c1 c2 -> c1) (solid red) justADot) (9,11) (9,11)
--   renderList (combine (\c1 c2 -> c1) (solid red) justADot) (9,11) (9,11)
--     ==> [["ff0000","ff0000","ff0000"],
--     ==> [["ff0000","ff0000","ff0000"],
--          ["ff0000","ff0000","ff0000"],
--          ["ff0000","ff0000","ff0000"],
--          ["ff0000","ff0000","ff0000"]]
--          ["ff0000","ff0000","ff0000"]]
--   renderList (combine blendColor (solid red) justADot) (9,11) (9,11)
--   renderList (combine blendColor (solid red) justADot) (9,11) (9,11)
--     ==> [["7f0000","7f0000","7f0000"],
--     ==> [["7f0000","7f0000","7f0000"],
--          ["7f0000","ff7f7f","7f0000"],
--          ["7f0000","ff7f7f","7f0000"],
--          ["7f0000","7f0000","7f0000"]]
--          ["7f0000","7f0000","7f0000"]]

blendColor :: Color -> Color -> Color
blendColor (Color a b c ) (Color x y z ) =  Color (f a x ) (f b y ) (f c z )
  where f arg1 arg2 = (arg1 + arg2 ) `div` 2

combine :: (Color -> Color -> Color) -> Picture -> Picture -> Picture
combine f (Picture  a ) (Picture b ) = Picture $ \s -> f (a s) (b s)

------------------------------------------------------------------------------

-- Let's define blend, we'll use it later
-- 让我们定义 blend，稍后会用到
blend :: Picture -> Picture -> Picture
blend = combine blendColor

-- In order to draw some more interesting stuff, let's define the
-- 为了绘制更有趣的内容，让我们定义
-- notion of a Shape. A Shape is just a function that takes in
-- 形状（Shape）的概念。形状就是一个函数，它接收
-- coordinates and returns a boolean indicating whether the
-- 坐标并返回一个布尔值，指示该
-- coordinates belong to the shape.
-- 坐标是否属于该形状。

data Shape = Shape (Coord -> Bool)

-- Here's a utility for testing
-- 这是一个测试工具
contains :: Shape -> Int -> Int -> Bool
contains (Shape f) x y = f (Coord x y)

-- The simplest shape is a dot. Here's a function that returns a dot
-- 最简单的形状是一个点。这是一个返回给定位置上的点
-- in a given position.
-- 的函数。

dot :: Int -> Int -> Shape
dot x y = Shape f
  where f (Coord cx cy) = (x==cx) && (y==cy)

-- Here's the definitions of a circle
-- 这是圆的定义

circle :: Int -> Int -> Int -> Shape
circle r cx cy = Shape f
  where f (Coord x y) = (x-cx)^2 + (y-cy)^2 < r^2

-- To be able to draw a Shape we need to convert it to a Picture.
-- 为了能够绘制形状，我们需要将其转换为图片。
-- Here's one way: fill the shape with a given color.
-- 一种方法是：用给定颜色填充形状。

fill :: Color -> Shape -> Picture
fill c (Shape f) = Picture g
  where g coord | f coord = c
                | otherwise = black

-- Here's a picture of a red circle. You can see it by running
-- 这是一个红色圆的图片。你可以通过运行以下命令查看
--   render exampleCircle 400 300 "circle.png"
--   render exampleCircle 400 300 "circle.png"

exampleCircle :: Picture
exampleCircle = fill red (circle 80 100 200)

------------------------------------------------------------------------------
-- Ex 3: implement a rectangle. The value of `rectangle x0 y0 w h`
-- 练习3：实现一个矩形。`rectangle x0 y0 w h` 的值
-- should be a rectangle with the upper left corner at (x0, y0), a
-- 应该是一个左上角在 (x0, y0)、
-- width of w, and a height of h.
-- 宽度为 w、高度为 h 的矩形。
--
-- NB! The rectangle should be exactly w pixels wide and h pixels high!
-- 注意！矩形应该恰好宽 w 像素、高 h 像素！
-- For example, (3,3) isn't in `rectangle 2 2 1 1`.
-- 例如，(3,3) 不在 `rectangle 2 2 1 1` 中。
--
-- Examples:
-- 示例：
--
--  renderList (fill white (rectangle 2 2 1 1)) (0,3) (0,3)
--  renderList (fill white (rectangle 2 2 1 1)) (0,3) (0,3)
--   ==> [["000000","000000","000000","000000"],
--   ==> [["000000","000000","000000","000000"],
--        ["000000","000000","000000","000000"],
--        ["000000","000000","000000","000000"],
--        ["000000","000000","ffffff","000000"],
--        ["000000","000000","ffffff","000000"],
--        ["000000","000000","000000","000000"]]
--        ["000000","000000","000000","000000"]]
--
--  renderList (fill white (rectangle 1 2 4 3)) (0,5) (0,5)
--  renderList (fill white (rectangle 1 2 4 3)) (0,5) (0,5)
--   ==> [["000000","000000","000000","000000","000000","000000"],
--   ==> [["000000","000000","000000","000000","000000","000000"],
--        ["000000","000000","000000","000000","000000","000000"],
--        ["000000","000000","000000","000000","000000","000000"],
--        ["000000","ffffff","ffffff","ffffff","ffffff","000000"],
--        ["000000","ffffff","ffffff","ffffff","ffffff","000000"],
--        ["000000","ffffff","ffffff","ffffff","ffffff","000000"],
--        ["000000","ffffff","ffffff","ffffff","ffffff","000000"],
--        ["000000","000000","000000","000000","000000","000000"]]
--        ["000000","000000","000000","000000","000000","000000"]]

rectangle :: Int -> Int -> Int -> Int -> Shape
rectangle x0 y0 w h = Shape f
  where f (Coord x y ) | x0 <= x  && x <  (x0 + w) && y0 <= y  && y <(y0 +  h) = True
                      | otherwise = False
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Ex 4: combining shapes.
-- 练习4：组合形状。
--
-- We defined Shape in addition to Picture because some operations are
-- 我们除了图片之外还定义了形状，因为有些操作
-- easier to define for Shapes. Implement the union and cut functions.
-- 对形状来说更容易定义。实现 union 和 cut 函数。
--
-- Any point that belongs to one of the shapes should
-- 属于任一形状的点都应该
-- belong to the union.
-- 属于并集。
--
-- Cut should remove all points of the second shape from the first
-- cut 应该从第一个形状中移除第二个形状的
-- shape.
-- 所有点。

union :: Shape -> Shape -> Shape
union (Shape a ) ( Shape b )= Shape $ \s -> a s || b s

cut :: Shape -> Shape -> Shape
cut (Shape a ) ( Shape b )= Shape $ \s -> a s && not (b s)
------------------------------------------------------------------------------

-- Here's a snowman, built using union from circles and rectangles.
-- 这是一个雪人，使用圆和矩形的并集构建。
-- See it by running
-- 通过运行以下命令查看
--   render exampleSnowman 400 300 "snowman.png"
--   render exampleSnowman 400 300 "snowman.png"

exampleSnowman :: Picture
exampleSnowman = fill white snowman
  where snowman = union (cut body mouth) hat
        mouth = rectangle 180 180 40 5
        body = union (circle 50 200 250) (circle 40 200 170)
        hat = union (rectangle 170 130 60 5) (rectangle 180 100 40 30)

------------------------------------------------------------------------------
-- Ex 5: even though we can combine Shapes and convert them to Pictures, we
-- 练习5：虽然我们可以组合形状并将它们转换为图片，但我们
-- can't easily add something to a Picture. Let's fix that.
-- 不容易向图片添加内容。让我们解决这个问题。
--
-- Implement the function paintSolid that takes a color and a shape,
-- 实现函数 paintSolid，它接收一个颜色和一个形状，
-- and draws them on top of an existing picture.
-- 并将它们绘制在现有图片之上。
--
-- Example: renderList (paintSolid pink (dot 10 11) justADot) (9,11) (9,12)
-- 示例：renderList (paintSolid pink (dot 10 11) justADot) (9,11) (9,12)
--   ==> [["000000","000000","000000"],
--        ["000000","ffffff","000000"],
--        ["000000","ff69b4","000000"],
--        ["000000","000000","000000"]]

paintSolid :: Color -> Shape -> Picture -> Picture
paintSolid color (Shape shape) (Picture base) = Picture f
  where f coord | shape coord = color
                | otherwise = base coord
------------------------------------------------------------------------------

allWhite :: Picture
allWhite = solid white

-- Here's a colorful version of the snowman example. See it by running:
-- 这是雪人示例的彩色版本。通过运行以下命令查看：
--   render exampleColorful 400 300 "colorful.png"
--   render exampleColorful 400 300 "colorful.png"

exampleColorful :: Picture
exampleColorful = (paintSolid black hat . paintSolid red legs . paintSolid pink body) allWhite
  where legs = circle 50 200 250
        body = circle 40 200 170
        hat = union (rectangle 170 130 60 5) (rectangle 180 100 40 30)

-- How about painting with a pattern instead of a solid color? Here
-- 如果用图案而不是纯色来绘制呢？这里
-- are the definitions of two patterns (Pictures).
-- 是两种图案（图片）的定义。

stipple :: Color -> Color -> Picture
stipple a b = Picture f
  where f (Coord x y) | even x == even y  = a
                      | otherwise         = b

stripes :: Color -> Color -> Picture
stripes a b = Picture f
  where f (Coord x y) | even y    = a
                      | otherwise = b

-- You can check them out:
-- 你可以查看它们：
--   render (stipple red white) 50 50 "stipple.png"
--   render (stipple red white) 50 50 "stipple.png"
--   render (stripes pink black) 50 50 "stripes.png"
--   render (stripes pink black) 50 50 "stripes.png"

------------------------------------------------------------------------------
-- Ex 6: implement a function paint that works like paintSolid, except
-- 练习6：实现一个函数 paint，其功能类似 paintSolid，不同之处在于
-- the first argument is a pattern (as a Picture).
-- 第一个参数是一个图案（作为图片）。
--
-- Example:
-- 示例：
-- renderList (paint (stripes red white) (rectangle 0 0 2 4) (solid black)) (0,4) (0,4)
-- renderList (paint (stripes red white) (rectangle 0 0 2 4) (solid black)) (0,4) (0,4)
--  ==> [["ff0000","ff0000","000000","000000","000000"],
--       ["ffffff","ffffff","000000","000000","000000"],
--       ["ff0000","ff0000","000000","000000","000000"],
--       ["ffffff","ffffff","000000","000000","000000"],
--       ["000000","000000","000000","000000","000000"]]

paint :: Picture -> Shape -> Picture -> Picture
paint (Picture pat) (Shape shape) (Picture base) = Picture f
  where  f x  | shape x = pat x
              | otherwise =  base x
------------------------------------------------------------------------------

-- Here's a patterned version of the snowman example. See it by running:
-- 这是雪人示例的图案版本。通过运行以下命令查看：
--   render examplePatterns 400 300 "patterns.png"
--   render examplePatterns 400 300 "patterns.png"

examplePatterns :: Picture
examplePatterns = (paint (solid black) hat . paint (stripes red yellow) legs . paint (stipple pink black) body) allWhite
  where legs = circle 50 200 250
        body = circle 40 200 170
        hat = union (rectangle 170 130 60 5) (rectangle 180 100 40 30)

-- What if we want vertical stripes? What if we want wider stripes?
-- 如果我们想要竖条纹呢？如果我们想要更宽的条纹呢？
-- Let's implement zooming and flipping images.
-- 让我们实现图像的缩放和翻转。

flipCoordXY :: Coord -> Coord
flipCoordXY (Coord x y) = (Coord y x)

-- Flip a picture by switching x and y coordinates
-- 通过交换 x 和 y 坐标来翻转图片
flipXY :: Picture -> Picture
flipXY (Picture f) = Picture (f . flipCoordXY)

zoomCoord :: Int -> Coord -> Coord
zoomCoord z (Coord x y) = Coord (div x z) (div y z)

-- Zoom a picture: scale it up by a factor of z
-- 缩放图片：将其放大 z 倍
zoom :: Int -> Picture -> Picture
zoom z (Picture f) = Picture (f . zoomCoord z)

-- Here are some large vertical stripes. See them by running
-- 这里是一些大的竖条纹。通过运行以下命令查看
--   render largeVerticalStripes 400 300 "large-stripes.png"
--   render largeVerticalStripes 400 300 "large-stripes.png"
largeVerticalStripes = zoom 5 (flipXY (stripes red yellow))

-- To support all sorts of image transforms let's use a type class
-- 为了支持各种图像变换，让我们使用一个类型类
-- Transform. A Transform is something that you can apply to an image.
-- Transform。Transform 是你可以应用于图像的东西。

class Transform t where
  apply :: t -> Picture -> Picture

-- Here's a simple image for testing transformations
-- 这是一个用于测试变换的简单图像
xy :: Picture
xy = Picture f
  where f (Coord x y) = Color (mod x 256) (mod y 256) 0

------------------------------------------------------------------------------
-- Ex 7: implement Transform instances for the Fill, Zoom and Flip types.
-- 练习7：为 Fill、Zoom 和 Flip 类型实现 Transform 实例。
--
-- The Fill transform should fill the image completely with the given color.
-- Fill 变换应该用给定颜色完全填充图像。
--
-- The Zoom transform should scale a picture up just like the zoom function above.
-- Zoom 变换应该像上面的 zoom 函数一样放大图片。
--
-- The FlipX transform should flip the image along the vertical axis,
-- FlipX 变换应该沿垂直轴翻转图像，
-- i.e. map (10,15) to (-10,15).
-- 即将 (10,15) 映射为 (-10,15)。
--
-- The FlipY transform should flip the image along the horizontal
-- FlipY 变换应该沿水平轴翻转图像，
-- axis, i.e. map (10,15) to (10,-15).
-- 即将 (10,15) 映射为 (10,-15)。
--
-- The FlipXY transform should switch the x and y coordinates, i.e.
-- FlipXY 变换应该交换 x 和 y 坐标，即
-- map (10,15) to (15,10).
-- 将 (10,15) 映射为 (15,10)。

data Fill = Fill Color

instance Transform Fill where
  apply (Fill c) (Picture f )=  Picture g
    where g coord = c

data Zoom = Zoom Int
  deriving Show

instance Transform Zoom where
  apply (Zoom x ) (Picture f )=  Picture g
    where g = f  . zoomCoord x

data Flip = FlipX | FlipY | FlipXY
  deriving Show

instance Transform Flip where
  apply FlipX (Picture f )=  Picture g
    where g (Coord x y  ) = f ( Coord  (-x ) y )
  apply FlipY (Picture f )=  Picture g
    where g (Coord x y  ) = f ( Coord  x (-y ))
  apply flipXY (Picture f )=  Picture g
    where g (Coord x y  ) = f  ( Coord  y  x )
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Ex 8: the Chain type represents a combination of two transforms.
-- 练习8：Chain 类型表示两个变换的组合。
-- Implement a Transform instance for Chain.
-- 为 Chain 实现 Transform 实例。
--
-- When (Chain t1 t2) is applied to an image, t2 is first applied to
-- 当 (Chain t1 t2) 应用于图像时，首先将 t2 应用于
-- the image, and then t1.
-- 图像，然后再应用 t1。
--
-- Hint: you might need a constraint on the instance
-- 提示：你可能需要在实例上添加约束

data Chain a b = Chain a b
  deriving Show

instance (Transform a, Transform b) => Transform (Chain a b) where
  apply (Chain a b) = apply a . apply b
------------------------------------------------------------------------------

-- Now we can redefine largeVerticalStripes using the above Transforms.
-- 现在我们可以使用上述变换重新定义 largeVerticalStripes。
-- See the picture by running
-- 通过运行以下命令查看图片
--   render largeVerticalStripes2 400 300 "large-stripes2.png"
--   render largeVerticalStripes2 400 300 "large-stripes2.png"
largeVerticalStripes2 :: Picture
largeVerticalStripes2 = apply (Chain (Zoom 5) FlipXY) (stripes red yellow)

-- We can also define a nice checkered pattern by overlaying two stripes.
-- 我们还可以通过叠加两个条纹来定义一个漂亮的棋盘格图案。
-- See it by running
-- 通过运行以下命令查看
--    render checkered 400 300 "checkered.png"
--    render checkered 400 300 "checkered.png"
flipBlend :: Picture -> Picture
flipBlend picture = blend picture (apply FlipXY picture)

checkered :: Picture
checkered = flipBlend largeVerticalStripes2

------------------------------------------------------------------------------
-- Ex 9: implement a Transform instance for Blur.
-- 练习9：为 Blur 实现 Transform 实例。
--
-- Produce a blurred version of an image by taking the average colors
-- 通过取一个像素及其 4 个相邻像素的平均颜色
-- of a pixel and its 4 neighbours.
-- 来生成图像的模糊版本。
--
-- PS. Use rounding down integer division (i.e. the div function) for
-- 附：使用向下取整的整数除法（即 div 函数）来
-- the average.
-- 计算平均值。
--
-- Example: renderList (apply Blur justADot) (8,12) (8,12)
-- 示例：renderList (apply Blur justADot) (8,12) (8,12)
--   ==> [["000000","000000","000000","000000","000000"],
--   ==> [["000000","000000","000000","000000","000000"],
--        ["000000","000000","333333","000000","000000"],
--        ["000000","000000","333333","000000","000000"],
--        ["000000","333333","333333","333333","000000"],
--        ["000000","333333","333333","333333","000000"],
--        ["000000","000000","333333","000000","000000"],
--        ["000000","000000","333333","000000","000000"],
--        ["000000","000000","000000","000000","000000"]]
--        ["000000","000000","000000","000000","000000"]]

data Blur = Blur
  deriving Show

instance Transform Blur where
  apply Blur (Picture f) = Picture g
    where
      g coord = averageColors [f coord,
                               f (up coord),
                               f (down coord),
                               f (left coord),
                               f (right coord)]
      up (Coord x y) = Coord x (y-1)
      down (Coord x y) = Coord x (y+1)
      left (Coord x y) = Coord (x-1) y
      right (Coord x y) = Coord (x+1) y
      averageColors colors = Color avgR avgG avgB
        where
          avgR = sum (map getRed colors) `div` 5
          avgG = sum (map getGreen colors) `div` 5
          avgB = sum (map getBlue colors) `div` 5
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Ex 10: blur an image multiple times. Implement a Transform instance
-- 练习10：多次模糊图像。为 BlurMany 实现 Transform 实例。
-- for BlurMany. The transform BlurMany n should perform Blur n times.
-- 变换 BlurMany n 应该执行 n 次 Blur。
--
-- Example: renderList (apply (BlurMany 2) justADot) (8,12) (8,12)
-- 示例：renderList (apply (BlurMany 2) justADot) (8,12) (8,12)
--   ==> [["000000","000000","0a0a0a","000000","000000"],
--   ==> [["000000","000000","0a0a0a","000000","000000"],
--        ["000000","141414","141414","141414","000000"],
--        ["000000","141414","141414","141414","000000"],
--        ["0a0a0a","141414","333333","141414","0a0a0a"],
--        ["0a0a0a","141414","333333","141414","0a0a0a"],
--        ["000000","141414","141414","141414","000000"],
--        ["000000","141414","141414","141414","000000"],
--        ["000000","000000","0a0a0a","000000","000000"]]
--        ["000000","000000","0a0a0a","000000","000000"]]

data BlurMany = BlurMany Int
  deriving Show

instance Transform BlurMany where
  apply (BlurMany n) = foldr (.) id (replicate n (apply Blur))
------------------------------------------------------------------------------

-- Here's a blurred version of our original snowman. See it by running
-- 这是我们原始雪人的模糊版本。通过运行以下命令查看
--   render blurredSnowman 400 300 "blurred.png"
--   render blurredSnowman 400 300 "blurred.png"

blurredSnowman = apply (BlurMany 2) exampleSnowman
