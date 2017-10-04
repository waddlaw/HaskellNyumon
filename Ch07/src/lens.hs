{-#  LANGUAGE TemplateHaskell #-}
import Control.Lens
import Control.Monad.State

data User = User
  { _userName :: String
  , _userAge :: Int
  , userPassword :: String
  } deriving Show

makeLenses ''User

main :: IO ()
main = do
  let user = User
           { _userName = "Tarro"
           , _userAge = 25
           , userPassword = "12345"
           }
  print (user^.userName)
  print (user^.userAge)
  print (user&userName.~"Jiro")

userPass :: Lens User User String String
userPass = lens userPassword (\user password -> user { userPassword = password } )

main2 :: IO ()
main2 = do
  let user = User
           { _userName = "Taro"
           , _userAge = 25
           , userPassword = "12345"
           }
  print (user^.userPass)
  print (user&userPass.~"new-password")

main3 :: IO ()
main3 = do
  let user = User
           { _userName = "Taro"
           , _userAge = 25
           , userPassword = "12345"
           }
  print $ runState lensWithState user

lensWithState :: State User Int
lensWithState = do
  age <- use userAge
  userName .= "Jiro"
  return age