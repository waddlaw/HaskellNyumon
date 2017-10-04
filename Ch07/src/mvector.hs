import Control.Monad
import qualified Data.Vector.Mutable as VM

main :: IO ()
main = do
  animals <- VM.new 5
  VM.write animals 0 "Dog"
  VM.write animals 1 "Pig"
  VM.write animals 2 "Cat"
  VM.write animals 3 "Fox"
  VM.write animals 4 "Mouse"

  tmp <- VM.read animals 1
  VM.write animals 1 =<< VM.read animals 3
  VM.write animals 3 tmp

  forM_ [0 .. (VM.length animals - 1)] $ \i -> do
    putStrLn =<< VM.read animals i