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
import Json.Decode
import Request exposing (Request)


type alias Model =
    { counter : Int
    }


type Msg
    = Increment
    | Decrement


init : Request -> Result Json.Decode.Error InteropDefinitions.Flags -> ( Model, Cmd Msg )
init _ flagsResult =
    case flagsResult of
        Ok flags ->
            ( { counter = Maybe.withDefault 0 flags.counter }, Cmd.none )

        Err error ->
            ( { counter = 0 }
            , Json.Decode.errorToString error
                |> InteropDefinitions.Alert
                |> InteropPorts.fromElm
            )


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
            , newCounter
                |> InteropDefinitions.StoreCounter
                |> InteropPorts.fromElm
            )

        Decrement ->
            let
                newCounter : Int
                newCounter =
                    model.counter - 1
            in
            ( { model | counter = newCounter }
            , newCounter
                |> InteropDefinitions.StoreCounter
                |> InteropPorts.fromElm
            )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


toElmSubscriptions : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscriptions toElm =
    case toElm of
        _ ->
            Nothing
