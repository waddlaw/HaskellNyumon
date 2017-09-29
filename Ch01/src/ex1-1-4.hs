main = do
  let path = "readme.txt"
  body <- readFile path
  putStrLn body