module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg(..))
import Page.Dashboard
import Page.HomePage
import Router exposing (Route(..))
import Url


main : Platform.Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , history : List Route

    -- Pages
    , homepage : Page.HomePage.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        model =
            { key = key
            , url = url
            , history = []
            , homepage = Page.HomePage.init
            }
    in
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newModel =
            model
    in
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            changeUrl url model

        HomePageMsg submsg ->
            let
                ( homepage, cmd ) =
                    Page.HomePage.update submsg newModel.homepage
            in
            ( { newModel | homepage = homepage }, Cmd.map HomePageMsg cmd )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    Browser.Document "" <|
        [ div []
            [ text "The current URL is: "
            , b [] [ text (Url.toString model.url) ]
            , ul []
                [ viewLink "/home" "Home"
                , viewLink "/" "Back"
                ]
            ]
        , div []
            [ let
                routeView =
                    Maybe.map (viewRoute model) (List.head model.history)
              in
              div [ class "main" ]
                [ Maybe.withDefault Page.Dashboard.view routeView ]
            ]
        ]


viewRoute : Model -> Route -> Html Msg
viewRoute model route =
    case route of
        HomePage ->
            Html.map HomePageMsg <| Page.HomePage.view model.homepage

        Dashboard ->
            Page.Dashboard.view


viewLink : String -> String -> Html msg
viewLink path txt =
    li [] [ a [ href path ] [ text txt ] ]


changeUrl : Url.Url -> Model -> ( Model, Cmd Msg )
changeUrl url model =
    case Router.route url model.history of
        ( Just route, history ) ->
            -- let
            -- cmd =
            --     Router.command model.endpoint model.token route
            -- in
            ( { model | history = history }, Cmd.none )

        ( Nothing, history ) ->
            ( { model | history = history }, Cmd.none )
