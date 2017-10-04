import qualified Data.Vector.Mutable as VM

main :: IO ()
main = do
  animals <- VM.new 2
  VM.write animals 0 "Dog"
  VM.write animals 1 "Cat"

  putStrLn $ VM.read animals 1