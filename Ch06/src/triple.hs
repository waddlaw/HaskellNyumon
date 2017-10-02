{-# LANGUAGE FlexibleInstances    #-}

class Triple a where
  triple :: a -> a

instance Triple Int where
  triple n = n * 3

instance Triple String where
  triple s = s ++ s ++ s