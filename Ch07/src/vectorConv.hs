import qualified Data.Vector as V
import qualified Data.Vector.Mutable as VM

main :: IO ()
main = do
  as <- V.thaw animals
  VM.write as 3 "Wolf"
  print =<< V.freeze as

animals :: V.Vector String
animals = V.fromList ["Dog", "Pig", "Cat", "Fox", "Mouse", "Cow", "Horse"]