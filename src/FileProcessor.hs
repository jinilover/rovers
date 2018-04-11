module FileProcessor
    ( process
    ) where

import Types
import Parser
import Mover

process :: [String] -> Either String ProcessStatus
process = foldl (\acc s -> acc >>= (`processLine` s)) (Right Start)
  where processLine Start =
          fmap (\upperRight -> LandNextRover upperRight [] (execCmds upperRight)) . parseUpperRight
        processLine (LandNextRover upperRight ps f) =
          fmap (\p -> NavigateRover upperRight p ps f) . parsePosition upperRight
        processLine (NavigateRover upperRight p ps f) =
          fmap (\cmds -> LandNextRover upperRight (ps ++ [f p cmds]) $ execCmds upperRight) . parseCommands
