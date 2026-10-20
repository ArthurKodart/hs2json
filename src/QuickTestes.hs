module QuickTestes where

import Test.QuickCheck
import Data.List (sort)

qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort lhs ++ [x] ++ qsort rhs
  where
    lhs = filter (< x) xs
    rhs = filter (>= x) xs

prop_idempotent :: [Int] -> Bool
prop_idempotent xs = qsort (qsort xs) == qsort xs

prop_minimum' :: [Int] -> Property
prop_minimum' xs = not (null xs) ==> head (qsort xs) == minimum xs

prop_sort_model :: [Int] -> Bool
prop_sort_model xs = qsort xs == sort xs

main :: IO ()
main = do
    putStrLn "Testando idempotencia..."
    quickCheck prop_idempotent
    putStrLn "Testando elemento minimo (com condicao ==>)..."
    quickCheck prop_minimum'
    putStrLn "Testando equivalencia com Data.List.sort..."
    quickCheck prop_sort_model
