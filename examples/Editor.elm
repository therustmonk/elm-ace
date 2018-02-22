{- This app is the basic Ace editor app. -}


module Main exposing (..)

import Ace
import Html exposing (..)
import Html.Events exposing (..)


main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { source : String
    , theme : String
    , annotations : String
    }


blankSource =
    "-- It's a source!\nlocal x = 1"


init : ( Model, Cmd Msg )
init =
    ( { source = blankSource, theme = "ambiance", annotations = "[]" }, Cmd.none )



-- UPDATE


type Msg
    = UpdateSource String
    | SetThemeTo String
    | AddAnnotation
    | RemoveAnnotation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newModel =
            case msg of
                UpdateSource source ->
                    { model | source = source }

                SetThemeTo theme ->
                    { model | theme = theme }
                
                AddAnnotation ->
                    {model | annotations = "[{\"row\":1,\"column\":2,\"type\":\"error\",\"text\":\"Some error.\"}]"}

                RemoveAnnotation ->
                    {model | annotations = "[]"}
    in
    ( newModel, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Ace.toHtml
            [ Ace.onSourceChange UpdateSource
            , Ace.value model.source
            , Ace.mode "lua"
            , Ace.theme model.theme
            , Ace.enableBasicAutocompletion True
            , Ace.enableLiveAutocompletion True
            , Ace.enableSnippets True
            , Ace.tabSize 2
            , Ace.useSoftTabs False
            , Ace.extensions [ "language_tools" ]
            , Ace.annotations model.annotations
            ]
            []
        , Html.button [ onClick (SetThemeTo "monokai") ] [ Html.text "Set 'monokai' theme" ]
        , Html.button [ onClick (SetThemeTo "cobalt") ] [ Html.text "Set 'cobalt' theme" ]
        , Html.button [ onClick (SetThemeTo "ambiance") ] [ Html.text "Revert 'ambiance' theme" ]
        , Html.button [ onClick (UpdateSource blankSource) ] [ Html.text "Reset source" ]
        , Html.button [ onClick AddAnnotation ] [ Html.text "Add Annotation" ]
        , Html.button [ onClick RemoveAnnotation ] [ Html.text "Remove Annotations" ]
        , Html.text model.source
        ]
