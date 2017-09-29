module Main where

intToArray :: Int -> Int -> [Int]
intToArray i l = take l (repeat i)

main :: IO ()
main = do
  print (intToArray 3 4)

  print (intToArray 5000 12.04)

  print (intToArray 'a' 10)