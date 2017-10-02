import Control.Monad (unless)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.State (evalStateT, get, modify)
import Control.Monad.Trans.Except (runExceptT, throwE)

main :: IO ()
main = do
  result <- (`evalStateT` 0) $ runExceptT $ loop
  case result of
    Right _ -> return ()
    Left e -> putStrLn e

  where
    loop = do
      i <- st $ get
      unless (i < (3::Int)) $ throwE "Too much failure"

      op <- io $ getLine
      if op == "end" then
        return ()
      else do
        st $ modify (+ 1)
        loop

    io = lift . lift
    st = lift