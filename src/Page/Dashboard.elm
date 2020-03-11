module Page.Dashboard exposing (view)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "dashboard" ]
        [ h1 [] [ text "Welcome to Dashboard Page" ]
        , div [] [ text "This is a dashboard Page" ]
        ]
