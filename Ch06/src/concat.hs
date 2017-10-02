module Main where

import Control.Exception (bracket, finally)
import Control.Monad (forM_)
import System.IO
  ( stdout, Handle, FilePath, IOMode(..)
  , openFile, hClose, hIsEOF, hGetLine, hPutStrLn
  )
import System.Environment (getArgs)
import Data.Char (toUpper)

main :: IO ()
main = do
  filePaths <- getArgs
  handleMultiFiles filePaths $ \hdl -> do
    foreachLine hdl $ \line -> do
      hPutStrLn stdout line

concatMultiFiles :: [FilePath] -> Handle -> IO ()
concatMultiFiles filePaths dst =
  handleMultiFiles filePaths (\hdl -> copyFile hdl dst)

handleMultiFiles :: [FilePath] -> (Handle -> IO ()) -> IO ()
handleMultiFiles filePaths fileHandler =
  forM_ filePaths $ \filePath ->
    bracket
      (openFile filePath ReadMode)
      (\hdl -> hClose hdl)
      (\hdl -> fileHandler hdl)

copyFile :: Handle -> Handle -> IO ()
copyFile src dst = copyFileWithConvert src dst id

copyFileWithConvert :: Handle -> Handle -> (String -> String) -> IO ()
copyFileWithConvert src dst convert = loop
  where
    loop = do
      isEof <- hIsEOF src
      if isEof
        then return ()
        else do
          line <- hGetLine src
          hPutStrLn dst (convert line)
          loop

foreachLineAndAppend :: Handle -> Handle -> (String -> IO String) -> IO ()
foreachLineAndAppend src dst ioAction =
  foreachLine src $ \line -> do
    output <- ioAction line
    hPutStrLn dst output

foreachLine :: Handle -> (String -> IO ()) -> IO ()
foreachLine src ioAction = loop
  where
    loop = do
      isEof <- hIsEOF src
      if isEof
        then return ()
        else do
          line <- hGetLine src
          ioAction line
          loop

main2 :: IO ()
main2 = do
  filePaths <- getArgs
  handleMultiFiles filePaths $ \hdl -> do
    hClose hdl
    hPutStrLn hdl "Hey!"

main3 :: IO ()
main3 = do
  filePaths <- getArgs
  foreachFileLine filePaths $ \line ->
    hPutStrLn stdout line

foreachFileLine :: [FilePath] -> (String -> IO ()) -> IO ()
foreachFileLine filePaths lineHandler =
  handleMultiFiles filePaths $ \hdl ->
    foreachLine hdl lineHandler