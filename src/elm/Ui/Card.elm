module Ui.Card exposing
  ( ..
  )

-- Imports ---------------------------------------------------------------------
import Ui.Colour exposing (Colour)
import Ui.Theme exposing (Theme)
import Html exposing (Html, Attribute)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- View ------------------------------------------------------------------------
--
rounded : Theme -> Bool -> String -> List (Html msg) -> Html msg
rounded theme focused title children =
  Html.div
    [ class "h-32 p-4 m-4 shadow"
    , class <| "hover:bg-" ++ Ui.Colour.toString theme.accent
    , class <| if focused then
        "rounded-l-xl pl-8 border-r-8 border-" ++ Ui.Colour.toString theme.primary
      else
        "rounded-lg"
    , Ui.Colour.toBackground theme.background.base
    ]
    [ Html.h1
      [ class "text-xl font-bold", Ui.Colour.toText theme.text.base ]
      [ Html.text title ]
    , Html.div
      [ class "text-sm font-bold", Ui.Colour.toText theme.text.muted ]
      children
    ]
