import Control.Monad

main :: IO ()
main = do
  forM_ [1..9] $ \x -> do
    forM_ [1..9] $ \y -> do
      putStr $ show (x*y) ++ "\t"
    putStrLn ""