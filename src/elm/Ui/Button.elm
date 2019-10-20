module Ui.Button exposing
  ( ..
  )

-- Imports ---------------------------------------------------------------------
import Ui.Colour exposing (Colour)
import Html exposing (Html, Attribute)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- View ------------------------------------------------------------------------
-- This creates a perfectly circular button.
circular : List (Attribute msg) -> Colour -> String -> Html msg
circular attrs colour text =
  Html.button (attrs ++
    [ class "rounded-full h-10 w-10 m-2 flex items-center justify-center shadow"
    , class <| "bg-" ++ Ui.Colour.toString colour
    , class <| "hover:bg-" ++ (Ui.Colour.darken >> Ui.Colour.toString) colour
    ])
    [ Html.text text ]

-- This creates a pill shaped button that is at least twice as wide as it is
-- tall.
pill : List (Attribute msg) -> Colour -> String -> Html msg
pill attrs colour text =
  Html.button (attrs ++
    [ class "rounded-full h-10 min-w-20 m-2 flex items-center justify-center shadow"
    , class <| "bg-" ++ Ui.Colour.toString colour
    , class <| "hover:bg-" ++ (Ui.Colour.darken >> Ui.Colour.toString) colour
    ])
    [ Html.text text ]

-- This creates a button with slightly rounded edges.
rounded : List (Attribute msg) -> Colour -> String -> Html msg
rounded attrs colour text =
  Html.button (attrs ++
    [ class "rounded m-2 flex items-center justify-center shadow"
    , class <| "bg-" ++ Ui.Colour.toString colour
    , class <| "hover:bg-" ++ (Ui.Colour.darken >> Ui.Colour.toString) colour
    ])
    [ Html.text text ]
