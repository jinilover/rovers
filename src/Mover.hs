module Mover
    ( execCmd
    , execCmds
    ) where

import Types

execCmds :: Coordinate -> Position -> [Command] -> Position
execCmds = foldl . execCmd

execCmd :: Coordinate -> Position -> Command -> Position
execCmd (Coordinate maxX maxY) origPos cmd =
  case (origPos, cmd) of
    (Position c@(Coordinate x _) E, M) -> origPos { c = c { x = changeStep x 1 maxX} }
    (Position c@(Coordinate x _) W, M) -> origPos { c = c { x = changeStep x (-1) maxX} }
    (Position c@(Coordinate _ y) S, M) -> origPos { c = c { y = changeStep y (-1) maxY} }
    (Position c@(Coordinate _ y) N, M) -> origPos { c = c { y = changeStep y 1 maxY} }
    (Position _ E, L) -> origPos { heading = turnNorS False}
    (Position _ W, R) -> origPos { heading = turnNorS False}
    (Position _ E, _) -> origPos { heading = turnNorS True }
    (Position _ W, _) -> origPos { heading = turnNorS True }
    (Position _ S, L) -> origPos { heading = turnEorW False }
    (Position _ N, R) -> origPos { heading = turnEorW False }
    _ -> origPos { heading = turnEorW True }

turn :: Direction -> Direction -> Bool -> Direction
turn left right pickRight = if pickRight then right else left

turnNorS :: Bool -> Direction
turnNorS = turn N S

turnEorW :: Bool -> Direction
turnEorW = turn E W

changeStep :: Int -> Int -> Int -> Int
changeStep n change limit =
  let newN = n + change in
  if newN < 0 || newN > limit then n else newN
