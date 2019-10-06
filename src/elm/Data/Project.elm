module Data.Project exposing
  ( ..
  )

-- Imports ---------------------------------------------------------------------
import Data.Task exposing (Task)
import Html exposing (Html, Attribute)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value)

-- Types -----------------------------------------------------------------------
type alias Day =
  { tasks : List Task
  }

-- Functions -------------------------------------------------------------------


-- View ------------------------------------------------------------------------
view : Day -> Html msg
view day =
  let
    classes : Attribute msg
    classes =
      Html.Attributes.class "p-4 m-4 rounded-lg bg-gray-200"
  in
  Html.div [ classes ]
    []

-- Json ------------------------------------------------------------------------