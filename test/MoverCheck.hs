module MoverCheck where

import Test.QuickCheck
import Test.Hspec
import Arbitraries
import Types

moverCheck :: Spec
moverCheck =
  describe "Mover check" $ do
    it "coordinate is always within the plateau boundary" $
      forAll genCommand (`elem` [L, R, M])
