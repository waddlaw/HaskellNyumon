{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T
import Data.Attoparsec.Text hiding (take)
import Control.Applicative

main :: IO ()
main = do
  print $ parse decimal "1000" `feed` ""
  print $ parseOnly decimal "1000"

twoOfDecimal :: Parser (Int, Int)
twoOfDecimal = do
  left <- decimal
  char ','
  right <- decimal
  return (left, right)

parens :: Parser a -> Parser a
parens parser = do
  char '('
  res <- parser
  char ')'
  return res

data Animal = Dog | Pig deriving Show

animal :: Parser Animal
animal = (string "Dog" >> return Dog) <|> (string "Pig" >> return Pig)

main2 :: IO ()
main2 = do
  print $ parse animal "Dog" `feed` ""
  print $ parse animal "Pig" `feed` ""
  print $ parse animal "Cat" `feed` ""