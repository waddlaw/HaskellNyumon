data Loop act = End | Step act (Loop act)
  deriving Show

data FizzBuzzAction
  = PrintFizz
  | PrintBuzz
  | PrintFizzBuzz
  | PrintNumber Int
  deriving Show

type FizzBuzz = Loop FizzBuzzAction

evalLoop :: Loop act -> (act -> IO ()) -> IO ()
evalLoop End _ = return ()
evalLoop (Step action rest) fn = fn action >> evalLoop rest fn

evalFizzBuzzAction :: FizzBuzzAction -> IO ()
evalFizzBuzzAction PrintFizz = putStrLn "fizz"
evalFizzBuzzAction PrintBuzz = putStrLn "buzz"
evalFizzBuzzAction PrintFizzBuzz = putStrLn "fizzbuzz"
evalFizzBuzzAction (PrintNumber n) = print n

evalFizzBuzz :: FizzBuzz -> IO ()
evalFizzBuzz fb = evalLoop fb evalFizzBuzzAction

main :: IO ()
main = do
  let lst = genFizzBuzz
  evalFizzBuzz lst

genFizzBuzz :: FizzBuzz
genFizzBuzz = toFB [1..100000000]
  where
    toFB [] = End
    toFB (n:ns) = if n `mod` 15 == 0 then Step PrintFizzBuzz (toFB ns)
      else if n `mod` 3 == 0 then Step PrintFizz (toFB ns)
      else if n `mod` 5 == 0 then Step PrintBuzz (toFB ns)
      else Step (PrintNumber n) (toFB ns)