module Main exposing (main)

import Browser
import Html exposing (Html, text)


main : Program Flags Model Msg
main =
    Browser.application
        { init = \_ _ _ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> NoOp
        , onUrlRequest = \_ -> NoOp
        }



-- MODEL


type alias Model =
    {}


type alias Flags =
    ()


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



-- TYPES


type Msg
    = NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "TODO"
    , body =
        [ Html.text "Hello from elm"
        ]
    }
