module Page.HomePage exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, h1, text)


type alias Model =
    { data : String }


type Msg
    = TestMsg


init : Model
init =
    Model ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view _ =
    h1 [] [ text "This is homepage" ]
