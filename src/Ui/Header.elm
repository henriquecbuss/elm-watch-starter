module Ui.Header exposing (view)

{-| The header that shows up in all pages

@docs view

-}

import Gen.Route
import Html
import Html.Attributes as Attr exposing (class)
import Icons


{-| View the header
-}
view : Html.Html msg_
view =
    Html.header [ class "bg-blue-elm h-16 text-white mb-10" ]
        [ Html.nav
            [ class "container mx-auto px-4 h-full"
            ]
            [ Html.a
                [ class "flex w-max gap-2 items-center h-full pb-1"
                , Attr.href (Gen.Route.toHref Gen.Route.Home_)
                ]
                [ Icons.elm
                , Html.h1 [ class "text-3xl" ] [ Html.text "elm-watch starter" ]
                ]
            ]
        ]
