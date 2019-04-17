{-# LANGUAGE QuasiQuotes, TemplateHaskell, OverloadedStrings #-}

import System.Environment
import Web.Scotty as S
import Text.Blaze.Html.Renderer.Text (renderHtml)

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
    H.title "D"
  H.body $ do
    H.div $ do
      H.div insideDiv
    H.footer $ do
      H.small $ do
        "Powered by Haskell, Docker, Heroku λ "
        H.a ! A.href "https://github.com/dongri/iam" $ "D" 

main :: IO ()
main = do
  port <- liftM read $ getEnv "PORT"
  scotty port $ do

    middleware $ staticPolicy $ addBase "static" >-> (contains "/img/" <|> contains "/css/")

    get "/" $ do
      blaze $ do
        layout $ do
          H.h2 $ "Dongri Jin"
          H.img ! A.src "/img/icon.png" ! A.class_ "icon"
          H.p $ "I am Software Engineer"
          H.p $ "I was born in China currently live in Tokyo"
          H.p $ do
            "My hobby programming code is on "
            H.a ! href "https://github.com/dongri" $ "GitHub"
          H.p $ "I like [🍜,🍺,🍣,⚽]"
          H.p $ do
            "You can find me on "
            H.a ! A.href "https://twitter.com/dongrify" $ "Twitter"
            " or "
            H.a ! href "https://www.linkedin.com/in/dongri/" $ "LinkedIn"

    get "/web" $ do
      blaze $ do
        layout $ do
          H.h2 $ "Web"
          H.ul $ do
            H.li $ H.a ! href "https://lgtm.lol/" $ "LGTM"
            H.li $ H.a ! href "https://play.hackerth.com/" $ "Play"
            H.li $ H.a ! href "https://todo.hackerth.com/" $ "ToDo"
            H.li $ H.a ! href "https://dapp.hackerth.com/" $ "Dapp"
            H.li $ H.a ! href "https://wallet.hackerth.com/wallet" $ "Ethereum Wallet"
            H.li $ H.a ! href "https://shortener.hackerth.com/" $ "Shortener"
            H.li $ H.a ! href "https://merci.hackerth.com/" $ "Merci"
            H.li $ H.a ! href "https://memory.hackerth.com/" $ "Memory"            

    get "/ios" $ do
      let urlPrefix = "https://itunes.apple.com/jp/app"
      blaze $ do
        layout $ do
          H.h2 $ "iOS"
          H.ul $ do
            H.li $ H.a ! href (toValue(urlPrefix ++ "/linux/id482925647?mt=8")) $ "Command for Linux"
            H.li $ H.a ! href (toValue(urlPrefix ++ "/plain-piano/id568845656?mt=8")) $ "Plain Piano"
            H.li $ H.a ! href (toValue(urlPrefix ++ "/chi-yantta/id532936651?mt=8")) $ "喫煙ったー"
            H.li $ H.a ! href (toValue(urlPrefix ++ "/stagram/id488147065?mt=8")) $ "Stagram"
            H.li $ H.a ! href (toValue(urlPrefix ++ "/weekdays/id477937842?mt=8")) $ "Weekdays"
            H.li $ H.a ! href (toValue(urlPrefix ++ "/tweetese/id450980735?mt=8")) $ "Tweetese"
          H.h5 $ "contact: dongrify[at]gmail.com"

    get "/android" $ do
      let urlPrefix = "https://play.google.com/store/apps/details?id="
      blaze $ do
        layout $ do
          H.h2 $ "Android"
          H.ul $ do
            H.li $ H.a ! href (toValue(urlPrefix ++ "org.dongri.donpay")) $ "DonPay"
            H.li $ H.a ! href (toValue(urlPrefix ++ "org.dongri.androidid")) $ "Android ID"
            H.li $ H.a ! href (toValue(urlPrefix ++ "lol.lgtm")) $ "LGTM"
            H.li $ H.a ! href (toValue(urlPrefix ++ "com.guncy.android.cardreader")) $ "Suica PASMOリーダー"
            H.li $ H.a ! href (toValue(urlPrefix ++ "at.dongri.qiitamini")) $ "Qiita Mini"
            H.li $ H.a ! href (toValue(urlPrefix ++ "at.dongri.android.ibeaconfinder")) $ "iBeacon Finder"
            H.li $ H.a ! href (toValue(urlPrefix ++ "at.dongri.android.smoca")) $ "喫煙ったー"
            H.li $ H.a ! href (toValue(urlPrefix ++ "at.dongri.stagram")) $ "Stagram"
          H.h5 $ "contact: dongrify[at]gmail.com"

