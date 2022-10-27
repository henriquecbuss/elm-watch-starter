module Pages.Home_ exposing (Model, Msg, page, toElmSubscription)

import Effect exposing (Effect)
import Gen.Params.Home_ exposing (Params)
import Html
import Html.Events
import InteropDefinitions
import Page
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared _ =
    Page.advanced
        { init = init
        , update = update
        , view = view shared
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    {}


init : ( Model, Effect Msg )
init =
    ( {}, Effect.none )



-- UPDATE


type Msg
    = ClickedDecrement
    | ClickedIncrement


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ClickedDecrement ->
            ( model, Effect.fromShared Shared.Decrement )

        ClickedIncrement ->
            ( model, Effect.fromShared Shared.Increment )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared _ =
    { title = "Home"
    , body =
        [ Html.button [ Html.Events.onClick ClickedDecrement ] [ Html.text "-" ]
        , Html.text (String.fromInt shared.counter)
        , Html.button [ Html.Events.onClick ClickedIncrement ] [ Html.text "+" ]
        ]
    }



-- PORT SUBSCRIPTION


toElmSubscription : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscription toElm =
    case toElm of
        _ ->
            Nothing
