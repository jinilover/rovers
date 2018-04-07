module MoverSpec
    ( moverSpec ) where

import Test.Hspec
import Types
import Mover
import Control.Monad

moverSpec :: Spec
moverSpec =
  describe "Mover spec" $ do
    it "execute correctly commands of changing direction only" $
      let upperRight = Coordinate 5 5
          initPos = Position (Coordinate 1 3) E
          cmds = [L, L, L, R]
          expectPoses = [
            initPos {heading = N},
            initPos {heading = W},
            initPos {heading = S},
            initPos {heading = W} ] in
          check upperRight initPos cmds expectPoses
    it "execute correctly commands of minimum reqt. 1" $
      let upperRight = Coordinate 5 5
          initPos = Position (Coordinate 1 2) N
          cmds = [L, M, L, M, L, M, L, M, M]
          expectPoses = [
            Position (Coordinate 1 2) W,
            Position (Coordinate 0 2) W,
            Position (Coordinate 0 2) S,
            Position (Coordinate 0 1) S,
            Position (Coordinate 0 1) E,
            Position (Coordinate 1 1) E,
            Position (Coordinate 1 1) N,
            Position (Coordinate 1 2) N,
            Position (Coordinate 1 3) N ] in
        check upperRight initPos cmds expectPoses
    it "execute correctly commands of minimum reqt. 2" $
      let upperRight = Coordinate 5 5
          initPos = Position (Coordinate 3 3) E
          cmds = [M, M, R, M, M, R, M, R, R, M]
          expectPoses = [
            Position (Coordinate 4 3) E,
            Position (Coordinate 5 3) E,
            Position (Coordinate 5 3) S,
            Position (Coordinate 5 2) S,
            Position (Coordinate 5 1) S,
            Position (Coordinate 5 1) W,
            Position (Coordinate 4 1) W,
            Position (Coordinate 4 1) N,
            Position (Coordinate 4 1) E,
            Position (Coordinate 5 1) E ] in
        check upperRight initPos cmds expectPoses

check :: Coordinate -> Position -> [Command] -> [Position] -> Expectation
check upperRight origPos cmds expectPoses = do
  expectOutput <- foldl checkStep (return origPos) (zip cmds expectPoses)
  execCmds upperRight origPos cmds `shouldBe` expectOutput
  return ()
    where checkStep assertion (cmd, expectPos) = do
            currPos <- assertion
            let newPos = execCmd upperRight currPos cmd
            newPos `shouldBe` expectPos
            return newPos
