import System.Directory

main :: IO ()
main = do
  current <- getCurrentDirectory
  findFiles [current ++ "/.." , current] "target.txt" >>= print
  findFile [current ++ "/.." , current] "target.txt" >>= print

main2 :: IO ()
main2 = do
  current <- getCurrentDirectory
  let checkWritable filePath = getPermissions filePath >>= return . writable
  findFilesWith
    checkWritable [current ++ "/..", current] "target.txt" >>= print