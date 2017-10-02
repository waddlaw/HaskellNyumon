{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module FundepExample where

class C a b | a -> b
instance C Int Bool
instance C Int Double
instance C Char ()