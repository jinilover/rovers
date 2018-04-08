module FileProcessor
    ( process
    ) where

import Types
import Parser
import Mover

process :: [String] -> Either String ProcessStatus
process = foldl (\acc s -> acc >>= (`processLine` s)) (Right SetupPlateau)
  where processLine SetupPlateau =
          fmap (\upperRight -> LandNextRover upperRight [] (execCmds upperRight)) . parseUpperRight
        processLine (LandNextRover upperRight poses land) =
          fmap (NavigateRover upperRight poses . land) . parsePosition upperRight
        processLine (NavigateRover upperRight poses navigate) =
          fmap (\cmds -> LandNextRover upperRight (poses ++ [navigate cmds]) $ execCmds upperRight) . parseCommands
