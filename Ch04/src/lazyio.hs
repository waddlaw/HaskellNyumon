import Data.Char

-- main :: IO ()
-- main = do
--   xs <- getContents
--   putStr $ map toUpper xs

main :: IO ()
main = do
  xs <- getContents >>= return  . lines
  counter 0 xs

counter :: Int -> [String] -> IO ()
counter _ [] = return ()
counter i ("up":xs) = print (i + 1) >> counter (i + 1) xs
counter i ("down":xs) = print (i - 1) >> counter (i - 1) xs
counter i (_:xs) = counter i xs

main2 :: IO ()
main2 = interact $ map toUpper

main3 :: IO ()
main3 = readFile "sample.txt" >>= putStrLn

main4 :: IO ()
main4 = readFile "sample.txt" >>= putStrLn . reverse

main5 :: IO ()
main5 = do
  val <- readFile "sample.txt"
  putStrLn $ take 5 val
  writeFile "sample.txt" "Hello, Lazy IO!"