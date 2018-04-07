{-# LANGUAGE QuasiQuotes #-}

module Parser
     ( parseCoordinate
     , parseUpperRight
     , parsePosition
     , parseCommands ) where

import Types
import Utility
import Text.Read
import Data.Bifunctor
import Data.Monoid
import Data.List.Split
import Data.String.Interpolate

parseCoordinate :: String -> String -> Either String Coordinate
parseCoordinate x y = do
  xCoord <- parseInt x
  yCoord <- parseInt y
  return $ Coordinate xCoord yCoord

parseUpperRight :: String -> Either String Coordinate
parseUpperRight s = (toCoord . splitBySpace) s
  where toCoord [x, y] = parseCoordinate x y
        toCoord xs = Left [i|#{(show . length) xs} items in '#{s}', there should be 2 items|]

parsePosition :: Coordinate -> String -> Either String Position
parsePosition upperRight s = (toPosition . splitBySpace) s
  where toPosition [x, y, d : ""] = do
          coord <- parseCoordinate x y
          _ <- if withinPlateau coord upperRight then Right () else Left [i|(#{x}, #{y}) not within (0, 0) to #{show coord}|]
          dir <- parseDirection d
          return $ Position coord dir
        toPosition xs = Left [i|#{(show . length) xs} items in '#{s}', there should be 3 items|]

parseDirection :: Char -> Either String Direction
parseDirection 'E' = Right E
parseDirection 'S' = Right S
parseDirection 'W' = Right W
parseDirection 'N' = Right N
parseDirection unknown = Left [i|Invalid direction: #{unknown}|]

parseCommands :: String -> Either String [Command]
parseCommands = mapM parseCommand

parseCommand :: Char -> Either String Command
parseCommand 'L' = Right L
parseCommand 'R' = Right R
parseCommand 'M' = Right M
parseCommand unknown = Left [i|Invalid command: #{unknown}|]

splitBySpace :: String -> [String]
splitBySpace = splitOn " "

parseInt :: String -> Either String Int
parseInt s = first (<> " for " <> s) . readEither $ s
