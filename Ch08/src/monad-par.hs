import Control.Monad.Par

main = do
  print $ parquicksort 4 [14,43,43,4,5,654,3,4]

quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (x:xs) = quicksort smaller ++ [x] ++ quicksort greater
  where
    smaller = filter (< x) xs
    greater = filter (>= x) xs

parquicksort :: Int -> [Int] -> [Int]
parquicksort maxdepth list = runPar $ generate 0 list
  where
    generate :: Int -> [Int] -> Par [Int]
    generate _ [] = return []
    generate d l@(x:xs)
      | d >= maxdepth = return $ quicksort l
      | otherwise = do
        iv1 <- spawn $ generate (d + 1) (filter (< x) xs)
        iv2 <- spawn $ generate (d + 1) (filter (>= x) xs)
        lt <- get iv1
        gte <- get iv2
        return $ lt ++ [x] ++ gte