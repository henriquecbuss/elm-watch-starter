module Pages.Home_ exposing
    ( Model, Msg, page
    , toElmSubscription
    )

{-| Home\_

@docs Model, Msg, page

@docs toElmSubscription

-}

import Effect exposing (Effect)
import Gen.Params.Home_ exposing (Params)
import Gen.Route
import Html
import Html.Attributes as Attr exposing (class)
import Html.Events
import InteropDefinitions
import Page
import Request
import Shared
import Ui.Code
import Ui.Header
import Ui.Link
import Ui.Message
import View exposing (View)


{-| The model for this page
-}
type alias Model =
    {}


{-| Everything this page can do
-}
type Msg
    = ClickedDecrement
    | ClickedIncrement


{-| This is how elm-spa knows what to do with our app
-}
page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared _ =
    Page.advanced
        { init = init
        , update = update
        , view = view shared
        , subscriptions = \_ -> Sub.none
        }



-- INIT


init : ( Model, Effect Msg )
init =
    ( {}, Effect.none )



-- UPDATE


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ClickedDecrement ->
            ( model, Effect.fromShared Shared.decrement )

        ClickedIncrement ->
            ( model, Effect.fromShared Shared.increment )



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared _ =
    { title = "elm-watch starter"
    , body =
        [ Ui.Header.view
        , Html.main_ [ class "container mx-auto px-4 pb-40" ]
            [ viewFirstSection shared
            , viewGettingStarted
            ]
        ]
    }


viewFirstSection : Shared.Model -> Html.Html Msg
viewFirstSection shared =
    let
        buttonClass : Html.Attribute msg
        buttonClass =
            class "bg-blue-elm hover:bg-blue-elm/70 active:bg-blue-elm/80 text-white text-4xl w-20"
    in
    Html.section []
        [ Html.h2 [ class "text-4xl font-bold" ] [ Html.text "Hello, elm-watch! 👋" ]
        , Html.p [ class "mt-4" ]
            [ Html.text "This is a starter project for "
            , Ui.Link.viewExternal { href = "https://elm-lang.org" }
                []
                [ Html.text "elm" ]
            , Html.text ". It's built with "
            , Ui.Link.viewExternal { href = "https://lydell.github.io/elm-watch/" }
                []
                [ Html.text "elm-watch" ]
            , Html.text ", "
            , Ui.Link.viewExternal { href = "https://package.elm-lang.org/packages/elm-explorations/test/latest/" }
                []
                [ Html.text "elm-test" ]
            , Html.text ", "
            , Ui.Link.viewExternal { href = "https://package.elm-lang.org/packages/jfmengels/elm-review/latest/" }
                []
                [ Html.text "elm-review" ]
            , Html.text ", "
            , Ui.Link.viewExternal { href = "https://www.elm-spa.dev" }
                []
                [ Html.text "elm-spa" ]
            , Html.text ", "
            , Ui.Link.viewExternal { href = "https://elm-ts-interop.com" }
                []
                [ Html.text "elm-ts-interop" ]
            , Html.text " and many more goodies! Check out the "
            , Ui.Link.view Gen.Route.Tools
                []
                [ Html.text "tools page" ]
            , Html.text " to learn more about the tools used in this project, or the "
            , Ui.Link.viewExternal { href = "#getting-started" } [] [ Html.text "Getting started" ]
            , Html.text " section to learn how to use this template"
            ]
        , Html.p [ class "mt-10" ] [ Html.text "Just to show that the project works, here's the usual sample counter app:" ]
        , Html.div [ class "grid grid-cols-3 max-w-xs mx-auto mt-10 rounded border border-blue-elm shadow-lg" ]
            [ Html.button
                [ Html.Events.onClick ClickedDecrement
                , buttonClass
                , class "rounded-l place-self-start"
                ]
                [ Html.text "-" ]
            , Html.span [ class "text-center place-self-center" ] [ Html.text (String.fromInt shared.counter) ]
            , Html.button
                [ Html.Events.onClick ClickedIncrement
                , buttonClass
                , class "rounded-r place-self-end"
                ]
                [ Html.text "+" ]
            ]
        ]


