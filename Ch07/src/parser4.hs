{-# LANGUAGE OverloadedStrings #-}
import Data.Attoparsec.Text hiding (take)
import Control.Applicative

data Term = Add Expr deriving Show
data Expr = ExTerm Double Term | ExEnd Double deriving Show

termParser :: Parser Term
termParser = addParser
  where
    addParser :: Parser Term
    addParser = Add <$ char '+' <*> exprParser

exprParser :: Parser Expr
exprParser = ExTerm <$> double <*> termParser <|> ExEnd <$> double

main :: IO ()
main = do
  print $ parse (exprParser <* endOfInput) "1+2+3" `feed` ""