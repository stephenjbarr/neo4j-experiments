{-# LANGUAGE OverloadedStrings, DeriveGeneric, ScopedTypeVariables #-}

import qualified Database.Neo4j.Transactional.Cypher as TC
import qualified Data.HashMap.Lazy as M
import Data.Either.Unwrap
import Data.Aeson
import Data.Aeson.Lens
import Control.Lens

import Data.HashMap.Strict as HM


-- parseS :: Value -> Parser String
-- parseS (Object o) = 


parseSname :: Value -> Maybe String
parseSname (Object o) = HM.lookup "survey_name" o
parseSname _  = undefined
