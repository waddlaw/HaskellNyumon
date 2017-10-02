safeDiv :: Integer -> Integer -> Either String Integer
safeDiv k n | n == 0 = Left $ "Illegal division by zero. k:" ++ show k
            | otherwise = Right (k `div` n)

calc :: Integer -> Either String Integer
calc n = do
  x <- 100 `safeDiv` n
  y <- 100 `safeDiv` (x-1)
  return y