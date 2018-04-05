module Arbitraries
     ( genUpperRight
     , genDirection
     , genPosition
     , genCommand) where

import Test.QuickCheck
import Types

maxX = 25
maxY = maxX

genUpperRight :: Gen Coordinate
genUpperRight = do
  x <- elements [0 .. maxX]
  y <- elements [0 .. maxY]
  return $ Coordinate x y

genDirection :: Gen Direction
genDirection = elements [E, S, W, N]

genPosition :: Coordinate -> Gen Position
genPosition (Coordinate x y) = do
  dir <- genDirection
  xVal <- elements [0 .. x]
  yVal <- elements [0 .. y]
  return $ Position (Coordinate xVal yVal) dir

genCommand :: Gen Command
genCommand = elements [L, R, M]
