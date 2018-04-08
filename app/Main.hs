module Main where

import Lib
import System.Environment
import Types
import FileProcessor

main :: IO ()
main = do
  [fileName] <- getArgs
  fileContent <- readFile fileName
  case (process . lines) fileContent of
    Left s -> print s
    Right SetupPlateau -> undefined
    Right status -> undefined
