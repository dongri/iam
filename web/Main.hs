{-# LANGUAGE QuasiQuotes, TemplateHaskell, OverloadedStrings #-}

import System.Environment
import Web.Scotty as S
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Data.HashMap (fromList, toList)
import Data.Foldable (for_)
import Control.Monad (liftM)

import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A

import Network.Wai.Middleware.Static

blaze :: Html -> ActionM()
blaze = S.html . renderHtml

layout :: Html -> Html
layout insideDiv = H.html $ do
  H.head $ do
    H.meta ! A.name "viewport" ! A.content "width=device-width, initial-scale=1, maximum-scale=1"
    H.link ! A.rel "shortcut icon" ! A.href "/img/icon.png"
    H.link ! A.rel "stylesheet" ! A.href "/css/style.css" ! A.type_ "text/css"
    H.script ! A.src "/js/vue.min.js" ! A.type_ "text/javascript" $ ""
    H.title "D"
  H.body $ do
    H.div $ do
      H.div insideDiv
    H.footer $ do
      H.small $ do
        "Powered by Haskell, Docker, Heroku λ "
        H.a ! A.href "https://github.com/dongri/iam" $ "iam"
        H.span ! A.id "year" $ "{{ message }}"
    H.script ! A.src "/js/app.js" ! A.type_ "text/javascript" $ ""
    H.script ! A.src "//infix.herokuapp.com/in.js" ! A.type_ "text/javascript" $ ""

main :: IO ()
main = do
  port <- liftM read $ getEnv "PORT"
  scotty port $ do

    middleware $ staticPolicy $ addBase "static" >-> (contains "/img/" <|> contains "/css/" <|> contains "/js/")

    get "/" $ do
      blaze $ do
        layout $ do
          H.h2 $ "Dongri Jin"
          H.img ! A.src "/img/icon.png" ! A.class_ "icon"
          H.p $ "I am Software Engineer"
          H.p $ "I was born in China currently live in Tokyo"
          H.p $ do
            "My hobby programming code is on "
            H.a ! A.href "https://github.com/dongri" $ "GitHub"
          H.p $ "I like [🍜,🍺,🍣,⚽]"
          H.p $ do
            "You can find me on "
            H.a ! A.href "https://twitter.com/dongrify" $ "Twitter"
            " or "
            H.a ! href "https://www.linkedin.com/in/dongri/" $ "LinkedIn"

    get "/web" $ do
      let menuList = fromList [
            ("https://lgtm.lol/" :: String, "LGTM" :: String),
            ("https://play.hackerth.com/", "Play"), 
            ("https://todo.hackerth.com/", "ToDo"),
            ("https://dapp.hackerth.com/", "Dapp"),
            ("https://wallet.hackerth.com/wallet", "Ethereum Wallet"),
            ("https://shortener.hackerth.com/", "Shortener"),
            ("https://merci.hackerth.com/", "Merci"),
            ("https://memory.hackerth.com/", "Memory")]
      blaze $ do
        layout $ do
          H.h2 $ "Web"
          H.ul $ do
            for_ (toList menuList) $ \(l, t) -> do
              H.li $ H.a ! A.href (toValue(l)) $ H.toHtml t

    get "/ios" $ do
      let urlPrefix = "https://itunes.apple.com/jp/app"
      let menuList = fromList [
            (urlPrefix ++ "/linux/id482925647?mt=8" :: String, "Command for Linux" :: String),
            (urlPrefix ++ "/plain-piano/id568845656?mt=8", "Plain Piano"), 
            (urlPrefix ++ "/chi-yantta/id532936651?mt=8", "喫煙ったー"),
            (urlPrefix ++ "/stagram/id488147065?mt=8", "Stagram"),
            (urlPrefix ++ "/weekdays/id477937842?mt=8", "Weekdays"),
            (urlPrefix ++ "/tweetese/id450980735?mt=8", "Tweetese")]
      blaze $ do
        layout $ do
          H.h2 $ "iOS"
          H.ul $ do
            for_ (toList menuList) $ \(l, t) -> do
              H.li $ H.a ! A.href (toValue(l)) $ H.toHtml t
          H.h5 $ "contact: dongrify[at]gmail.com"

    get "/android" $ do
      let urlPrefix = "https://play.google.com/store/apps/details?id="
      let menuList = fromList [
            (urlPrefix ++ "org.dongri.donpay" :: String, "DonPay" :: String),
            (urlPrefix ++ "org.dongri.androidid", "Android ID"), 
            (urlPrefix ++ "lol.lgtm", "LGTM"),
            (urlPrefix ++ "com.guncy.android.cardreader", "Suica PASMOリーダー"),
            (urlPrefix ++ "at.dongri.qiitamini", "Qiita Mini"),
            (urlPrefix ++ "at.dongri.android.ibeaconfinder", "iBeacon Finder"),
            (urlPrefix ++ "at.dongri.android.smoca", "喫煙ったー"),
            (urlPrefix ++ "at.dongri.stagram", "Stagram")]
      blaze $ do
        layout $ do
          H.h2 $ "Android"
          H.ul $ do
            for_ (toList menuList) $ \(l, t) -> do
              H.li $ H.a ! A.href (toValue(l)) $ H.toHtml t
          H.h5 $ "contact: dongrify[at]gmail.com"
