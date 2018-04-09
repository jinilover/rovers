module ParserSpec
     ( parserSpec ) where

import Test.Hspec
import Parser
import Types

parserSpec :: Spec
parserSpec =
  describe "Parser spec" $ do
    it "parse commands correctly" $ do
      parseCommands "LMLMLMLMM" `shouldBe` Right [L, M, L, M, L, M, L, M, M]
      parseCommands "MMRMMRMRRM" `shouldBe` Right [M, M, R, M, M, R, M, R, R, M]
      parseCommands "MMRLMMRMLRRM" `shouldBe` Right [M, M, R, L, M, M, R, M, L, R, R, M]
      parseCommands " MMRLMMRMLRRM" `shouldBe` Left "Invalid command: ' '"
      parseCommands "MMRLMMRMLRR M" `shouldBe` Left "Invalid command: ' '"
      parseCommands "MMRLMMRMLRERM" `shouldBe` Left "Invalid command: 'E'"
    it "parse coordinate correctly" $ do
      parseCoordinate "5" "5" `shouldBe` Right (Coordinate 5 5)
      parseCoordinate "1o" "2" `shouldBe` Left "1o can't be parsed to an integer"
    it "parse upper right correctly" $ do
      parseUpperRight "5 5" `shouldBe` Right (Coordinate 5 5)
      parseUpperRight "5" `shouldBe` Left "1 items in '5' in parsing the upper right coordinate, there should be 2 items"
      parseUpperRight "5 5 5" `shouldBe` Left "3 items in '5 5 5' in parsing the upper right coordinate, there should be 2 items"
    it "parse position correctly" $ do
      parsePosition upperRight "1 2 E" `shouldBe` Right (Position (Coordinate 1 2) E)
      parsePosition upperRight "1 2 S" `shouldBe` Right (Position (Coordinate 1 2) S)
      parsePosition upperRight "1 2 W" `shouldBe` Right (Position (Coordinate 1 2) W)
      parsePosition upperRight "1 2 N" `shouldBe` Right (Position (Coordinate 1 2) N)
      parsePosition upperRight "1 2 e" `shouldBe` Left "Invalid direction: 'e'"
      parsePosition upperRight "1 x2 e" `shouldBe` Left "x2 can't be parsed to an integer"
      parsePosition upperRight "1 2 2 N" `shouldBe` Left "4 items in '1 2 2 N' in parsing the landing position, there should be 3 items"
      parsePosition upperRight "0 0 E" `shouldBe` Right (Position (Coordinate 0 0) E)
      parsePosition upperRight "5 5 E" `shouldBe` Right (Position (Coordinate 5 5) E)
      parsePosition upperRight "5 6 E" `shouldBe` Left "(5, 6) not within (0, 0) to (5, 5)"
    where upperRight = Coordinate 5 5
