{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE GADTs           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
module Auction.Types where

import Control.Concurrent.STM
import Data.UUID (UUID)
import Data.UUID.V4 as UUID.V4
import Data.Hashable (Hashable)
import Data.Time
-- import Data.Aeson
import Data.Aeson.TH
import Control.Lens
import qualified Data.HashMap.Strict as M
import Data.Typeable
import Control.Exception.Safe

newtype ItemId = ItemID UUID deriving (Show, Eq, Ord)
newtype UserId = UserId UUID deriving (Eq, Ord, Show, Hashable)
newtype Money = Money Int deriving (Show, Read, Eq, Ord, Num)
newtype AuctionItemId = AuctionItemId UUID deriving (Show, Eq, Ord)
data Term = Term { startTime :: UTCTime, endTime :: UTCTime } deriving Show
type Price = Money

data Item = Item
  { _itemId :: ItemId
  , _itemName :: String
  , _itemDescription :: String
  } deriving Show
makeFields ''Item

newtype Inventory = Inventory [Item] deriving Show

data User = User
  { _userId :: UserId
  , _userName :: String
  , _userInventory :: Inventory
  , _userMoney :: Money
  } deriving Show
makeFields ''User

data NewItem = NewItem
  { _newItemName :: String
  , _newItemDescription :: String
  } deriving Show
makeFields ''NewItem

data NewUser = NewUser
  { _newUserName :: String
  , _newUserMoney :: Money
  } deriving Show
makeFields ''NewUser

data AuctionItem' = AuctionItem'
  { _auctionItem'AuctionItemId :: AuctionItemId
  , _auctionItem'Seller :: TVar User
  , _auctionItem'CurrentPrice :: Price
  , _auctionItem'CurrentUser :: Maybe (TVar User)
  , _auctionItem'AuctionTerm :: Term
  , _auctionItem'AuctionTargetItem :: Item
  }
makeFields ''AuctionItem'

data AuctionItem = AuctionITem
  { _auctionItemAuctionItemId :: AuctionItemId
  , _auctionItemSellerId :: UserId
  , _auctionItemCurrentPrice :: Price
  , _auctionItemCurrentUserId :: Maybe UserId
  , _auctionItemAuctionTerm :: Term
  , _auctionItemAuctionTargetItem :: Item
  } deriving Show
makeFields ''AuctionItem

deriveJSON defaultOptions ''Money
deriveJSON defaultOptions ''AuctionItemId
deriveJSON defaultOptions ''AuctionItem
deriveJSON defaultOptions ''ItemId
deriveJSON defaultOptions ''NewItem
deriveJSON defaultOptions ''Item
deriveJSON defaultOptions ''Term
deriveJSON defaultOptions ''NewUser
deriveJSON defaultOptions ''User
deriveJSON defaultOptions ''Inventory
deriveJSON defaultOptions ''UserId
-- deriveJSON defaultOptions ''UUID

data AuctionState = AuctionState
  { registeredUsers :: TVar (M.HashMap UserId (TVar User))
  , currentAuctionItem :: TMVar AuctionItem'
  }

data Auction a where
  RegisterUser :: NewUser -> Auction UserId
  CheckUser :: UserId -> Auction User
  RegisterItem :: UserId -> NewItem -> Auction ItemId
  SellToAuction :: UserId -> Item -> Term -> Price -> Auction ()
  ViewAuctionItem :: Auction (Maybe AuctionItem)
  Bid :: UserId -> Price -> Auction ()

data AuctionException
  = NoAuctionItem | LowPrice | OutOfTerm | UserNotFound
  | InvalidTerm | InvalidFirstPrice | AuctionItemAlreadyExist
  | InvalidUserUpdate | ItemNotFound | NoEnoughMoney | BadData String
  | UnknownError | NetworkError | DecodeError
  deriving (Show, Typeable)

instance Exception AuctionException

newAuctionItemId :: IO AuctionItemId
newAuctionItemId = do
    uuid <- UUID.V4.nextRandom
    return $ AuctionItemId uuid

addItem :: Inventory -> Item -> Inventory
addItem (Inventory items) item = Inventory (item:items)

checkInTerm :: UTCTime -> Term -> Bool
checkInTerm time term = startTime term <= time && time < endTime term