{-# LANGUAGE TemplateHaskell #-}

import Prelude hiding ((<>))

import Test.QuickCheck
import Data.List (intersperse)
import Control.Monad (liftM, liftM2)
import System.Exit (exitFailure)

import SimpleJSON
import Prettify
import PrettyJSON

instance Arbitrary Doc where
    arbitrary =
        oneof [ return Empty
              , liftM  Char   arbitrary
              , liftM  Text   arbitrary
              , return Line
              , liftM2 Concat arbitrary arbitrary
              , liftM2 Union  arbitrary arbitrary ]

instance Arbitrary JValue where
    arbitrary = sized jvalueSized
      where
        jvalueSized 0 = oneof [ JString <$> arbitrary
                              , JNumber <$> arbitrary
                              , JBool   <$> arbitrary
                              , return JNull ]
        jvalueSized n =
            let n' = n `div` 2
                subValue = resize n' arbitrary
                listOfSub = resize n' (listOf subValue)
            in oneof [ JString <$> arbitrary
                     , JNumber <$> arbitrary
                     , JBool   <$> arbitrary
                     , return JNull
                     , JArray  <$> listOfSub
                     , JObject <$> resize n' (listOf ((,) <$> arbitrary <*> subValue))
                     ]

-- PROPRIEDADES DO Doc / Prettify

prop_empty_id :: Doc -> Bool
prop_empty_id x =
    empty <> x == x
  &&
    x <> empty == x

prop_char :: Char -> Bool
prop_char c = char c == Char c

prop_text :: String -> Bool
prop_text s = text s == if null s then Empty else Text s

prop_line :: Bool
prop_line = line == Line

prop_double :: Double -> Bool
prop_double d = double d == text (show d)

prop_hcat :: [Doc] -> Bool
prop_hcat xs = hcat xs == glue xs
    where
        glue []     = empty
        glue (d:ds) = d <> glue ds

prop_punctuate' :: Doc -> [Doc] -> Bool
prop_punctuate' s xs = punctuate s xs == combine (intersperse s xs)
    where
        combine []           = []
        combine [x]          = [x]
        combine (x:Empty:ys) = x : combine ys
        combine (Empty:y:ys) = y : combine ys
        combine (x:y:ys)     = x `Concat` y : combine ys

prop_compact_text :: String -> Bool
prop_compact_text s = compact (text s) == s

-- PROPRIEDADES DO JValue

prop_getString :: String -> Bool
prop_getString s = getString (JString s) == Just s

prop_getBool :: Bool -> Bool
prop_getBool b = getBool (JBool b) == Just b

prop_isNull :: JValue -> Bool
prop_isNull JNull = isNull JNull
prop_isNull v     = not (isNull v)

prop_getArray :: [JValue] -> Bool
prop_getArray arr = getArray (JArray arr) == Just arr

prop_string_enclosed :: String -> Bool
prop_string_enclosed s =
    let rendered = compact (renderJValue (JString s))
    in not (null rendered) && head rendered == '"' && last rendered == '"'

return []

runTests :: IO Bool
runTests = $quickCheckAll

main :: IO ()
main = do
    passed <- runTests
    if passed
        then putStrLn "Passou em todos os testes (Prettify e JValue)!"
        else do putStrLn "Alguns testes falharam."
                exitFailure