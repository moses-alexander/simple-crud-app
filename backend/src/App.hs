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

data Loc = Loc { locId :: Integer
                , locName :: String
                } deriving (Eq, Show, Generic)
-- define some api types
type LocApi =
    "Location" :> Get '[JSON] [Loc] :<|>
    "Location" :> Capture "id" Integer :> Get '[JSON] Loc

-- stores api type info so Servant can distinguish btwn api types
proxy' :: Proxy LocApi
proxy' = Proxy

apiServer :: Server LocApi -- get an item or retrieve somn by id
apiServer = getLocs :<|> getLocById

getLocs :: Handler [Loc]
getLocs = return [emptyLoc]

getLocById :: Integer -> Handler Loc
getLocById x = case x of
                    0 -> return emptyLoc
                    _ -> throwError err404

emptyLoc :: Loc
emptyLoc = Loc 0 "."

instance ToJSON Loc
instance FromJSON Loc

app :: Application
app = serve proxy' apiServer

run' :: Int -> IO ()
run' x = run x app
