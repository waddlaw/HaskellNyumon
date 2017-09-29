type Age = Integer

legalDrink :: Age -> Bool
legalDrink age | age >= 20 = True
               | otherwise = False
  
data AppErr = NewAppErr deriving Show
type AppResult a = Either AppErr a

safeHead :: [a] -> AppResult a
safeHead [] = Left NewAppErr
safeHead xs = Right (head xs)

newtype NTIndexed a = NewNTIndexed { unNTIndexed :: (Integer, a) } deriving Show