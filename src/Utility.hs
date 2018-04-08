{-# LANGUAGE QuasiQuotes #-}

module Utility
     ( withinPlateau
     , presentCoord ) where

import Types
import Data.String.Interpolate

withinPlateau :: Coordinate -> Coordinate -> Bool
withinPlateau (Coordinate x y) (Coordinate maxX maxY) =
  0 <= x && x <= maxX && 0 <= y && y <= maxY

presentCoord :: Coordinate -> String
presentCoord (Coordinate x y) = [i|(#{x}, #{y})|]
