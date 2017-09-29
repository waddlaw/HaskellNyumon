module Main (main) where

hf :: Int -> Int
hf x = 1

main :: IO ()
main = print (hf (0 `div` 0))