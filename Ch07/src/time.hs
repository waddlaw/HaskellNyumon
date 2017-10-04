import Data.Time

main :: IO ()
main = do
  zonedTime <- getZonedTime
  print zonedTime

add2DayFromNow :: IO ()
add2DayFromNow = do
  utcTime@(UTCTime day diffTime) <- getCurrentTime
  print utcTime
  let newTime = UTCTime (addDays 2 day) diffTime
  print newTime

add1HourFromNow :: IO ()
add1HourFromNow = do
  utcTime <- getCurrentTime
  print utcTime
  let newTime = addUTCTime (60*60) utcTime
  print newTime