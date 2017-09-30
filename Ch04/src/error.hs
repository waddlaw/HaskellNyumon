import Control.Exception

catchZeroDiv :: ArithException -> IO Int
catchZeroDiv DivideByZero = return 0
catchZeroDiv e = throwIO e