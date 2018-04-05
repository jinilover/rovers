import Test.Hspec
import MoverSpec
import MoverCheck

main :: IO ()
main = hspec $ foldl (>>) (return ()) specs

specs :: [Spec]
specs = [execCmdSpec, moverCheck]
