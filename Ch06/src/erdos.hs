module MyModule where

data Paper = Paper
  { paperId :: String
  , title :: String
  , author :: String
  , erdosNumber :: Int
  }
  deriving Show

instance Eq Paper where
  p1 == p2 = paperId p1 == paperId p2

instance Ord Paper where
  p1 <= p2 = erdosNumber p1 <= erdosNumber p2