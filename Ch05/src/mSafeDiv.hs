safeDiv :: Integer -> Integer -> Maybe Integer
safeDiv k n | n == 0 = Nothing
            | otherwise = Just (k `div` n)

calc :: Integer -> Maybe Integer
calc n = do
  x <- 100 `safeDiv` n
  y <- 100 `safeDiv` (x-1)
  return y