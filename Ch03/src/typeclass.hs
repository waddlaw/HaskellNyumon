import Data.List (intercalate)

data Dog = Dog deriving Show
data Cat = Cat deriving Show
data Human = Human String deriving Show

class Greeting a where
  name :: a -> String
  hello :: a -> String
  hello _ = "..."
  bye :: a -> String
  bye _ = "..."

instance Greeting Human where
  name (Human n) = n
  hello h = "Hi, I'm " ++ name h ++ "."
  bye _ = "See you."

instance Greeting Dog where
  name _ = "a dog"
  hello _ = "Bark!"

instance Greeting Cat where
  name _ = "a cat"
  bye _ = "Meow..."

sayHello :: Greeting a => a -> IO ()
sayHello x = putStrLn (hello x)

class Greeting a => Laughing a where
  laugh :: a -> String

instance Laughing Human where
  laugh _ = "Zehahahah...!!"

leaveWithLaugh :: Laughing a => a -> IO ()
leaveWithLaugh x = do
  putStrLn (bye x)
  putStrLn (laugh x)

liftGreet :: (a -> String) -> ([a] -> String)
liftGreet f = intercalate "\n" . map f

instance Greeting a => Greeting [a] where
  name = liftGreet name
  hello = liftGreet hello
  bye = liftGreet bye

class Breeding a where
  breed :: String -> a

instance Breeding Human where
  breed = Human