module Pages.Tools exposing (page)

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


page : Shared.Model -> Request.With Params -> Page
page shared _ =
    Page.static
        { view = view shared
        }


view : Shared.Model -> View msg
view shared =
    let
        toolListItem : { name : String, link : String, description : List (Html.Html msg) } -> Html.Html msg
        toolListItem { name, link, description } =
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
                            { name = "elm"
                            , link = "https://elm-lang.org"
                            , description = [ Html.text "If you're here, I probably don't need to tell you why Elm is great 😉" ]
                            }
                        , toolListItem
                            { name = "typescript"
                            , link = "https://www.typescriptlang.org"
                            , description = [ Html.text "Since Elm can't do everything in the web, we need to use some Javascript. Even though it's not perfect, Typescript can help us (much more than Javascript) build safer apps." ]
                            }
                        , toolListItem
                            { name = "elm-ts-interop"
                            , link = "https://elm-ts-interop.com"
                            , description = [ Html.text "If we didn't have this, we'd have problems interfacing Elm and Typescript. It's a great tool, and helps make sure that the types are correct." ]
                            }
                        , toolListItem
                            { name = "elm-tooling"
                            , link = "https://elm-tooling.github.io/elm-tooling-cli/"
                            , description = [ Html.text "To help us install other elm tools." ]
                            }
                        , toolListItem
                            { name = "elm-format"
                            , link = "https://github.com/avh4/elm-format"
                            , description = [ Html.text "To format our Elm code. Almost all of the Elm community uses elm-format, so any code is immediately recognizable." ]
                            }
                        , toolListItem
                            { name = "elm-review"
                            , link = "https://package.elm-lang.org/packages/jfmengels/elm-review/latest/"
                            , description = [ Html.text "To keep our code sane. It can help us do so many things, such as enforcing a coding style, or making sure we don't use deprecated functions." ]
                            }
                        , toolListItem
                            { name = "elm-spa"
                            , link = "https://www.elm-spa.dev"
                            , description =
                                [ Html.text "To help us generate new pages. It can be a pain to do this manually (but you should probably build at least one app manually, following "
                                , Ui.Link.viewExternal { href = "https://github.com/rtfeldman/elm-spa-example" } [] [ Html.text "elm-spa-example" ]
                                , Html.text ". It's a great way to learn Elm!)"
                                ]
                            }
                        , toolListItem
                            { name = "elm-test-rs"
                            , link = "https://github.com/mpizenberg/elm-test-rs"
                            , description = [ Html.text "To run our elm tests." ]
                            }
                        , toolListItem
                            { name = "vitest"
                            , link = "https://vitest.dev"
                            , description = [ Html.text "To run our typescript tests, if there are any." ]
                            }
                        , toolListItem
                            { name = "eslint"
                            , link = "https://eslint.org"
                            , description = [ Html.text "Pretty much the same as elm-review, but for typescript." ]
                            }
                        , toolListItem
                            { name = "prettier"
                            , link = "https://prettier.io"
                            , description = [ Html.text "Pretty much the same as elm-format, but for typescript." ]
                            }
                        , toolListItem
                            { name = "stylelint"
                            , link = "https://stylelint.io"
                            , description = [ Html.text "Pretty much the same as elm-review and elm-format, but for css. We shouldn't need this too much, as we're using tailwindcss" ]
                            }
                        , toolListItem
                            { name = "tailwindcss"
                            , link = "https://tailwindcss.com"
                            , description =
                                [ Html.text "This helps us create beautiful UIs, very fast. It's a great tool, and I highly recommend it. I suggest reading "
                                , Ui.Link.viewExternal { href = "https://max.hn/thoughts/using-tailwind-css-in-elm-and-vscode" }
                                    []
                                    [ Html.text "Using Tailwind CSS in Elm and VSCode" ]
                                , Html.text " if you're using VSCode. You can get tailwind autocompletion, linting and hover previews in Elm!"
                                ]
                            }
                        , toolListItem
                            { name = "run-pty"
                            , link = "https://github.com/lydell/run-pty"
                            , description = [ Html.text "Is a tool to run multiple commands in parallel in the terminal. It's what allows us to keep an eye on tests, linters and build statuses all at the same time." ]
                            }
                        , toolListItem
                            { name = "elm-watch"
                            , link = "https://lydell.github.io/elm-watch/"
                            , description =
                                [ Html.text "Is what we're using to build our Elm app. It's almost a clone of "
                                , Ui.Code.view [] [ Html.text "elm make" ]
                                , Html.text ", but with a watch option, and the ability to postprocess the generated Elm code (we use this ability to minify the code for production)"
                                ]
                            }
                        , toolListItem
                            { name = "esbuild"
                            , link = "https://esbuild.github.io"
                            , description = [ Html.text "Is what we're using to build the Typescript part of the app." ]
                            }
                        , toolListItem
                            { name = "live-server"
                            , link = "http://tapiov.net/live-server/"
                            , description = [ Html.text "Is what we're using to serve the app for development." ]
                            }
                        , toolListItem
                            { name = "GitHub Actions"
                            , link = "https://github.com/features/actions"
                            , description =
                                [ Html.text "Helps us make sure our code is always correct in github. There's already a config file in "
                                , Ui.Code.view [] [ Html.text ".github/workflows/ci.yml" ]
                                , Html.text ", which already runs tests, linters, and builds the code, with some nice caching. You should also customize it to make it yours, such as adding a deploy script."
                                ]
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
