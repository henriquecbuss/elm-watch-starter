module Icons exposing (elm)

import Html
import Svg
import Svg.Attributes


elm : Html.Html msg
elm =
    Svg.svg
        [ Svg.Attributes.height "32"
        , Svg.Attributes.viewBox "0 0 600 600"
        ]
        [ Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "0,20 280,300 0,580"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "20,600 300,320 580,600"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "320,0 600,0 600,280"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "20,0 280,0 402,122 142,122"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "170,150 430,150 300,280"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "320,300 450,170 580,300 450,430"
            ]
            []
        , Svg.polygon
            [ Svg.Attributes.fill "currentColor"
            , Svg.Attributes.points "470,450 600,320 600,580"
            ]
            []
        ]
