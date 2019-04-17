{-# LANGUAGE QuasiQuotes, TemplateHaskell, OverloadedStrings #-}

import System.Environment
import Web.Scotty as S
import Data.Text
import Text.Hamlet (hamletFile)
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Data.Monoid (mconcat)
import Control.Monad (liftM)


import Control.Monad (forM_)
import Text.Blaze.Html5 as H hiding (map, main)
import Text.Blaze.Html5.Attributes as A

blaze = S.html . renderHtml

main :: IO ()
main = do
  port <- liftM read $ getEnv "PORT"
  scotty port $ do

    get "/" $ do
      blaze $ do
        H.html $ do
          H.head $ do
            H.title "Natural numbers"
          H.body $ do
            H.p "A list of natural numbers:"
            H.a ! href "/test" $ "name"
  