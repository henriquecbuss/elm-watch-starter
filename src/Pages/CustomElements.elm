module Pages.CustomElements exposing
    ( Model, Msg, page
    , toElmSubscription
    )

{-| CustomElements

@docs Model, Msg, page

@docs toElmSubscription

-}

import Gen.Params.CustomElements exposing (Params)
import Html
import Html.Attributes exposing (class)
import Html.Events
import InteropDefinitions
import Page
import Request
import Shared
import Ui.AutoAnimate
import Ui.Code
import Ui.Header
import Ui.Link
import Ui.Message
import View exposing (View)


{-| The model for this page
-}
type alias Model =
    { maxIndex : Int
    , items : List Int
    }


{-| Everything this page can do
-}
type Msg
    = ClickedAdd
    | ClickedRemove Int


{-| This is how elm-spa knows what to do with our app
-}
page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


init : Model
init =
    { maxIndex = 0
    , items = []
    }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedAdd ->
            { model
                | maxIndex = model.maxIndex + 1
                , items = model.maxIndex :: model.items
            }

        ClickedRemove id ->
            { model | items = List.filter (\item -> item /= id) model.items }



-- VIEW


view : Model -> View Msg
view model =
    { title = "custom elements"
    , body =
        [ Ui.Header.view
        , Html.main_ [ class "container mx-auto px-4 pb-40" ]
            [ Html.h2 [ class "text-4xl font-bold" ] [ Html.text "Custom Elements 💻" ]
            , Html.p [ class "mt-4" ] [ Html.text "Custom elements play a major role in modern Elm development. You can do a lot with them!" ]
            , Html.p [] [ Html.text "Because of that, this template starts with a custom element to use as an example, and a script to generate some nice things automatically for us." ]
            , Html.section [ class "mt-8" ]
                [ Html.h3 [ class "text-xl" ] [ Html.text "Example" ]
                , Html.p [ class "mt-2" ]
                    [ Html.text "This example uses the excellent "
                    , Ui.Link.viewExternal { href = "https://auto-animate.formkit.com" }
                        []
                        [ Html.text "auto-animate" ]
                    , Html.text " library to automatically animate items coming in and out of lists. In the example below, click the `Add` button to add items to the list, and click on list items to remove them from the list."
                    ]
                , Html.div [ class "mt-4 border-2 border-dashed p-4 rounded-sm" ]
                    [ Html.button
                        [ Html.Events.onClick ClickedAdd
                        , class "w-full bg-blue-elm px-6 py-2 text-white rounded"
                        ]
                        [ Html.text "Add" ]
                    , Ui.AutoAnimate.viewKeyed [ class "flex flex-wrap gap-2 mt-4 items-start" ]
                        (List.map
                            (\item ->
                                ( String.fromInt item
                                , Html.button
                                    [ Html.Events.onClick (ClickedRemove item)
                                    , class "bg-blue-elm p-4 text-white rounded w-16 text-center"
                                    ]
                                    [ Html.text (String.fromInt item) ]
                                )
                            )
                            model.items
                        )
                    ]
                ]
            , Html.section [ class "mt-8" ]
                [ Html.h3 [ class "text-xl" ] [ Html.text "How to use this template" ]
                , Html.p [ class "mt-2" ]
                    [ Html.text "The "
                    , Ui.Code.view [] [ Html.text "generate" ]
                    , Html.text " script in "
                    , Ui.Code.view [] [ Html.text "package.json" ]
                    , Html.text " is really powerful! It uses many tools to generate code for various things. It also can have our very own scripts! They should live under the "
                    , Ui.Code.view [] [ Html.text "scripts" ]
                    , Html.text " directory. An example is the "
                    , Ui.Code.view [] [ Html.text "generateCustomElements.ts" ]
                    , Html.text " script, which is used to generate code for using custom elements. It reads all of the files inside "
                    , Ui.Code.view [] [ Html.text "src/ts/customElements" ]
                    , Html.text " to generate Elm files to make it easier for us to use them. For example, given this auto animate custom component (in Typescript):"
                    ]
                , Ui.Code.viewBlock [ class "mt-4" ]
                    [ "import autoAnimate from \"@formkit/auto-animate\";"
                    , " "
                    , "class AutoAnimate extends HTMLElement {"
                    , "  connectedCallback() {"
                    , "    autoAnimate(this);"
                    , "  }"
                    , "}"
                    , " "
                    , "export default { name: \"auto-animate\", classConstructor: AutoAnimate };"
                    ]
                , Html.p [ class "mt-4" ]
                    [ Html.text "It will generate this Elm file:"
                    ]
                , Ui.Code.viewBlock [ class "mt-4" ]
                    [ "module Ui.AutoAnimate exposing (view, viewKeyed)"
                    , " "
                    , "{-| AutoAnimate"
                    , " "
                    , "@docs view, viewKeyed"
                    , " "
                    , "-}"
                    , " "
                    , "import Html"
                    , "import Html.Keyed"
                    , " "
                    , " "
                    , "{-| View `auto-animate` as a regular Html node"
                    , "-}"
                    , "view : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg"
                    , "view ="
                    , "    Html.node \"auto-animate\""
                    , " "
                    , " "
                    , "{-| View `auto-animate` as a keyed Html node"
                    , "-}"
                    , "viewKeyed : List (Html.Attribute msg) -> List ( String, Html.Html msg ) -> Html.Html msg"
                    , "viewKeyed ="
                    , "    Html.Keyed.node \"auto-animate\""
                    ]
                , Html.p [ class "mt-4" ] [ Html.text "You can then use it in your Elm code like this:" ]
                , Ui.Code.viewBlock [ class "mt-4" ]
                    [ "Ui.AutoAnimate.viewKeyed []"
                    , "    (List.map"
                    , "        (\\item ->"
                    , "            ( String.fromInt item"
                    , "            , Html.button [ Html.Events.onClick (ClickedRemove item) ]"
                    , "                [ Html.text (String.fromInt item) ]"
                    , "            )"
                    , "        )"
                    , "        model.items"
                    , "    )"
                    ]
                , Html.p [ class "mt-4" ]
                    [ Html.text "So in summary, you just need to write your custom element in "
                    , Ui.Code.view [] [ Html.text "src/ts/customElements" ]
                    , Html.text ", run "
                    , Ui.Code.view [] [ Html.text "npm run generate" ]
                    , Html.text ", and you're good to go!"
                    ]
                , Ui.Message.view Html.aside
                    [ class "mt-4" ]
                    [ Html.text "The script will also generate a "
                    , Ui.Code.view [] [ Html.text "generated/customElements.ts" ]
                    , Html.text " file, which exports a function that registers all of the custom elements into the page. You don't need to worry about it though, we already run this function in "
                    , Ui.Code.view [] [ Html.text "index.ts" ]
                    ]
                ]
            ]
        ]
    }



-- PORT SUBSCRIPTION


{-| Subscribe to messages from Typescript
-}
toElmSubscription : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscription _ =
    Nothing
