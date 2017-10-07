import Control.Concurrent
import Control.Exception

main :: IO ()
main = do
  m <- newEmptyMVar

  forkIO $ do
    tid <- myThreadId
    putStrLn $ show tid ++ ": doing ... heavy ... task ..."
    threadDelay 2000000
    putMVar m ()

  takeMVar m
  putStrLn "Done"

actionIO :: IO a -> IO a
actionIO action = do
  mv <- newEmptyMVar :: IO (MVar (Either SomeException a))
  _tid <- forkIO $ do
    result <- try action
    putMVar mv result
  result <- takeMVar mv
  case result of
    Left e -> throwIO e
    Right r -> return r