module InteropDefinitions exposing (Flags, FromElm(..), ToElm(..), interop)

import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder, required)


interop :
    { toElm : Decoder ToElm
    , fromElm : Encoder FromElm
    , flags : Decoder Flags
    }
interop =
    { toElm = toElm
    , fromElm = fromElm
    , flags = flags
    }


type FromElm
    = Alert String
    | StoreCounter Int
    | ScrollTo { querySelector : String }


type ToElm
    = Alerted


type alias Flags =
    { counter : Maybe Int
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
