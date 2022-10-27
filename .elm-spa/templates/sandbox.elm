module Pages.{{module}} exposing (Model, Msg, page, toElmSubscription)

import Gen.Params.{{module}} exposing (Params)
import Page
import Request
import Shared
import View exposing (View)
import InteropDefinitions


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> Model
update msg model =
    case msg of
        ReplaceMe ->
            model



-- VIEW


view : Model -> View Msg
view model =
    View.placeholder "{{module}}"



-- PORT SUBSCRIPTION

toElmSubscription : InteropDefinitions.ToElm -> Maybe Msg
toElmSubscription toElm =
    case toElm of
        _ ->
            Nothing
