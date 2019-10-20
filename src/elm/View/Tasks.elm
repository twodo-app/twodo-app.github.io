module View.Tasks exposing (section)

-- Imports ---------------------------------------------------------------------
import Data.Project exposing (Project)
import Data.Task exposing (Task)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Intent(..))
import Ui.Colour exposing (Colour)
import Ui.Button
import Ui.Theme exposing (Theme)

-- Types -----------------------------------------------------------------------
--
type alias Data a =
  { a
  | focusedTask : Maybe Task
  , tasks : List Task
  }

-- Functions -------------------------------------------------------------------
--
section : Theme -> Maybe (Data a) -> Html Intent
section theme data =
  case data of
    Just d ->
      tasks theme d

    Nothing ->
      empty theme

--
empty : Theme -> Html Intent
empty theme =
  Html.section 
    [ id "tasks", class "p-4 flex items-center justify-center", Ui.Colour.toBackground theme.background.one]
    [ Html.span 
      [ class "mx-4 font-bold text-2xl", Ui.Colour.toText theme.text.muted ]
      [ Html.text "Select a project to view your active tasks." ]
    ]

--
tasks : Theme -> Data a -> Html Intent
tasks theme data =
 Html.section
    [ id "tasks", class "p-4", Ui.Colour.toBackground theme.background.one ]
    [
    ]