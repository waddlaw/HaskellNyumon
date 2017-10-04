{-# LANGUAGE GADTs #-}

import Data.List
import Control.Monad
import Control.Monad.Identity
import Control.Monad.Operational

type Price = Int
type Amount = Int
type Product = String
type Report = [(Product, Amount)]
type ProductList = [(Product, Price)]

data SalesBase a where
  GetProducts :: SalesBase ProductList
  GetReport :: SalesBase Report
  Sell :: (Product, Amount) -> SalesBase ()

type SalesT m a = ProgramT SalesBase m a
type Sales a = Program SalesBase a

getProducts :: SalesT m ProductList
getProducts = singleton GetProducts

getReport :: SalesT m Report
getReport = singleton GetReport

sell :: (Product, Amount) -> SalesT m ()
sell p = singleton $ Sell p

sellFruits :: Sales ()
sellFruits = do
  sell ("Apple", 5)
  sell ("Grape", 8)
  sell ("Pineapple", 2)

runSalesT :: Monad m => ProductList -> Report -> SalesT m a -> m a
runSalesT p r = viewT >=> eval
  where
    eval :: Monad m => ProgramViewT SalesBase m a -> m a
    eval (Return x) = return x
    eval (GetProducts :>>= k) = runSalesT p r (k p)
    eval (GetReport :>>= k) = runSalesT p r (k r)
    eval (Sell s :>>= k) = runSalesT p (s:r) (k ())

runSales :: ProductList -> Report -> Sales a -> a
runSales p r = runIdentity . runSalesT p r

findAmount :: Product -> ProductList -> Maybe Price
findAmount p = fmap snd . find ((p==).fst)

summary :: Sales [(Product, Amount, Maybe Price)]
summary = let
  sumRecord :: ProductList -> (Product, Amount) -> (Product, Amount, Maybe Price)
  sumRecord px (p, n) = (p, n, fmap (*n) $ findAmount p px)
  in do
    list <- getProducts
    report <- getReport
    return $ map (sumRecord list) report

productList :: ProductList
productList =
  [ ("Apple", 98)
  , ("Grape", 398)
  , ("Pineapple", 498)
  ]

main :: IO ()
main = do
  print (runSales productList [] (sellFruits >> summary))