module Msg exposing (Msg(..))

import Browser
import Page.HomePage
import Url


type Msg
    = HomePageMsg Page.HomePage.Msg
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
