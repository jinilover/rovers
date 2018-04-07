module MoverCheck
     ( moverCheck ) where

import Test.QuickCheck
import Test.Hspec
import Arbitraries
import Types
import Utility
import Mover

moverCheck :: Spec
moverCheck =
  describe "Mover check" $ do
    it "coordinate is always within the plateau" $
      forAll genUpperRight $ \upperRight ->
      forAll (genList :: Gen [Command]) $ \cmds ->
      forAll (genPosition upperRight) $ \pos ->
        let finalPos = execCmds upperRight pos cmds in
        withinPlateau (c finalPos) upperRight
    it "position is always calulated correctly after executing a command" $
      forAll genUpperRight $ \upperRight ->
      forAll genCommand $ \cmd ->
      forAll (genPosition upperRight) $ \pos ->
        let newPos = execCmd upperRight pos cmd in
            isCorrect upperRight pos cmd newPos
        where isCorrect (Coordinate maxX maxY) origPos@(Position _ origHeading) M newPos@(Position newCoord newHeading) = -- this condition means move 1 step forward
                newHeading == origHeading && case origPos of
                  Position (Coordinate x y) E -> if x == maxX then newPos == origPos else newCoord == Coordinate (x+1) y
                  Position (Coordinate x y) W -> if x == 0 then newPos == origPos else newCoord == Coordinate (x-1) y
                  Position (Coordinate x y) N -> if y == maxY then newPos == origPos else newCoord == Coordinate x (y+1)
                  Position (Coordinate x y) _ -> if y == 0 then newPos == origPos else newCoord == Coordinate x (y-1)
              isCorrect _ (Position origCoord origHeading) cmd (Position newCoord newHeading) = -- this condition means only turn L or R
                origCoord == newCoord && newHeading == (case (origHeading, cmd) of
                  (E, L) -> N
                  (E, R) -> S
                  (S, L) -> E
                  (S, R) -> W
                  (W, L) -> S
                  (W, R) -> N
                  (N, L) -> W
                  (N, R) -> E)
