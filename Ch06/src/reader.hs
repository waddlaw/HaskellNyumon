
import Control.Monad.Trans.Reader

newtype Name = Name String
newtype Path = Path String
data DefaultValues = DefaultValues
  { defaultName :: Name
  , defaultPath :: Path
  }

getDefaultName :: Reader DefaultValues Name
getDefaultName = asks defaultName

getDefaultPath :: Reader DefaultValues Path
getDefaultPath = asks defaultPath