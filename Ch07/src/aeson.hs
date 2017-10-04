{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists   #-}

import Data.Aeson
import Data.Aeson.TH
import qualified Data.ByteString.Lazy.Char8 as B

data Human = Human
  { name :: String
  , age :: Int
  } deriving Show

deriveJSON defaultOptions ''Human

taro :: Human
taro = Human
  { name = "Taro"
  , age = 30
  }

hanako :: B.ByteString
hanako = "{\"name\":\"Hanako\",\"age\":25}"

jiro :: B.ByteString
jiro = "{\"onamae\":\"Jiro\",\"nenrei\":30}"

main :: IO ()
main = do
  B.putStrLn . encode $ taro
  print (decode hanako :: Maybe Human)
  print (decode jiro :: Maybe Human)

main2 :: IO ()
main2 = do
  print (eitherDecode hanako :: Either String Human)
  print (eitherDecode jiro :: Either String Human)

main3 :: IO ()
main3 = do
  B.putStrLn $ encode (["Taro", "Jiro", "Hanako"] :: [String])
  B.putStrLn $ encode ([10,20,30] :: [Int])
  B.putStrLn $ encode (("Hello", 100) :: (String, Int))
  print (decode "[\"Taro\", \"Jiro\", \"Hanako\"]" :: Maybe [String])
  print (decode "[10, 20, 30]" :: Maybe [Int])
  print (decode "[777 , \"Haskell\"]" :: Maybe (Int, String))

data Department = Department
  { departmentName :: String
  , coworkers :: [Human]
  } deriving Show

deriveJSON defaultOptions ''Department

-- taro :: Human
-- taro = Human { name = "Taro" , age = 30 }

saburo :: Human
saburo = Human { name = "Saburo" , age = 31 }

shiro :: Human
shiro = Human { name = "Shiro" , age = 31 }

matsuko :: Human
matsuko = Human { name = "Matsuko" , age = 26}

nameList :: [Department]
nameList =
  [ Department
    { departmentName = "General Affairs"
    , coworkers =
      [ taro
      , matsuko
      ]
    }
  , Department
    { departmentName = "Development"
    , coworkers =
      [ saburo
      , shiro
      ]
    }
  ]

data IntStr = IntData Int | StrData String deriving Show

deriveJSON defaultOptions ''IntStr

main4 :: IO ()
main4 = do
  B.putStrLn $ encode $ IntData 999
  B.putStrLn $ encode $ StrData "World!"