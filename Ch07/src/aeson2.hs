{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson

nameListValue :: Value
nameListValue = Array
  [ object
    [ "coworkers" .= Array
      [ object
        [ "age" .= Number 20
        , "name" .= String "Satoshi"
        ]
      , object
        [ "age" .= Number 23
        , "name" .= String "Takeshi"
        ]
      ]
    , "departmentName" .= String "Planning"
    ]
  ]