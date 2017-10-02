import Control.Exception.Lifted (bracket)
import Control.Monad.Trans (lift)
import Control.Monad.Trans.Reader (runReaderT, ask)
import System.IO (openFile, IOMode(ReadMode), hGetContents, hClose)

path :: FilePath
path = "chap05/src/lifted-bracket.hs"

main :: IO ()
main = (`runReaderT` path) $ do
  bracket open close $ \h -> do
    content <- lift (hGetContents h)
    lift $ print (length content)
  where
    open = do
      p <- ask
      lift $ openFile p ReadMode
    close = lift . hClose