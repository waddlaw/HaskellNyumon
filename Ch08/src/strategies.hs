import Control.Parallel.Strategies

main :: IO ()
main = do
  let list = take 5000 (cycle [20..30])
  print $ sum (map fib list `using` parListChunk 30 rseq)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)