{-# LANGUAGE OverloadedStrings #-}
module Web.View.Main (loadMainTemplate, mainView) where

import Control.Monad.IO.Class (liftIO)
import Data.Function (on)
import Data.List (groupBy, sortBy)
import qualified Data.Text as TXT
import qualified Data.Time.Format as TM
import qualified Data.Time.LocalTime as TM
import qualified Entity.User as User
import qualified Entity.WeightRecord as WRecord
import Model.WeightRecord (selectWRecord)
import Text.Mustache (Template, automaticCompile, object, substitute, (~>))
import Text.Mustache.Types (Value)
import Web.Core (WRAction, WRConfig (wrcTplRoots), WRState (wrstMainTemplate), runSqlite, wrconUser)
import Web.Spock (getContext, getState, html)

loadMainTemplate ::WRConfig -> IO Template
loadMainTemplate cfg = do
  compiled <- automaticCompile (wrcTplRoots cfg) "main.mustache"
  case compiled of
    Left err -> error (show err)
    Right template -> return template

userValue :: User.User -> WRAction Value
userValue u = return $ object ["id" ~> User.id u, "name" ~> User.name u]

weightRecordValue :: WRecord.WeightRecord -> WRAction Value
weightRecordValue wr = do
  ztime <- liftIO $ toZonedTime $ WRecord.time wr
  return $ object ["weight" ~> WRecord.weight wr, "time" ~> show ztime]

toZonedTime :: TM.LocalTime -> IO TM.ZonedTime
toZonedTime = TM.utcToLocalZonedTime . TM.localTimeToUTC TM.utc

weightGraphValue :: [WRecord.WeightRecord] -> WRAction [Value]
weightGraphValue wrs = do
  flatWrs <- liftIO $ mapM flat wrs
  let wrss = groupBy ((==) `on` fst) .sortBy (compare `on` fst) $ flatWrs
  return $ map groupToValue wrss
  where
    flat wr = do
      ztime <- toZonedTime $ WRecord.time wr
      let ztimeStr = TM.formatTime TM.defaultTimeLocale "%m/%d" ztime
          w = WRecord.weight wr
      return (ztimeStr, w)
    groupToValue gr =
      let dt = head $ map fst gr
          wt = avg $ map snd gr
          avg xs = sum xs / fromIntegral (length xs)
      in object ["day" ~> dt, "weight" ~> wt]

mainView :: Maybe TXT.Text -> WRAction a
mainView mMes = do
  Just user <- wrconUser <$> getContext
  uv <- userValue user
  rs <- runSqlite $ selectWRecord (User.id user)
  rvs <- mapM weightRecordValue rs
  wgv <- weightGraphValue rs
  tpl <- wrstMainTemplate <$> getState
  let v = object $ appendMessage mMes ["user" ~> uv, "records" ~> rvs, "graphs" ~> wgv]
  html $ substitute tpl v
  where
    appendMessage (Just mes) ps = "message" ~> mes : ps
    appendMessage Nothing ps = ps