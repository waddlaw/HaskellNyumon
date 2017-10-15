{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GADTs #-}
module Auction.Server (jsonServer, Port(..), auctionService, facilitator) where

import Prelude hiding (id)
import Control.Monad (void)
import Control.Concurrent
import Control.Concurrent.STM
import Control.Exception.Safe
import Control.Monad.IO.Class (liftIO)
import Control.Lens ((^.), (.~), (&))
import qualified Data.Text as T
import Data.Aeson
import Data.Time.Clock
import qualified Data.HashMap.Strict as M
import Web.Scotty as Scotty (scotty, post, body, json, status)
import Network.HTTP.Types.Status (badRequest400)
import Auction.Types
import Data.UUID.V4 as UUID.V4

evalAuction :: AuctionState -> Auction a -> IO a
evalAuction state (RegisterUser newUser) = do
  user <- buildUser newUser
  registerUser state user
  return $ user ^. id
evalAuction state (RegisterItem uid ni) = do
  tUser <- getLoginUser state uid
  item <- buildItem ni
  atomically $ addItemToUser tUser item
evalAuction state ViewAuctionItem = do
  mtAuctionItem <- atomically $ tryReadTMVar (currentAuctionItem state)
  case mtAuctionItem of
    Just tAuctionItem -> do
      auctionItem <- toAuctionItem tAuctionItem
      return $ Just auctionItem
    Nothing -> return Nothing
evalAuction state (CheckUser uid) = getLoginUser state uid >>= readTVarIO
evalAuction state (SellToAuction uid item term price) = do
  tUser <- getLoginUser state uid
  currentTime <- getCurrentTime
  if startTime term < endTime term && currentTime < endTime term
    then if price < 0
      then throwIO InvalidFirstPrice
      else do
        _ <- putItemToAuction state tUser item term price
        return ()
    else throwIO InvalidTerm
evalAuction state (Bid uid bidPrice) = do
  tUser <- getLoginUser state uid
  currentTime <- getCurrentTime
  atomically $ do
    user <- readTVar tUser
    if user ^. money < bidPrice
      then throwIO NoEnoughMoney
      else do
        mAuctionItem <- tryTakeTMVar $ currentAuctionItem state
        case mAuctionItem of
          Nothing -> throwIO NoAuctionItem
          Just auctionItem ->
            if checkInTerm currentTime (auctionItem ^. auctionTerm)
              then if bidPrice <= (auctionItem ^. currentPrice)
                then throwIO LowPrice
                else do
                  let auctionItem' = auctionItem
                        & currentPrice .~ bidPrice
                        & currentUser .~ Just tUser
                  putTMVar (currentAuctionItem state) auctionItem'
              else throwIO OutOfTerm

addItemToUser :: TVar User -> Item -> STM ItemId
addItemToUser tUser item = do
  updateUser tUser
    (\user -> user & inventory .~ addItem (user ^. inventory) item)
  return $ item ^. id

updateUser :: TVar User -> (User -> User) -> STM ()
updateUser tUser change = do
    oldUser <- readTVar tUser
    let changedUser = change oldUser
    if changedUser ^. id == oldUser ^. id
        then writeTVar tUser changedUser
        else throwIO InvalidUserUpdate

putItemToAuction :: AuctionState -> TVar User -> Item -> Term -> Price -> IO AuctionItem'
putItemToAuction state tUser item term price = do
  aiid <- newAuctionItemId
  atomically $ do
    user <- readTVar tUser
    let Inventory inventoryItems = user ^. inventory
    if item ^. id `elem` fmap (^. id) inventoryItems
      then do
        let inventoryItems' = filter (\item' -> item' ^. id /= item ^. id) inventoryItems
        let user' = user & inventory .~ Inventory inventoryItems'
        writeTVar tUser user'
        mAuctionItem <- tryTakeTMVar $ currentAuctionItem state
        case mAuctionItem of
          Just _ -> throwIO AuctionItemAlreadyExist
          Nothing -> do
            let tAuctionItem = AuctionItem' aiid tUser price Nothing term item
            putTMVar (currentAuctionItem state) tAuctionItem
            return tAuctionItem
      else throwIO ItemNotFound


getUser :: AuctionState -> UserId -> STM (Maybe (TVar User))
getUser state uid = do
    userMap <- readTVar $ registeredUsers state
    return $! M.lookup uid userMap

getLoginUser :: AuctionState -> UserId -> IO (TVar User)
getLoginUser state uid = do
    atomically (getUser state uid) >>= \case
        Just tUser -> return tUser
        Nothing -> throwIO UserNotFound

buildItem :: NewItem -> IO Item
buildItem item = do
    uuid <- UUID.V4.nextRandom
    return $ Item (ItemId uuid) (item ^. name) (item ^. description)