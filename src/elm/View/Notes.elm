module View.Notes exposing (section)

-- Imports ---------------------------------------------------------------------
import Data.Project exposing (Project)
import Data.Task exposing (Task)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Intent(..))
import Ui.Colour exposing (Colour)
import Ui.Button as Button
import Ui.Theme exposing (Theme)

-- Types -----------------------------------------------------------------------
--
type alias Data =
  {
  }

-- Functions -------------------------------------------------------------------
--
section : Theme -> Data -> Html Intent
section theme data =
  Html.section
    [ id "notes", class "p-4 flex items-center justify-center", Ui.Colour.toBackground theme.background.base ]
    [ Html.span 
      [ class "mx-4 font-bold text-2xl", Ui.Colour.toText theme.text.muted ]
      [ Html.text "Select a task to begin taking notes." ]
    ]