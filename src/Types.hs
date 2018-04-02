module Types
    ( Command (L, R, M)
    , Direction (E, S, W, N)
    , Coordinate (Coordinate, x, y)
    , Position (Position, c, heading)
    , ProcessStatus
    ) where

data Command = L | R | M

data Direction = E | S | W | N deriving (Show, Eq)

data Coordinate = Coordinate {
                  x :: Int
                , y :: Int} deriving (Show, Eq)

data Position = Position { c :: Coordinate, heading :: Direction } deriving (Show, Eq)

data ProcessStatus = SetupPlateau
                   | LandNextRover {
                       upperRight :: Coordinate
                     , land :: Position -> [Command] -> Position
                    }
                   | NavigateRover {
                       upperRight :: Coordinate
                     , navigate :: [Command] -> Position
                    }
