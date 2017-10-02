data Gender = Man | Woman deriving Show
data Human = Human
  { name :: String
  , age :: Int
  , gender :: Gender
  } deriving Show