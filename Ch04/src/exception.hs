{-# LANGUAGE ScopedTypeVariables #-}
import Control.Exception

main :: IO ()
main =
  (readFile "dummyFileName" >>= putStrLn)
    `catch`
  (\(e :: ArithExceptions) ->
    putStrLn $ "Catch ArithException: " ++ displayException e)
  (\(e :: SomeException) ->
    putStrLn $ "Catch SomeExceptions: " ++ displayException e)
    `finally`
  (putStrLn "finalization!!!")

main2 :: IO ()
main2 =
  (readFile "dummyFileName" >>= putStrLn)
    `catch`
  (\(e :: ArithExceptions) ->
    putStrLn $ "Catch ArithException: " ++ displayException e)
  (\(e :: SomeException) ->
    putStrLn $ "Catch SomeExceptions: " ++ displayException e)
    `finally`
  (putStrLn "finalization!!!")