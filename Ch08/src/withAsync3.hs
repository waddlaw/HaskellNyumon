import Control.Concurrent.Async
import Control.Concurrent
import Control.Monad

main :: IO ()
main = do
  putStrLn "Using race_"
  race_ thread1 thread2
  where
    thread1 = do
      threadDelay 2000000
      putStrLn "Thread1: end"
    thread2 = forever $ do
      putStrLn "Thread2: Can you hear me?"
      threadDelay 500000