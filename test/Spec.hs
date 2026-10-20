import Prelude hiding ((<>))
import Test.QuickCheck
import Prettify

instance Arbitrary Doc where
    arbitrary = do
        n <- choose (1,6) :: Gen Int
        case n of
             1 -> return Empty

             2 -> do x <- arbitrary
                     return (Char x)

             3 -> do x <- arbitrary
                     return (Text x)

             4 -> return Line

             5 -> do x <- arbitrary
                     y <- arbitrary
                     return (Concat x y)

             6 -> do x <- arbitrary
                     y <- arbitrary
                     return (Union x y)

prop_empty_id x =
    empty <> x == x
    &&
    x <> empty == x

main :: IO ()
main = do
    docs <- generate arbitrary :: IO [Doc]
    print docs