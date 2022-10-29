module Main exposing (Model, Msg, main)

import Browser
import Browser.Dom
import Browser.Navigation as Nav exposing (Key)
import Effect
import Gen.Model
import Gen.Msg
import Gen.Pages as Pages
import Gen.Route as Route
import InteropDefinitions
import InteropPorts
import Json.Decode as Decode
import Pages.Home_
import Request
import Shared
import Task
import Url exposing (Url)
import View


type alias Model =
    { url : Url
    , key : Key
    , shared : Shared.Model
    , page : Pages.Model
    }



-- INIT


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | Shared Shared.Msg
    | Page Pages.Msg
    | GotToElmPort (Result Decode.Error InteropDefinitions.ToElm)


main : Program Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- UPDATE


init : Decode.Value -> Url -> Key -> ( Model, Cmd Msg )
init jsonFlags url key =
    let
        ( shared, sharedCmd ) =
            Shared.init (Request.create () url key) (InteropPorts.decodeFlags jsonFlags)

        ( page, effect ) =
            Pages.init (Route.fromUrl url) shared url key
    in
    ( { url = url, key = key, shared = shared, page = page }
    , Cmd.batch
        [ Cmd.map Shared sharedCmd
        , Effect.toCmd ( Shared, Page ) effect
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl url ->
            if url.path /= model.url.path then
                let
                    ( page, effect ) =
                        Pages.init (Route.fromUrl url) model.shared url model.key
                in
                ( { model | url = url, page = page }
                , Cmd.batch
                    [ Effect.toCmd ( Shared, Page ) effect
                    , Browser.Dom.setViewport 0 0
                        |> Task.perform (\_ -> NoOp)
                    ]
                )

            else
                ( { model | url = url }
                , case url.fragment of
                    Just fragment ->
                        InteropDefinitions.ScrollTo { querySelector = "#" ++ fragment }
                            |> InteropPorts.fromElm

                    Nothing ->
                        Cmd.none
                )

        ClickedLink (Browser.Internal url) ->
            ( model
            , Nav.pushUrl model.key (Url.toString url)
            )

        ClickedLink (Browser.External url) ->
            ( model
            , Nav.load url
            )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update (Request.create () model.url model.key) sharedMsg model.shared

                ( page, effect ) =
                    Pages.init (Route.fromUrl model.url) shared model.url model.key
            in
            if page == Gen.Model.Redirecting_ then
                ( { model | shared = shared, page = page }
                , Cmd.batch
                    [ Cmd.map Shared sharedCmd
                    , Effect.toCmd ( Shared, Page ) effect
                    ]
                )

            else
                ( { model | shared = shared }
                , Cmd.map Shared sharedCmd
                )

        Page pageMsg ->
            let
                ( page, effect ) =
                    Pages.update pageMsg model.page model.shared model.url model.key
            in
            ( { model | page = page }
            , Effect.toCmd ( Shared, Page ) effect
            )

        GotToElmPort (Ok toElm) ->
            ( model
            , Cmd.batch
                [ Shared.toElmSubscriptions toElm
                    |> Maybe.map Shared
                    |> Maybe.withDefault NoOp
                    |> Task.succeed
                    |> Task.perform identity
                , toElmSubscription model.page toElm
                    |> Maybe.map Page
                    |> Maybe.withDefault NoOp
                    |> Task.succeed
                    |> Task.perform identity
                ]
            )

        GotToElmPort (Err error) ->
            ( model
            , Decode.errorToString error
                |> InteropDefinitions.Alert
                |> InteropPorts.fromElm
            )



-- VIEW


toElmSubscription : Pages.Model -> InteropDefinitions.ToElm -> Maybe Gen.Msg.Msg
toElmSubscription page toElm =
    case page of
        Gen.Model.Redirecting_ ->
            Nothing

        Gen.Model.Home_ _ _ ->
            Pages.Home_.toElmSubscription toElm
                |> Maybe.map Gen.Msg.Home_

        Gen.Model.Tools _ _ ->
            Nothing

        Gen.Model.NotFound _ ->
            Nothing



-- SUBSCRIPTIONS


view : Model -> Browser.Document Msg
view model =
    Pages.view model.page model.shared model.url model.key
        |> View.map Page
        |> View.toBrowserDocument



-- UTILS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Pages.subscriptions model.page model.shared model.url model.key
            |> Sub.map Page
        , Shared.subscriptions (Request.create () model.url model.key) model.shared
            |> Sub.map Shared
        , Sub.map GotToElmPort InteropPorts.toElm
        ]
