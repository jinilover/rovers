module Utility
     ( withinPlateau ) where

import Types

withinPlateau :: Coordinate -> Coordinate -> Bool
withinPlateau (Coordinate x y) (Coordinate maxX maxY) =
  0 <= x && x <= maxX && 0 <= y && y <= maxY
