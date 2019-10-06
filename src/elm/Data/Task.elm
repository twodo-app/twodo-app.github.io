module Data.Task exposing
  ( ..
  )

-- Imports ---------------------------------------------------------------------
import Html exposing (Html, Attribute)
import Html.Attributes as Attr
import Html.Events as Event
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)

-- Types -----------------------------------------------------------------------
--
type alias Task =
  {
  }

-- Functions -------------------------------------------------------------------


-- View ------------------------------------------------------------------------
view : Task -> Html msg
view task =
  Html.div [ ]
    [
    ]

-- Json ------------------------------------------------------------------------
--
encode : Task -> Value
encode task =
  Encode.object
    [
    ]

decoder : Decoder Task
decoder =
  Decode.succeed {}