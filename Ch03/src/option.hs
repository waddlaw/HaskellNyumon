data CmdOption = COptInt Integer
               | COptBool Bool
               | COptStr String
               deriving (Show)

coptToInt :: CmdOption -> Int
coptToInt (COptInt n) = fromIntegral n
coptToInt (COptStr x) = read x
coptToInt (COptBool True) = 1
coptToInt (COptBool False) = 0

data LazyAndStrict = LazyAndStrict
                   { lsLazy :: Int
                   , lsStrict :: !Int
                   }