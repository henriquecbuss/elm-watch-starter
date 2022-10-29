module Shared exposing
    ( Model
    , Msg(..)
    , init
    , subscriptions
    , toElmSubscriptions
    , update
    )

import InteropDefinitions
import InteropPorts
import Json.Decode as Decode
import Request exposing (Request)


type alias Model =
    { counter : Int
    }


type Msg
    = Increment
    | Decrement


init : Request -> Result Decode.Error InteropDefinitions.Flags -> ( Model, Cmd Msg )
init _ flagsResult =
    case flagsResult of
        Ok flags ->
            ( { counter = Maybe.withDefault 0 flags.counter }, Cmd.none )

        Err error ->
            ( { counter = 0 }
            , Decode.errorToString error
                |> InteropDefinitions.Alert
                |> InteropPorts.fromElm
            )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


toElmSubscriptions : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscriptions toElm =
    Nothing


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        Increment ->
            let
                newCounter : Int
                newCounter =
                    model.counter + 1
            in
            ( { model | counter = newCounter }
            , InteropDefinitions.StoreCounter newCounter
                |> InteropPorts.fromElm
            )

        Decrement ->
            let
                newCounter : Int
                newCounter =
                    model.counter - 1
            in
            ( { model | counter = newCounter }
            , InteropDefinitions.StoreCounter newCounter
                |> InteropPorts.fromElm
            )
