module FileProcessorSpec
    ( processSpec
    ) where

import Test.Hspec
import Test.HUnit.Lang
import System.Environment
import FileProcessor
import Types

processSpec :: Spec
processSpec =
  describe "FileProcessor Spec" $ do
    it "process InvalidUpperRight.txt correctly" $ readFile "test/resources/InvalidUpperRight.txt" >>= (
        invalidCommandCheck . processContent
      )
    it "process InvalidDirection.txt correctly" $ readFile  "test/resources/InvalidDirection.txt" >>= (
        invalidDirectionCheck . processContent
      )
      where processContent = process . lines
            invalidCommandCheck (Left err) = err `shouldBe` "* can't be parsed to an integer"
            invalidCommandCheck _ = assertFailure "It should encounter invalid command"
            invalidDirectionCheck (Left err) = err `shouldBe` "Invalid direction: 'n'"
            invalidDirectionCheck _ = assertFailure "It should encounter invalid direction"
