{- This app is the basic Ace editor app.
-}

import Html exposing (..)
import Html
import Html.Events exposing (..)
import Ace

main =
  Html.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }

-- MODEL


type alias Model =
  { source: String
  , theme: String
  }


init : (Model, Cmd Msg)
init =
  ({ source = "It's a source!", theme = "ambiance" }, Cmd.none)



-- UPDATE


type Msg
  = UpdateSource String
  | SetThemeTo String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let
    newModel =
      case msg of
        UpdateSource source ->
          { model | source = source }
        SetThemeTo theme ->
          { model | theme = theme }

  in
    (newModel, Cmd.none)


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
      , Ace.theme model.theme
      ] []
    , Html.button [ onClick (SetThemeTo "monokai") ] [ Html.text "Set 'monokai' theme" ]
    , Html.button [ onClick (SetThemeTo "cobalt") ] [ Html.text "Set 'cobalt' theme" ]
    , Html.button [ onClick (SetThemeTo "ambiance") ] [ Html.text "Revert 'ambiance' theme" ]
    , Html.button [ onClick (UpdateSource "Blank source") ] [ Html.text "Reset source" ]
    , Html.text model.source
    ]
