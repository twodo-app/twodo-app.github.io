module Main exposing (main)

-- Imports ---------------------------------------------------------------------
import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events

-- Main ------------------------------------------------------------------------
main : Program () Model Msg
main = 
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- Model -----------------------------------------------------------------------
--
type alias Model =
  {
  }

--
initialModel : Model
initialModel =
  {
  }

--
initialCmd : Cmd Msg
initialCmd =
  Cmd.batch
    [
    ]

--
init : () -> ( Model, Cmd Msg )
init flags =
  ( initialModel
  , initialCmd
  )

-- Update ----------------------------------------------------------------------
--
type Msg
  = NoOp

--
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model
      , Cmd.none
      ) 

-- View ------------------------------------------------------------------------
--
view : Model -> Html Msg
view model =
  Html.div [ Html.Attributes.id "app" ]
    [ Html.div [ Html.Attributes.class "bg-gray-100" ] [ Html.text "days" ]
    , Html.div [ Html.Attributes.class "bg-gray-200" ] [ Html.text "tasks" ]
    , Html.div [ Html.Attributes.class "bg-gray-300" ] [ Html.text "current task" ] 
    ]

-- Subscriptions ---------------------------------------------------------------
--
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [
    ]