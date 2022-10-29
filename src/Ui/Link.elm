module Ui.Link exposing (view, viewExternal)

import Gen.Route
import Html
import Html.Attributes as Attr exposing (class)


{-| A link to an internal page of the app (using the `Gen.Route.Route` type)
-}
view : Gen.Route.Route -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
view route attributes children =
    viewExternal { href = Gen.Route.toHref route } attributes children


{-| A link to an external page, or to an id inside a page (using a string `href`)
-}
viewExternal : { href : String } -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
viewExternal { href } attributes children =
    Html.a
        (defaultClass
            :: Attr.href href
            :: attributes
        )
        children


defaultClass : Html.Attribute msg_
defaultClass =
    class "text-blue-elm hover:underline"
