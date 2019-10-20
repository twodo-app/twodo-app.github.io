module Data.Task exposing
  ( Task
  , view
  , encode, decoder
  )

-- Imports ---------------------------------------------------------------------
import Html exposing (Html, Attribute)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder)
import Json.Encode exposing (Value)

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
  Json.Encode.object
    [
    ]

decoder : Decoder Task
decoder =
  Json.Decode.succeed {}