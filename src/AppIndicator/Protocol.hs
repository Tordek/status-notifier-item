{-# LANGUAGE OverloadedStrings #-}
module AppIndicator.Protocol where

import AppIndicator.Util
import DBus
import DBus.Client
import DBus.Introspection
import Data.List (sort)
import Data.Maybe
import Data.String (fromString)
import Paths_appindicator_tray ( getDataDir )
import System.FilePath ( (</>) )
import System.IO.Unsafe

getXMLDataFile :: String -> IO FilePath
getXMLDataFile filename = (</> filename) . (</> "xml") <$> getDataDir

statusNotifierWatcher = head . maybeToList .
  parseXML (fromString "/") <$>
  (getXMLDataFile "StatusNotifierWatcher.xml" >>= readFile)
