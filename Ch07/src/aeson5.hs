{-# LANGUAGE DeriveGeneric #-}
import GHC.Generics
import Data.Aeson

data Person = Person
  { name :: String
  , age :: Int
  } deriving (Show, Generic)

instance ToJSON Person
instance FromJSON Person