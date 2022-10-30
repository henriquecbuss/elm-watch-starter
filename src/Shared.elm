module Shared exposing
    ( Model
    , Msg, increment, decrement
    , init, update
    , toElmSubscriptions
    )

{-| The shared module. This is where all the logic that's shared between pages
should live.

@docs Model

@docs Msg, increment, decrement

@docs init, update

@docs toElmSubscriptions

-}

import InteropDefinitions
import InteropPorts
import Request exposing (Request)


{-| The shared model. Pages have access to this.
-}
type alias Model =
    { counter : Int
    }


{-| Everything the Shared module can do. Other pages have read access to this.
You should expose functions to construct Msgs if you want to use them in other
modules.
-}
type Msg
    = Increment
    | Decrement


{-| Increment the counter
-}
increment : Msg
increment =
    Increment


{-| Decrement the counter
-}
decrement : Msg
decrement =
    Decrement


{-| Initialize the shared module
-}
init : Request -> InteropDefinitions.Flags -> ( Model, Cmd Msg )
init _ flags =
    ( { counter = Maybe.withDefault 0 flags.counter }, Cmd.none )


{-| Update the shared module
-}
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


{-| Receive values from Typescript
-}
toElmSubscriptions : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscriptions _ =
    Nothing
