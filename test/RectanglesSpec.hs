module RectanglesSpec (spec) where

import Test.Hspec
import Rectangles

spec :: Spec
spec = do
  describe "findRect" $ do
    it "finds the edges of a rectangle" $
      let image = [ [Off, Off, Off, Off, Off, Off, Off]
                  , [Off, Off, Off, Off, Off, Off, Off]
                  , [Off, Off, Off,  On,  On,  On, Off]
                  , [Off, Off, Off,  On,  On,  On, Off]
                  , [Off, Off, Off, Off, Off, Off, Off] ]
          exp   = [Rect 3 2 5 3]
      in findRect image `shouldBe` exp

    it "finds the edges of multiple rectangles" $ do
      let image = [ [Off, Off, Off, Off, Off, Off, Off]
                  , [Off, Off, Off, Off, Off, Off, Off]
                  , [Off, Off, Off,  On,  On,  On, Off]
                  , [Off,  On, Off,  On,  On,  On, Off]
                  , [Off,  On, Off, Off, Off, Off, Off]
                  , [Off,  On, Off,  On,  On, Off, Off]
                  , [Off, Off, Off,  On,  On, Off, Off]
                  , [Off, Off, Off, Off, Off, Off, Off] ]
          exp   = [ Rect 1 3 1 5, Rect 3 2 5 3, Rect 3 5 4 6 ]
          res   = findRect image
      length res `shouldBe` 3
      res `shouldSatisfy` all (`elem` exp)

  describe "findStart" $ do
    it "returns Nothing if there is no On in a row" $
      let row = [Off, Off, Off, Off, Off, Off]
       in findStart row 0 `shouldBe` Nothing

    it "returns Just the index of the first On value, given the offset" $ do
      let row = [Off, Off, On, On, Off, On, Off]
      findStart row 4 `shouldBe` Just 5
      findStart row 3 `shouldBe` Just 3
      findStart row 2 `shouldBe` Just 2
      findStart row 1 `shouldBe` Just 2
      findStart row 0 `shouldBe` Just 2

  describe "traverseX" $ do
    context "given a basic row" $ do
      let row = [Off, Off, On, On, On, Off, Off, On, On, On, Off]

      it "returns the count of contiguous On values" $
        traverseX row 2 `shouldBe` 3

      it "returns the correct count in the presence of two groups of Ons" $
        traverseX row 7 `shouldBe` 3

      it "returns the correct count of the last On value when starting at that last one" $
        traverseX row 4 `shouldBe` 1

    it "returns the correct count even if the Ons go to the end" $
      let row = [Off, Off, On, On, On, On]
       in traverseX row 2 `shouldBe` 4

  describe "traverseY" $
    context "given a standard rect" $ do
      let image = [ [Off, Off,  On,  On, Off, Off]
                  , [Off, Off,  On,  On, Off, Off]
                  , [Off, Off,  On,  On, Off, Off]
                  , [Off, Off,  On, Off, Off, Off]
                  , [Off, Off, Off, Off, Off, Off] ]

      it "returns the number of contiguous Ons in a column" $ do
        traverseY image 2 `shouldBe` 4
        traverseY image 3 `shouldBe` 3

  describe "inRect" $ do
    let rect = Rect 2 3 4 6

    it "returns True if a pair of coordinates is inside a rectangle" $
      inRect 3 4 rect `shouldBe` True

    it "returns True if a pair of coordinates is on the edge of the rectangle" $ do
      inRect 2 3 rect `shouldBe` True
      inRect 4 6 rect `shouldBe` True

    it "returns False if a pair of coordinates is outside the rectangle" $
      inRect 1 5 rect `shouldBe` False
