{-# LANGUAGE OverloadedStrings, DeriveGeneric, ScopedTypeVariables #-}

import qualified Database.Neo4j.Transactional.Cypher as TC
import qualified Data.HashMap.Lazy as M
import Data.HashMap.Strict as HM
import Data.Either.Unwrap
import Data.Aeson
import Data.Aeson.Lens
import Control.Lens

let emptyParams :: TC.Params =  M.fromList [] 
let survey_list_query = TC.cypher "match (s:SurveyStart) return s" emptyParams
let slq_trans =  TC.runTransaction survey_list_query
sql_res   <- run $ slq_trans
let r     = TC.fromSuccess sql_res
let rval = TC.vals r

let r0 = rval !! 0

-- this works 
-- Prelude.map (\x -> x ^? key "survey_name") r
let getnames y = Prelude.map (\x -> x ^? key "survey_name" . _String ) y
let z = Prelude.map getnames rval

-- this gets them, but they are still strings
let zm = fmap (\x -> fromJust (head x)) z
