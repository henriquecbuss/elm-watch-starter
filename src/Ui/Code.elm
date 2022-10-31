module Ui.Code exposing (view, viewBlock)

{-| View some formatted code

@docs view, viewBlock

-}

import Html
import Html.Attributes exposing (class)


{-| View a piece of code inline
-}
view : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
view attributes children =
    Html.code (class "bg-gray-200 px-1 rounded text-blue-elm" :: attributes) children


{-| View a block of code that spans multiple lines
-}
viewBlock : List (Html.Attribute msg) -> List String -> Html.Html msg
viewBlock attributes lines =
    Html.pre (class "bg-gray-100 rounded py-2 px-4 text-blue-elm border-l-4 border-blue-elm" :: attributes)
        (List.map
            (\line ->
                Html.div []
                    [ Html.text line ]
            )
            lines
        )
