import Test.Hspec
import MoverSpec
import MoverCheck
import ParserSpec

main :: IO ()
main = hspec $ foldl (>>) (return ()) specs

specs :: [Spec]
specs = [moverSpec, moverCheck, parserSpec]
