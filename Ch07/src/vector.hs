import qualified Data.Vector as V

main :: IO ()
main = do
  let animals = V.fromList ["Dog", "Pig", "Cat", "Fox", "Mouse", "Cow", "Horse"]
  print . V.sum . V.map length $ animals