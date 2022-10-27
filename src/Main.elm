module Main exposing (main)

import Browser
import Html
import InteropDefinitions
import InteropPorts
import Json.Decode


main : Program Json.Decode.Value Model Msg
main =
    Browser.application
        { init = \flags _ _ -> init flags
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = \_ -> NoOp
        , onUrlRequest = \_ -> NoOp
        }



-- MODEL


type alias Model =
    {}


init : Json.Decode.Value -> ( Model, Cmd Msg )
init jsonFlags =
    case InteropPorts.decodeFlags jsonFlags of
        Ok _ ->
            ( {}, Cmd.none )

        Err error ->
            ( {}
            , Json.Decode.errorToString error
                |> InteropDefinitions.Alert
                |> InteropPorts.fromElm
            )



-- TYPES


type Msg
    = NoOp
    | GotToElmPort (Result Json.Decode.Error InteropDefinitions.ToElm)



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotToElmPort (Err error) ->
            ( model
            , Json.Decode.errorToString error
                |> InteropDefinitions.Alert
                |> InteropPorts.fromElm
            )

        GotToElmPort (Ok InteropDefinitions.Alerted) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view _ =
    { title = "TODO"
    , body =
        [ Html.text "Hello from elm"
        ]
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    InteropPorts.toElm
        |> Sub.map GotToElmPort
