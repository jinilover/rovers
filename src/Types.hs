module Types
    ( Command (L, R, M)
    , Direction (E, S, W, N)
    , Coordinate (Coordinate, x, y)
    , Position (Position, c, heading)
    , ProcessStatus (SetupPlateau, LandNextRover, NavigateRover)
    ) where

data Command = L | R | M deriving (Show, Eq)

data Direction = E | S | W | N deriving (Show, Eq)

data Coordinate = Coordinate {
                  x :: Int
                , y :: Int} deriving (Show, Eq)

data Position = Position { c :: Coordinate, heading :: Direction } deriving (Show, Eq)

data ProcessStatus = SetupPlateau
                   | LandNextRover {
                       upperRight :: Coordinate
                     , roverPositions :: [Position]
                     , land :: Position -> [Command] -> Position
                    }
                   | NavigateRover {
                       upperRight :: Coordinate
                     , roverPositions :: [Position]
                     , navigate :: [Command] -> Position
                    }
