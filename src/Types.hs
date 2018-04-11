module Types
    ( Command (L, R, M)
    , Direction (E, S, W, N)
    , Coordinate (Coordinate, x, y)
    , Position (Position, c, heading)
    , ProcessStatus (Start, LandNextRover, NavigateRover)
    ) where

data Command = L | R | M deriving (Show, Eq)

data Direction = E | S | W | N deriving (Show, Eq)

data Coordinate = Coordinate {
                  x :: Int
                , y :: Int} deriving (Show, Eq)

data Position = Position { c :: Coordinate, heading :: Direction } deriving (Show, Eq)

data ProcessStatus = Start
                   | LandNextRover {
                       upperRight :: Coordinate
                     , roverPositions :: [Position]
                     , f :: Position -> [Command] -> Position
                    }
                   | NavigateRover {
                       upperRight :: Coordinate
                     , landedPosition :: Position
                     , roverPositions :: [Position]
                     , f :: Position -> [Command] -> Position
                    }
