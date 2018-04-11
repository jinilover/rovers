{-# LANGUAGE QuasiQuotes #-}

module Utility
     ( withinPlateau
     , present ) where

import Types
import Data.String.Interpolate

withinPlateau :: Coordinate -> Coordinate -> Bool
withinPlateau (Coordinate x y) (Coordinate maxX maxY) =
  0 <= x && x <= maxX && 0 <= y && y <= maxY

class Presentable a where
  present :: a -> String

instance Presentable Coordinate where
  present (Coordinate x y) = [i|(#{x}, #{y})|]

instance Presentable Position where
  present (Position p heading) = [i|#{present p} #{heading}|]
