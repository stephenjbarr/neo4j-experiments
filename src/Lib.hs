{-# LANGUAGE OverloadedStrings, DeriveGeneric, ScopedTypeVariables #-}

module Lib where

import Database.Neo4j
import Database.Neo4j.Batch
import System.Random             as R

import Data.Map as Map
import Data.Aeson
import Data.Aeson.Lens
import Network.Wreq
import Control.Lens


someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- | ---------------------------------------------------------------------------
-- | Default Neo4j port
test_port :: Port
test_port = 8474

-- | Default Neo4j host
test_host :: Hostname
test_host = "localhost"

test_creds :: Credentials
test_creds = ("neo4j","xenon")

run     = withAuthConnection test_host test_port test_creds
-- | ---------------------------------------------------------------------------


-- | Use wreq to get some random users
-- 
data User = User {
    uname   :: String
  -- , ugender :: String
  -- , uemail  :: String  
  }



getName rb = rb ^? key "results" . nth 0 . key "user" . key "email"

getRandUsers :: Int -> IO [User]
getRandUsers n = do
  r <-   get "http://api.randomuser.me"
  let rb = rr ^. responseBody
  
