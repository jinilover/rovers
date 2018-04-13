{-# LANGUAGE QuasiQuotes #-}

module Main where

import Lib
import System.Environment
import Types
import FileProcessor
import Utility
import Data.List
import Data.String.Interpolate

main :: IO ()
main = do
  [fileName] <- getArgs
  fileContent <- readFile fileName
  putStrLn . outputMsg . process . lines $ fileContent

outputMsg :: Either String ProcessStatus -> String
outputMsg (Left s) = s
outputMsg (Right Start) = "upper right coordinate not provided"
outputMsg (Right (LandNextRover upperRight [] _)) = [i|Only have upper right coordinate #{present upperRight}|]
outputMsg (Right (LandNextRover _ ps _)) = intercalate "\n" $ fmap present ps
outputMsg (Right (NavigateRover _ landedPos ps _)) = intercalate "\n" $ fmap present (ps ++ [landedPos])
