module Main exposing (..)

import Browser
import Html exposing (Html, div, text, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

type alias Model =
  { content : String
  }

init : Model
init =
  { content = "" }

view : Model -> Html String
view m =
    div []
    [ input [ placeholder "Text: ", value m.content] []
    , div [] [ text (m.content) ]
    ]

type Msg = String

update msg model = 
    { model | content = msg }

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- entrypoint
main =
  Browser.sandbox
    { init = init
    , update = update
    , view = view
    }



