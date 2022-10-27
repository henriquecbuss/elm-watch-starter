module Ui.Helpers exposing (withAttributes)

import Html


withAttributes : List (Html.Attribute msg) -> (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
withAttributes attributes element outerAttributes children =
    element (attributes ++ outerAttributes) children
