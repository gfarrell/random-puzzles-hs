module Rectangles (
  Pixel (..),
  findRect,
  Rect (..),
  findStart,
  traverseX,
  traverseY,
  inRect
  ) where

data Pixel = On | Off
  deriving (Show, Eq)

data Rect = Rect Int Int Int Int
  deriving (Show, Eq)

inRect :: Int -> Int -> Rect -> Bool
inRect x y (Rect a b c d) = x >= a && x <= c
                         && y >= b && y <= d

-- NB this gives not the index but the column count
traverseX :: [Pixel] -> Int -> Int
traverseX row start = traverseX' . drop start $ row
  where traverseX' :: [Pixel] -> Int
        traverseX' []       = 0
        traverseX' (On:xs)  = 1 + traverseX' xs
        traverseX' (Off:xs) = 0

-- NB this gives not the index but the row count
traverseY :: [[Pixel]] -> Int -> Int
traverseY [] _           = 0
traverseY [[]] _         = 0
traverseY (row:others) i = if (row !! i) == On
                             then 1 + traverseY others i
                             else 0

findStart :: [Pixel] -> Int -> Maybe Int
findStart row offset = (offset +) <$> findStart' (drop offset row)
  where findStart' :: [Pixel] -> Maybe Int
        findStart' [] = Nothing
        findStart' (Off:xs) = (1 +) <$> findStart' xs
        findStart' (On:xs)  = Just 0

findRect :: [[Pixel]] -> [Rect]
findRect []   = []
findRect [[]] = []
findRect image = rFindRect image [] 0 0
  where rFindRect :: [[Pixel]] -> [Rect] -> Int -> Int -> [Rect]
        rFindRect [] rects _ _   = rects
        rFindRect [[]] rects _ _ = rects
        rFindRect image@(row:rows) rects x y =
          let start = findStart row x
           in case start of Nothing -> rFindRect rows rects 0 (y + 1)
                            Just s  -> let xb = (s - 1) + traverseX row s
                                           yb = y + traverseY rows s
                                           nR = if any (inRect s y) rects
                                                   then rects
                                                   else Rect s y xb yb : rects
                                        in rFindRect image nR (xb + 1) y
