{-# LANGUAGE OverloadedStrings #-}
import Data.Aeson
import Data.Aeson.Types

data Person = Person
  { name :: String
  , age :: Int
  } deriving Show

instance ToJSON Person where
  toJSON (Person n a) =
    object ["name" .= n, "age" .= a]

instance FromJSON Person where
  parseJSON (Object v) = Person
    <$> v .: "name"
    <*> v .: "age"
  parseJSON i = typeMismatch "Person" i