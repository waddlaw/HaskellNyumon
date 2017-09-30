module Main where

import System.Environment (getArgs)
import System.Posix.Files
  ( fileExist
  , getFileStatus
  , fileSize
  )

main :: IO ()
main = do
  args <- getArgs
  case args of
    (x:_) -> showFileSize x
    _ -> putStrLn "Please input file name"

showFileSize :: String -> IO ()
showFileSize fn = do
  exist <- fileExist fn
  if exist
    then do
      st <- getFileStatus fn
      putStrLn $ "File size = " ++ (show $ fileSize st)
    else do
      putStrLn $ "file '" ++ fn ++ "' is not found"