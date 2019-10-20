module Data.Project exposing
  ( Project
  , empty, new
  , view
  , encode, decoder
  )

-- Imports ---------------------------------------------------------------------
import Data.Task exposing (Task)
import Html exposing (Html)
import Json.Decode exposing (Decoder)
import Json.Encode exposing (Value)
import Ui.Card
import Ui.Theme exposing (Theme)

-- Types -----------------------------------------------------------------------
-- A project represents a collection of tasks grouped together by some common
-- theme. 
type alias Project =
  { id : Int
  , tasks : List Task
  , focusedTask : Maybe Task
  , title : String
  , startDate : String
  , endDate : String
  }

-- Functions -------------------------------------------------------------------
-- The empty project. Ready for an amibitious user to come and edit this with
-- their own project details!
empty : Int -> Project
empty id =
  { id = id
  , tasks = []
  , focusedTask = Nothing
  , title = "Your next big project."
  , startDate = "Now"
  , endDate = "..."
  }

-- Create a new project from scratch by supplying a title, start date, and end
-- date. The task list starts empty, for obvious reasons.
new : Int -> String -> String -> String -> Project
new id title startDate endDate =
  { id = id
  , tasks = []
  , focusedTask = Nothing
  , title = title
  , startDate = startDate
  , endDate = endDate
  }


-- View ------------------------------------------------------------------------
--
view : Theme -> Bool -> Project -> Html msg
view theme isFocused project =
  Ui.Card.rounded theme isFocused project.title
    [ Html.p [] [ Html.text project.startDate ]
    , Html.p [] [ Html.text project.endDate ]
    ]

-- Json ------------------------------------------------------------------------
--
encode : Project -> Value
encode project =
  Json.Encode.object
    [ ( "id", Json.Encode.int project.id )
    , ( "tasks", Json.Encode.list Data.Task.encode project.tasks )
    , ( "title", Json.Encode.string project.title ) 
    , ( "startDate", Json.Encode.string project.startDate )
    , ( "endDate", Json.Encode.string project.endDate )
    ]

--
decoder : Decoder Project
decoder =
  Json.Decode.map6 Project
    (Json.Decode.field "id" Json.Decode.int)
    (Json.Decode.field "tasks" <| Json.Decode.list Data.Task.decoder)
    (Json.Decode.succeed Nothing)
    (Json.Decode.field "title" Json.Decode.string)
    (Json.Decode.field "startDate" Json.Decode.string)
    (Json.Decode.field "endDate" Json.Decode.string)