import Control.Concurrent.Async
import Control.Concurrent
import Control.Monad

main :: IO ()
main = do
  putStrLn "Using async"
  _ <- async $ do
    _ <- async $ forever $ do
      putStrLn "Thread2: Can you hear me?"
      threadDelay 500000
    threadDelay 1000000
    putStrLn "Thread1: end"

  threadDelay 3000000