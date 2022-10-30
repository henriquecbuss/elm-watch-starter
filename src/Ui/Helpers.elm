module Ui.Helpers exposing (withAttributes)

{-| Useful helpers to build Uis
-}

import Html


{-| An html element with some predefined attributes
-}
withAttributes : List (Html.Attribute msg) -> (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
withAttributes attributes element outerAttributes children =
    element (attributes ++ outerAttributes) children
