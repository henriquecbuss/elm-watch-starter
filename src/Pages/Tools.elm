module Pages.Tools exposing (page)

{-| Tools

@docs page

-}

import Gen.Params.Tools exposing (Params)
import Gen.Route
import Html
import Html.Attributes exposing (class)
import Page exposing (Page)
import Request
import Shared
import Ui.Code
import Ui.Header
import Ui.Link
import Ui.Message
import View exposing (View)


{-| This is how elm-spa knows what to do with our app
-}
page : Shared.Model -> Request.With Params -> Page
page shared _ =
    Page.static
        { view = view shared
        }


view : Shared.Model -> View msg_
view shared =
    let
        toolListItem : { description : List (Html.Html msg_), link : String, name : String } -> Html.Html msg_
        toolListItem { description, link, name } =
            Html.li []
                (Ui.Link.viewExternal { href = link } [] [ Ui.Code.view [] [ Html.text name ] ]
                    :: Html.text ": "
                    :: description
                )
    in
    { title = "tools"
    , body =
        [ Ui.Header.view
        , Html.main_ [ class "container mx-auto px-4 pb-40" ]
            [ Html.section []
                [ Html.h2 [ class "text-4xl font-bold" ] [ Html.text "Tools 🛠️️" ]
                , Html.p [ class "mt-4" ]
                    [ Html.text "In order to make development easier, this project uses quite a lot of tools. The main goal is to make everything type-safe, and have linting rules for everything. That's why we use typescript, eslint, prettier, etc." ]
                , Ui.Message.view Html.aside
                    [ class "mt-4" ]
                    [ Html.text "If you're new to Elm, or to the frontend world in general, don't be scared by the number of tools! They're only here to help you. If you feel like this is too much, I'd recommend starting with a simpler setup, such as a barebones Elm app, or maybe just with "
                    , Ui.Code.view [] [ Html.text "elm-spa" ]
                    , Html.text "."
                    ]
                , Html.section []
                    [ Html.h3 [ class "mt-4" ] [ Html.text "Here are the tools used in this project:" ]
                    , Html.ul [ class "mt-2 ml-4 list-disc list-inside" ]
                        [ toolListItem
                            { description = [ Html.text "If you're here, I probably don't need to tell you why Elm is great 😉" ]
                            , link = "https://elm-lang.org"
                            , name = "elm"
                            }
                        , toolListItem
                            { description = [ Html.text "Since Elm can't do everything in the web, we need to use some Javascript. Even though it's not perfect, Typescript can help us (much more than Javascript) build safer apps." ]
                            , link = "https://www.typescriptlang.org"
                            , name = "typescript"
                            }
                        , toolListItem
                            { description = [ Html.text "If we didn't have this, we'd have problems interfacing Elm and Typescript. It's a great tool, and helps make sure that the types are correct." ]
                            , link = "https://elm-ts-interop.com"
                            , name = "elm-ts-interop"
                            }
                        , toolListItem
                            { description = [ Html.text "To help us install other elm tools." ]
                            , link = "https://elm-tooling.github.io/elm-tooling-cli/"
                            , name = "elm-tooling"
                            }
                        , toolListItem
                            { description = [ Html.text "To format our Elm code. Almost all of the Elm community uses elm-format, so any code is immediately recognizable." ]
                            , link = "https://github.com/avh4/elm-format"
                            , name = "elm-format"
                            }
                        , toolListItem
                            { description = [ Html.text "To keep our code sane. It can help us do so many things, such as enforcing a coding style, or making sure we don't use deprecated functions." ]
                            , link = "https://package.elm-lang.org/packages/jfmengels/elm-review/latest/"
                            , name = "elm-review"
                            }
                        , toolListItem
                            { description =
                                [ Html.text "To help us generate new pages. It can be a pain to do this manually (but you should probably build at least one app manually, following "
                                , Ui.Link.viewExternal { href = "https://github.com/rtfeldman/elm-spa-example" } [] [ Html.text "elm-spa-example" ]
                                , Html.text ". It's a great way to learn Elm!)"
                                ]
                            , link = "https://www.elm-spa.dev"
                            , name = "elm-spa"
                            }
                        , toolListItem
                            { description = [ Html.text "To run our elm tests." ]
                            , link = "https://github.com/mpizenberg/elm-test-rs"
                            , name = "elm-test-rs"
                            }
                        , toolListItem
                            { description = [ Html.text "To run our typescript tests, if there are any." ]
                            , link = "https://vitest.dev"
                            , name = "vitest"
                            }
                        , toolListItem
                            { description = [ Html.text "Pretty much the same as elm-review, but for typescript." ]
                            , link = "https://eslint.org"
                            , name = "eslint"
                            }
                        , toolListItem
                            { description = [ Html.text "Pretty much the same as elm-format, but for typescript." ]
                            , link = "https://prettier.io"
                            , name = "prettier"
                            }
                        , toolListItem
                            { description = [ Html.text "Pretty much the same as elm-review and elm-format, but for css. We shouldn't need this too much, as we're using tailwindcss" ]
                            , link = "https://stylelint.io"
                            , name = "stylelint"
                            }
                        , toolListItem
                            { description =
                                [ Html.text "This helps us create beautiful UIs, very fast. It's a great tool, and I highly recommend it. I suggest reading "
                                , Ui.Link.viewExternal { href = "https://max.hn/thoughts/using-tailwind-css-in-elm-and-vscode" }
                                    []
                                    [ Html.text "Using Tailwind CSS in Elm and VSCode" ]
                                , Html.text " if you're using VSCode. You can get tailwind autocompletion, linting and hover previews in Elm!"
                                ]
                            , link = "https://tailwindcss.com"
                            , name = "tailwindcss"
                            }
                        , toolListItem
                            { description = [ Html.text "Is a tool to run multiple commands in parallel in the terminal. It's what allows us to keep an eye on tests, linters and build statuses all at the same time." ]
                            , link = "https://github.com/lydell/run-pty"
                            , name = "run-pty"
                            }
                        , toolListItem
                            { description =
                                [ Html.text "Is what we're using to build our Elm app. It's almost a clone of "
                                , Ui.Code.view [] [ Html.text "elm make" ]
                                , Html.text ", but with a watch option, and the ability to postprocess the generated Elm code (we use this ability to minify the code for production)"
                                ]
                            , link = "https://lydell.github.io/elm-watch/"
                            , name = "elm-watch"
                            }
                        , toolListItem
                            { description = [ Html.text "Is what we're using to build the Typescript part of the app." ]
                            , link = "https://esbuild.github.io"
                            , name = "esbuild"
                            }
                        , toolListItem
                            { description = [ Html.text "Is what we're using to serve the app for development." ]
                            , link = "http://tapiov.net/live-server/"
                            , name = "live-server"
                            }
                        , toolListItem
                            { description =
                                [ Html.text "Helps us make sure our code is always correct in github. There's already a config file in "
                                , Ui.Code.view [] [ Html.text ".github/workflows/ci.yml" ]
                                , Html.text ", which already runs tests, linters, and builds the code, with some nice caching. You should also customize it to make it yours, such as adding a deploy script."
                                ]
                            , link = "https://github.com/features/actions"
                            , name = "GitHub Actions"
                            }
                        ]
                    ]
                , Ui.Message.view Html.aside
                    [ class "mt-8" ]
                    [ Html.p [] [ Html.text "Remember the counter in the home page? This is it's value: " ]
                    , Html.div [ class "text-blue-elm text-lg font-bold my-2 ml-8" ] [ Html.text (String.fromInt shared.counter) ]
                    , Html.p []
                        [ Html.text "(This is just an example to show how to use shared state. Go back to the "
                        , Ui.Link.view Gen.Route.Home_ [] [ Html.text "home page" ]
                        , Html.text " and change the counter, then come back here and see the new value)"
                        ]
                    ]
                ]
            ]
        ]
    }
