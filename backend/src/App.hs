{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeOperators #-}

module App where

import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import System.IO

data Inp = Inp String deriving (Eq, Show, Generic)

instance ToJSON Inp
instance FromJSON Inp

-- define api types
type Api' = Get '[JSON] [Inp] 

-- stores api type info so Servant can distinguish btwn api types
proxy' :: Proxy Api'
proxy' = Proxy

apiServer :: Server Api' -- get an item or retrieve somn by id
apiServer = getAll

getAll :: Handler [Inp]
getAll = return [emptyInp, Inp $ "hello world"]

emptyInp :: Inp
emptyInp = Inp "."

app' :: Application -- takes apis as param, produces wai app
app' = serve proxy' apiServer

run' :: Int -> IO () -- runs wai app on the port passed as param
run' port = run port app'
