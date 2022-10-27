module Ui.Header exposing (view)

import Gen.Route
import Html
import Html.Attributes exposing (class)
import Icons


view : Html.Html msg
view =
    Html.header [ class "bg-blue-elm h-16 text-white mb-10" ]
        [ Html.nav
            [ class "container mx-auto px-4 h-full"
            ]
            [ Html.a
                [ class "flex w-max gap-2 items-center h-full pb-1"
                , Html.Attributes.href (Gen.Route.toHref Gen.Route.Home_)
                ]
                [ Icons.elm
                , Html.h1 [ class "text-3xl" ] [ Html.text "elm-watch starter" ]
                ]
            ]
        ]
