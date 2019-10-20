module View.Projects exposing (section)

-- Imports ---------------------------------------------------------------------
import Data.Project exposing (Project)
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
  | focusedProject : Maybe Project
  , projects : List Project
  }

-- Functions -------------------------------------------------------------------
--
section : Theme -> Data a -> Html Intent
section theme data =
  Html.section 
    [ id "projects", class "p-4", Ui.Colour.toBackground theme.background.two ]
    [ Html.ol
      [ class "overflow-y-scroll" ]
      ( projects theme data )
    , Html.div
      [ class "flex items-center justify-center shadow-top" ]
      [ Ui.Button.circular [ onClick AddProject ] theme.primary "+"
      , Ui.Button.circular [ onClick RemoveProject ] Ui.Colour.red "-" ]
    ]

--
projects : Theme -> Data a -> List (Html Intent)
projects theme data =
  data.projects |> List.map (\project ->
    let 
      isFocused = data.focusedProject 
        |> Maybe.map (.id >> (==) project.id)
        |> Maybe.withDefault False
    in
    Html.li
      [ onClick <| FocusProject project ]
      [ Data.Project.view theme isFocused project ]
  )