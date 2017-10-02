import Control.Monad.Trans.Reader (Reader, runReader, asks, local)

data PowerEnv = PowerEnv { powEnergy :: !Double
                         , powSaveMode :: !Bool
                         }

consume :: Reader PowerEnv Double
consume = do
  energy <- asks powEnergy
  savemode <- asks powSaveMode
  let consumption = if savemode then energy / 10.0
                                else energy
  return consumption

testrun :: PowerEnv -> Double
testrun env = (`runReader` env) $ do
  cons1 <- consume
  cons2 <- consume
  consOthers <- local (\e -> e {powSaveMode = True}) $ do
    cons3 <- consume
    cons4 <- consume
    return (cons3 + cons4)
  return (cons1 + cons2 + consOthers)