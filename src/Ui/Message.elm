module Ui.Message exposing (view)

import Html
import Html.Attributes exposing (class)
import Ui.Helpers


view : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
view =
    Ui.Helpers.withAttributes
        [ class "bg-gray-100 rounded border-l-4 border-blue-elm p-4" ]
