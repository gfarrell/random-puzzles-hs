# Random Puzzles

A collection of random puzzles written in Haskell. Some of these will be
ideas for interview challenges.

There is no executable version of this, it is designed to be run as
tests only. To run the puzzles, use `stack test`.

If you can think of more fun puzzles let me know and I'll add them!

## 01: Rectangles

*Aim:* find the top left and bottom right corners of a series of
rectangles in an image. The image is represented as a matrix of `Pixel`s
(`[[Pixel]]`), which can be either `On` or `Off`.

To make this a bit easier, the *only* shapes will be rectangles, and
they won't overlap, so you don't have to worry about other polygons.

### Example

```haskell
let image = [ [Off, Off, Off, Off, Off, Off, Off]
            , [Off, Off, Off, Off, Off, Off, Off]
            , [Off, Off, Off,  On,  On,  On, Off]
            , [Off, Off, Off,  On,  On,  On, Off]
            , [Off, Off, Off, Off, Off, Off, Off] ]
```

We would expect the result of this to be a pair of coordinates:

- Top left: (3, 2)
- Bottom right: (5, 3)

### Files:

- [source](src/Rectangles.hs)
- [proof](test/RectanglesSpec.hs)
