module Main where

import Lib
import System.Environment
import Types
import FileProcessor

main :: IO ()
main = do
  [fileName] <- getArgs
  fileContent <- readFile fileName
  print . outputMsg . process . lines $ fileContent

outputMsg :: Either String ProcessStatus -> String
outputMsg (Left s) = s
outputMsg (Right Start) = "upper right coordinate not provided"
outputMsg (Right status) = undefined
