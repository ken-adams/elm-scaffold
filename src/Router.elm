module Router exposing (Route(..), parse, route)

import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


type Route
    = HomePage
    | Dashboard


route : Url -> List Route -> ( Maybe Route, List Route )
route url h =
    case parse url of
        Nothing ->
            ( Nothing, h )

        Just r ->
            ( Just r, r :: h )


parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map HomePage (s "home")
        , map Dashboard top
        ]
