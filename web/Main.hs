{-# LANGUAGE QuasiQuotes, TemplateHaskell, OverloadedStrings #-}

import System.Environment
import Web.Scotty
import Data.Text
import Text.Hamlet (hamletFile)
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Data.Monoid (mconcat)
import Control.Monad (liftM)

main :: IO ()
main = do
  port <- liftM read $ getEnv "PORT"
  scotty port $ do

    get "/" $ do
      let title = pack "hoge"
      html $ renderHtml $ $(hamletFile "views/index.hamlet") undefined

    get "/hello" $ do
      html $ mconcat ["<h1>Hello Haskell, Hello Scotty</h1>"]
