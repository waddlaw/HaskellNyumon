import Control.Monad (guard)

points :: [(Integer, Integer)]
points = do
  x <- [1..3]
  y <- [1..3]
  return (x,y)

orderedPoints :: [(Integer, Integer)]
orderedPoints = do
  x <- [1..3]
  y <- [1..3]
  guard (x < y)
  return (x,y)