module Main where

import Control.Concurrent

main = do
  putStrLn "Begin"
  account1 <- newMVar 10000
  account2 <- newMVar 10000

  forkIO $ do
    balance1 <- takeMVar account1
    threadDelay 1000000
    balance2 <- takeMVar account2
    putMVar account1 (balance1 + 1000)
    putMVar account2 (balance2 - 1000)

  forkIO $ do
    balance2 <- takeMVar account2
    threadDelay 1000000
    balance1 <- takeMVar account1
    putMVar account2 (balance2 + 1000)
    putMVar account1 (balance1 - 1000)

  threadDelay 2000000
  balance1 <- takeMVar account1
  balance2 <- takeMVar account2
  print (balance1, balance2)
  putStrLn "Done"