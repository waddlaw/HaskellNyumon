import Pipes
import qualified Pipes.Prelude as P

sample1 :: IO ()
sample1 = runEffect $ sampleProducer >-> P.map ("input : "++) >-> P.stdoutLn

sampleProducer :: Producer String IO ()
sampleProducer = do
  yield "Hoge"
  yield "Piyo"
  yield "Fuga"

sample2 :: IO ()
sample2 = runEffect $ range 1 20 >-> sampleConsumer

range :: Int -> Int -> Producer Int IO ()
range n m = mapM_ yield [n..m]

sampleConsumer :: Consumer Int IO ()
sampleConsumer = do
  x <- await
  lift . putStrLn $ fizzBuzz x
  sampleConsumer

fizzBuzz :: Int -> String
fizzBuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n