{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Text.Hastache

main :: IO ()
main = scotty 3000 $ do
  setTemplatesDir "templates"

  get "/:word" $ do
    beam <- param "word"
    setH "action" $ MuVariable (beam :: String)
    -- ^ "action" will be binded to the contents of 'beam'
    hastache "index.html"

  get "/hello" $ do
    html $ mconcat ["<h1>Hello Haskell, Hello Scotty</h1>"]