viewGettingStarted : Html.Html msg_
viewGettingStarted =
    let
        scriptListItem : { description : List (Html.Html msg_), name : String } -> Html.Html msg_
        scriptListItem { description, name } =
            Html.li []
                (Ui.Code.view [] [ Html.text name ]
                    :: Html.text ": "
                    :: description
                )
    in
    Html.article [ class "mt-20" ]
        [ Html.h2
            [ Attr.id "getting-started"
            , class "text-xl font-bold"
            ]
            [ Html.text "Getting started 🏃" ]
        , Ui.Message.view Html.aside
            [ class "mt-4" ]
            [ Html.text "If you want to know more about the tools used here, go look at the "
            , Ui.Link.view Gen.Route.Tools [] [ Html.text "tools page" ]
            , Html.text "! This section is more about how to use this template."
            ]
        , Html.p [ class "mt-4" ]
            [ Html.text "If you just want to start coding:"
            , Ui.Code.viewBlock [ class "mt-2" ]
                [ "npm install"
                , "npm run dev"
                ]
            ]
        , Html.p [ class "mt-2" ]
            [ Html.text "If you want to know more about how it works, keep reading!"
            ]
        , Html.p [ class "mt-4" ]
            [ Html.text "Everything is set up to use scripts in "
            , Ui.Code.view [] [ Html.text "package.json" ]
            , Html.text ". You'll notice there are some scripts with "
            , Ui.Code.view [] [ Html.text ":" ]
            , Html.text " in their name. That's just a \"subcommand\" of another command, arranged this way to make the scripts more readable. Here's what the main scripts do:"
            , Html.ul [ class "list-disc list-inside mt-2 ml-4" ]
                [ scriptListItem
                    { description =
                        [ Html.text "Builds all of the Elm files, checks typescript types, bundles everything together, and generates CSS with tailwindcss. Use this command when publishing your app! By default, compiled files are under "
                        , Ui.Code.view [] [ Html.text "public/dist/" ]
                        , Html.text ", so that's what you want to deploy."
                        ]
                    , name = "build"
                    }
                , scriptListItem
                    { description =
                        [ Html.text "Uses "
                        , Ui.Code.view [] [ Html.text "run-pty" ]
                        , Html.text " to start a development server that will automatically listen to file changes. It will automatically rebuild Elm, typescript and tailwind, and apply hot module refreshes on your browser. It automatically generates code for "
                        , Ui.Code.view [] [ Html.text "elm-ts-interop" ]
                        , Html.text " and "
                        , Ui.Code.view [] [ Html.text "elm-spa" ]
                        , Html.text ". It also runs "
                        , Ui.Code.view [] [ Html.text "elm-review" ]
                        , Html.text " and typescript and Elm tests in watch mode. Basically, this is all you need when developing."
                        ]
                    , name = "dev"
                    }
                , scriptListItem
                    { description =
                        [ Html.text "Code generation is awesome! This command runs all of the code generation scripts. For now, it only generates code for "
                        , Ui.Code.view [] [ Html.text "elm-ts-interop" ]
                        , Html.text " and "
                        , Ui.Code.view [] [ Html.text "elm-spa" ]
                        , Html.text ", but I encourage you to create your own code generation scripts and add them here! You can also use other tools that generate code automatically, such as "
                        , Ui.Code.view [] [ Html.text "elm-graphql" ]
                        , Html.text ". If you want to create your own code generation scripts, I recommend using "
                        , Ui.Link.viewExternal { href = "https://package.elm-lang.org/packages/mdgriffith/elm-codegen/latest/" } [] [ Html.text "mdgriffith/elm-codegen" ]
                        , Html.text "."
                        ]
                    , name = "generate"
                    }
                , scriptListItem
                    { description =
                        [ Html.text "Ensures your code looks good by running "
                        , Ui.Code.view [] [ Html.text "elm-format" ]
                        , Html.text ", "
                        , Ui.Code.view [] [ Html.text "elm-review" ]
                        , Html.text ", "
                        , Ui.Code.view [] [ Html.text "eslint" ]
                        , Html.text ", "
                        , Ui.Code.view [] [ Html.text "prettier" ]
                        , Html.text " and "
                        , Ui.Code.view [] [ Html.text "stylelint" ]
                        , Html.text ". It also typechecks your typescript code."
                        ]
                    , name = "lint"
                    }
                , scriptListItem
                    { description =
                        [ Html.text "Runs all of your tests (make sure you write them!)."
                        ]
                    , name = "test"
                    }
                ]
            ]
        , Html.p [ class "mt-4" ]
            [ Html.text "You might want to start customizing the project to make it yours. Here are some good starting points:" ]
        , Html.ul [ class "list-disc list-inside mt-2 ml-4" ]
            [ Html.li []
                [ Html.text "Customize your elm-review rules. I usually just search for "
                , Ui.Code.view [] [ Html.text "elm-review" ]
                , Html.text " in "
                , Ui.Link.viewExternal { href = "https://package.elm-lang.org/" } [] [ Html.text "the package registry" ]
                , Html.text ", and go to town. I open multiple tabs, and read more about each rule. If it interests me, I add it to the project. Also, feel free to remove any of the rules that already come with the project. They're just there so that the review configuration is not empty."
                ]
            , Html.li [] [ Html.text "Customize your eslint, prettier and stylelint rules, and your typescript config." ]
            , Html.li []
                [ Html.text "Change "
                , Ui.Code.view [] [ Html.text "public/favicon.ico" ]
                , Html.text " to make it match your app better. If you change it and the browser still shows the old icon, don't worry! The old icon may be cached. Try using an anonymous tab or wait some time and try again."
                ]
            , Html.li []
                [ Html.text "Add some tags to the head of "
                , Ui.Code.view [] [ Html.text "public/index.html" ]
                , Html.text ". For example, you could add "
                , Ui.Link.viewExternal { href = "https://ogp.me" } [] [ Html.text "Open Graph tags" ]
                , Html.text " for better social previews, or you could include some other fonts."
                ]
            , Html.li []
                [ Html.text "Change the tailwind configuration to have your own colors, spacings, fonts, etc"
                ]
            , Html.li []
                [ Html.text "Change the templates in "
                , Ui.Code.view [] [ Html.text ".elm-spa/templates" ]
                , Html.text " if you need some more elaborate ones."
                ]
            , Html.li [] [ Html.text "Eject more things from elm-spa, for things like authorization, or to customize your 404 page." ]
            , Html.li []
                [ Html.text "Add or remove scripts from "
                , Ui.Code.view [] [ Html.text "run-pty.json" ]
                , Html.text "."
                ]
            ]
        ]



-- PORT SUBSCRIPTION


{-| Subscribe to messages from Typescript
-}
toElmSubscription : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscription _ =
    Nothing
