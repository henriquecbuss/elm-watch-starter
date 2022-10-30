module InteropDefinitions exposing
    ( Flags, FromElm(..), ToElm(..)
    , interop
    )

{-| This is where we define the messages that can be exchanged between Elm and
Typescript

@docs Flags, FromElm, ToElm

@docs interop

-}

import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder, required)


{-| The initial flags that we receive from Typescript
-}
type alias Flags =
    { counter : Maybe Int
    }


{-| Messages that we can send from Elm to Typescript
-}
type FromElm
    = Alert String
    | StoreCounter Int
    | ScrollTo { querySelector : String }


{-| Messages that we can send from Typescript to Elm
-}
type ToElm
    = Alerted


{-| This is what elm-ts-interop uses to figure out what to do with our app
-}
interop :
    { flags : Decoder Flags
    , fromElm : Encoder FromElm
    , toElm : Decoder ToElm
    }
interop =
    { flags = flags
    , fromElm = fromElm
    , toElm = toElm
    }


fromElm : Encoder FromElm
fromElm =
    TsEncode.union
        (\vAlert vStoreCounter vScrollTo value ->
            case value of
                Alert string ->
                    vAlert string

                StoreCounter counter ->
                    vStoreCounter counter

                ScrollTo querySelector ->
                    vScrollTo querySelector
        )
        |> TsEncode.variantTagged "alert"
            (TsEncode.object [ required "message" identity TsEncode.string ])
        |> TsEncode.variantTagged "storeCounter"
            (TsEncode.object [ required "counter" identity TsEncode.int ])
        |> TsEncode.variantTagged "scrollTo"
            (TsEncode.object [ required "querySelector" .querySelector TsEncode.string ])
        |> TsEncode.buildUnion


toElm : Decoder ToElm
toElm =
    TsDecode.discriminatedUnion "tag"
        [ ( "alerted"
          , TsDecode.succeed Alerted
          )
        ]


flags : Decoder Flags
flags =
    TsDecode.succeed (\counter -> { counter = counter })
        |> TsDecode.andMap (TsDecode.optionalNullableField "counter" TsDecode.int)
