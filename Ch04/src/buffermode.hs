import System.IO

main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  x <- getChar
  print x
  x <- getChar
  print x
  x <- getChar
  print x
  xs <- getLine
  putStrLn xs