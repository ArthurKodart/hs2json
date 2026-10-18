module Main (main) where

import SimpleJSON
import Prettify (compact, pretty)
import PrettyJSON (renderJValue)

demoValue :: JValue
demoValue = JObject
    [ ("name", JString "hs2json")
    , ("version", JString "0.1.0.0")
    , ("authors", JArray [JString "Arthur Kodart", JString "Pacelle Henrique"])
    , ("active", JBool True)
    , ("config", JObject
        [ ("max_width", JNumber 40)
        , ("indent", JNumber 2)
        , ("extra", JNull)
        ])
    ]

main :: IO ()
main = do
    putStrLn "=== Demonstracao da Biblioteca hs2json ==="
    putStrLn "\n--- Saida com compact ---"
    putStrLn (compact (renderJValue demoValue))
    putStrLn "\n--- Saida com pretty (largura 50) ---"
    putStrLn (pretty 50 (renderJValue demoValue))
    putStrLn "\n--- Saida com pretty (largura 25) ---"
    putStrLn (pretty 25 (renderJValue demoValue))
