{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fno-omit-yields #-}

module Main where

import Control.Concurrent
import Control.Exception

main :: IO ()
main = do
  m <- newEmptyMVar

  tid <- forkFinally
    (mask $ \unmask -> do
      let showResult v = putStrLn $ "Result: " ++ show v
      putStrLn "Child thread..."
      evaluate (fib 40) >>= showResult
      evaluate (fib 39) >>= showResult
      unmask (evaluate $ fib 38) >>= showResult
      putStrLn "Hey!")
    (\case
      Right _ -> putStrLn "Finished the task" >> putMVar m ()
      Left e -> putStrLn ("Killed by Exception: " ++ show e) >> putMVar m ())

  threadDelay 1000
  killThread tid
  takeMVar m

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)