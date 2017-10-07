{-# LANGUAGE LambdaCase #-}

module Main where

import Control.Concurrent

main :: IO ()
main = do
  putStrLn "BEGIN"
  mv <- newEmptyMVar

  tid <- forkFinally

    (do
      tid <- myThreadId
      print tid
      threadDelay 2000000
      putStrLn "Hey!")

    (\case
      Right _ -> do
        putStrLn "Finished the task"
        putMVar mv ()
      Left e -> do
        putStrLn $ "Killed by Exception: " ++ show e
        putMVar mv ())

  threadDelay 1000000
  killThread tid
  takeMVar mv
  putStrLn "END"