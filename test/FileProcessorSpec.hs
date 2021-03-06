module FileProcessorSpec
    ( processSpec
    ) where

import Test.Hspec
import Test.HUnit.Lang
import System.Environment
import FileProcessor
import Types
import Utility

processSpec :: Spec
processSpec =
  describe "FileProcessor Spec" $ do
    it "process InvalidUpperRight.txt correctly" $ readFile "test/resources/InvalidUpperRight.txt" >>= (
        invalidUpperRight . processContent
      )
    it "process InvalidDirection.txt correctly" $ readFile "test/resources/InvalidDirection.txt" >>= (
        invalidDirectionCheck . processContent
      )
    it "process InvalidCommand.txt correctly" $ readFile "test/resources/InvalidCommand.txt" >>= (
        invalidCommandCheck . processContent
      )
    it "process OutOfPlateau.txt correctly" $ readFile "test/resources/OutOfPlateau.txt" >>= (
        outOfPlateauCheck . processContent
      )
    it "process file with all rovers navigate" $ readFile "test/resources/allRoversNavigated.txt" >>= (
        allRoversNavigatedCheck . processContent
      )
    it "process file with last rover just landed" $ readFile "test/resources/lastRoverJustLanded.txt" >>= (
        lastRoverJustLandedCheck . processContent
      )
    it "process file with only upper right" $ readFile "test/resources/onlyUpperRight.txt" >>= (
        onlyUpperRightCheck . processContent
      )
    it "process empty file" $ readFile "test/resources/emptyFile.txt" >>= (
        emptyFileCheck . processContent
      )
      where processContent = process . lines
            invalidUpperRight (Left err) = err `shouldBe` "* can't be parsed to an integer"
            invalidUpperRight _ = assertFailure "It should encounter invalid command"
            invalidDirectionCheck (Left err) = err `shouldBe` "Invalid direction: 'n'"
            invalidDirectionCheck _ = assertFailure "It should encounter invalid direction"
            invalidCommandCheck (Left err) = err `shouldBe` "Invalid command: 'm'"
            invalidCommandCheck _ = assertFailure "It should encounter invalid command"
            outOfPlateauCheck (Left err) = err `shouldBe` "(3, 6) not within (0, 0) to (5, 5)"
            outOfPlateauCheck _ = assertFailure "It should encounter out of plateau error"
            allRoversNavigatedCheck (Right (LandNextRover upperRight ps _)) =
              map show ps `shouldBe` ["(1, 3) N", "(5, 1) E", "(7, 4) E"]
            allRoversNavigatedCheck _ = assertFailure "It should navigate 3 rovers"
            lastRoverJustLandedCheck (Right (NavigateRover upperRight landedPos ps _)) =
              map show (ps ++ [landedPos]) `shouldBe` ["(1, 3) N", "(5, 1) E", "(10, 5) W"]
            lastRoverJustLandedCheck _ = assertFailure "It should navigate 2 rovers and landed 1 rover"
            onlyUpperRightCheck (Right (LandNextRover upperRight [] _)) =
              show upperRight `shouldBe` "(10, 5)"
            onlyUpperRightCheck _ = assertFailure "It should only have upper right for the plateau"
            emptyFileCheck (Right (Start)) = return ()
            emptyFileCheck _ = assertFailure "It should be empty"
