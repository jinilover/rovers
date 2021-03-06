module Arbitraries
     ( genUpperRight
     , genDirection
     , genPosition
     , genCommand
     , genList ) where

import Test.QuickCheck
import Types

maxX = 25
maxY = maxX

genUpperRight :: Gen Coordinate
genUpperRight = do
  x <- choose (0, maxX)
  y <- choose (0, maxY)
  return $ Coordinate x y

genDirection :: Gen Direction
genDirection = elements [E, S, W, N]

genPosition :: Coordinate -> Gen Position
genPosition (Coordinate x y) = do
  dir <- genDirection
  xVal <- choose (0, x)
  yVal <- choose (0, y)
  return $ Position (Coordinate xVal yVal) dir

genCommand :: Gen Command
genCommand = elements [L, R, M]

instance Arbitrary Command where
  arbitrary = genCommand

genList :: Arbitrary a => Gen [a]
genList = sized $ \n -> do
  listSize <- choose (0, n)
  mapM (const arbitrary) [1 .. listSize]
