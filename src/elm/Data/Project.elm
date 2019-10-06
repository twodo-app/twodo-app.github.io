module Data.Project exposing
  ( Project
  , empty, new
  , ProjectSelection -- Type constructors are *not* exposed for this type.
  , isSelected, select, deselect, toggleSelection
  , view
  , encode, decoder
  )

-- Imports ---------------------------------------------------------------------
import Data.Task exposing (Task)
import Html exposing (Html, Attribute)
import Html.Attributes as Attr
import Html.Events as Event
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Ui.Colour exposing (Colour)
import Ui.Theme exposing (Theme)

-- Types -----------------------------------------------------------------------
-- A project represents a collection of tasks grouped together by some common
-- theme. 
type alias Project =
  { tasks : List Task
  , title : String
  , startDate : String
  , endDate : String
  }

-- Essentially this is a specialised version of the `Maybe` type. It represents
-- a project that may or may not be selected by the user and is identified by
-- an `Int`. The Model uses this, for example, to keep track of the currently
-- active project (or perhaps the user hasn't selected or created any project(s)
-- at all).
type ProjectSelection
  = ProjectSelection Int
  | None

-- Functions -------------------------------------------------------------------
-- The empty project. Ready for an amibitious user to come and edit this with
-- their own project details!
empty : Project
empty =
  { tasks = []
  , title = "Your next big project."
  , startDate = "Now"
  , endDate = "and Forever..."
  }

-- Create a new project from scratch by supplying a title, start date, and end
-- date. The task list starts empty, for obvious reasons.
new : String -> String -> String -> Project
new title startDate endDate =
  { tasks = []
  , title = title
  , startDate = startDate
  , endDate = endDate
  }

-- Determine if an `Int` matches a `ProjectSelection`. This is akin to doing:
--
--   Maybe.map ((==) i) selectedProject
--     |> Maybe.withDefault False
--
-- But this has the benefit of having a nice descriptive name and a clear domain
-- that it operates on!
isSelected : Int -> ProjectSelection -> Bool
isSelected i selectedProject =
  case selectedProject of
    ProjectSelection n ->
      i == n

    None ->
      False

-- Given an `Int`, create a new `ProjectSelection`. I've found using this helper
-- function rather than exposing the `ProjectSelection Int` constructor makes our
-- code much more literate. See `toggleSelection` below for an example.
select : Int -> ProjectSelection
select n =
  ProjectSelection n

-- For the same reason as `select` above, we expose the `deselect` function as a
-- nicer way of constructing a `ProjectSelection` with a value of `None`.
deselect : ProjectSelection
deselect =
  None

-- Given an `Int` i and a `ProjectSelection` either toggle that selection off or
-- create a new selection with the value of i.
toggleSelection : Int -> ProjectSelection -> ProjectSelection
toggleSelection i selectedProject =
  if isSelected i selectedProject then deselect else select i

-- View ------------------------------------------------------------------------
--
view : Theme -> Project -> Bool -> Html msg
view theme project active =
  Html.div (classes theme active)
    [ Html.h1 [ Attr.class "text-xl font-bold", Ui.Colour.toText theme.text.base ] 
      [ Html.text project.title ]
    , Html.div [ Attr.class "text-sm font-bold", Ui.Colour.toText theme.text.muted ]
      [ Html.p [] [ Html.text project.startDate ]
      , Html.p [] [ Html.text project.endDate ]
      ]
    ]

--
classes : Theme -> Bool -> List (Attribute msg)
classes theme isActive =
  [ Attr.class "h-32 p-4 m-4 shadow"
  , Attr.class <| if isActive then 
      "rounded-l-xl pl-8 border-r-8 border-" ++ Ui.Colour.toString theme.primary
    else 
      " rounded-lg"
  , Ui.Colour.toBackground theme.background.base
  , Attr.class <| "hover:bg-" ++ Ui.Colour.toString theme.accent
  ]

-- Json ------------------------------------------------------------------------
--
encode : Project -> Value
encode project =
  Encode.object
    [ ( "tasks", Encode.list Data.Task.encode project.tasks )
    , ( "title", Encode.string project.title ) 
    , ( "startDate", Encode.string project.startDate )
    , ( "endDate", Encode.string project.endDate )
    ]

--
decoder : Decoder Project
decoder =
  Decode.map4 Project
    (Decode.field "tasks" <| Decode.list Data.Task.decoder)
    (Decode.field "title" Decode.string)
    (Decode.field "startDate" Decode.string)
    (Decode.field "endDate" Decode.string)