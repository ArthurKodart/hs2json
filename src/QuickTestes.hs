module QuickTestes where

import Test.QuickCheck
import Data.List (sort, (\\))

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

prop_ordered :: [Int] -> Bool
prop_ordered xs = ordered (qsort xs)
    where
        ordered []       = True
        ordered [x]      = True
        ordered (x:y:ys) = x <= y && ordered (y:ys)

prop_permutation :: [Int] -> Bool
prop_permutation xs = permutation xs (qsort xs)
    where
        permutation as bs =
            null (as \\ bs) && null (bs \\ as)

prop_maximum :: [Int] -> Property
prop_maximum xs =
    not (null xs) ==>
        last (qsort xs) == maximum xs

prop_append :: [Int] -> [Int] -> Property
prop_append xs ys =
    not (null xs) ==>
    not (null ys) ==>
        head (qsort (xs ++ ys)) == min (minimum xs) (minimum ys)

main :: IO ()
main = do
    putStrLn "Testando idempotencia..."
    quickCheck prop_idempotent
    putStrLn "Testando elemento minimo (com condicao ==>)..."
    quickCheck prop_minimum'
    putStrLn "Testando equivalencia com Data.List.sort..."
    quickCheck prop_sort_model
    putStrLn "Testando se a lista está ordenada..."
    quickCheck prop_ordered
    putStrLn "Testando se a ordenação preserva os elementos..."
    quickCheck prop_permutation
    putStrLn "Testando o elemento máximo..."
    quickCheck prop_maximum
    putStrLn "Testando o mínimo após concatenação..."
    quickCheck prop_append