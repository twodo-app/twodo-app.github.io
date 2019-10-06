module Main exposing (main)

-- Imports ---------------------------------------------------------------------
import Browser
import Ui.Button
import Ui.Colour exposing (Colour)
import Ui.Theme exposing (Theme)
import Data.Project as Project exposing (Project, ProjectSelection)
import Data.Task as Task exposing (Task)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event

-- Main ------------------------------------------------------------------------
-- For now Flags is an alias for an empty tuple, commonly referred to as _the_
-- unit type (although there are many unit types...). This exists so that when
-- we do eventually want to introduce flags into our application, we don't have 
-- to make so many changes.
type alias Flags
  = ()


main : Program Flags Model Msg
main = 
  Browser.element
    { init = init
    , update = update
    -- Our view button can only return values of type `Html Intent`. This makes
    -- sense because whenever the user interacts with our view, we always want
    -- something to happen. We need to map our `Html Intent` value to a
    -- `Html Msg` value in order to have a single "top level" msg type. Don't
    -- worry too much about this.
    , view = view >> Html.map Intent
    , subscriptions = subscriptions
    }

-- Model -----------------------------------------------------------------------
--
type alias Model =
  { projects : List Project
  , activeProject : ProjectSelection
  , theme : Theme
  }

--
initialModel : Model
initialModel =
  { projects = []
  , activeProject = Project.deselect
  , theme = Ui.Theme.dark
  }

--
initialCmd : Cmd Msg
initialCmd =
  Cmd.batch
    [
    ]

--
init : Flags -> ( Model, Cmd Msg )
init flags =
  ( initialModel
  , initialCmd
  )

-- Update ----------------------------------------------------------------------
-- Our Msg type serves simply to unify the Intent type and the Fact type.
type Msg
  = Intent Intent
  | Fact Fact 

-- The `Intent` type is used when we want to tell the update function **to do
-- something**. 
type Intent
  = NewProject
  | ToggleActiveProject ProjectSelection

-- The `Fact` type is used when we want to tell the update function **something
-- has happened**.
type Fact
  = NoOp

--
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Intent intent ->
      updateByIntent intent model

    Fact fact ->
      updateByFact fact model
    
--
updateByIntent : Intent -> Model -> ( Model, Cmd Msg )
updateByIntent intent model =
  case intent of
    NewProject ->
      ( { model | projects = Project.empty :: model.projects }
      , Cmd.none
      )

    ToggleActiveProject activeProject ->
      ( { model | activeProject = activeProject }
      , Cmd.none
      )

--
updateByFact : Fact -> Model -> ( Model, Cmd Msg )
updateByFact fact model =
  case fact of
    NoOp ->
      ( model, Cmd.none )

-- View ------------------------------------------------------------------------
--
view : Model -> Html Intent
view model =
  Html.main_ [ Attr.id "app" ]
    [ projectsSection model model.theme
    , tasksSection Nothing model.theme
    , notesSection Nothing model.theme
    ]

--
projectsSection : Model -> Theme -> Html Intent
projectsSection { activeProject, projects } theme =
  let
    projectsList : Html Intent
    projectsList =
      Html.ul [ Attr.class "overflow-y-scroll" ]
        (projects |> List.indexedMap (\i project ->
          Html.li [ Event.onClick <| ToggleActiveProject (Project.toggleSelection i activeProject) ] 
            [ Project.view theme project <| Project.isSelected i activeProject ]
        ))
  in
  Html.section [ Attr.id "projects", Attr.class "p-4", Ui.Colour.toBackground theme.background.two ]
    [ projectsList
    , Html.div [ Attr.class "flex items-center justify-center shadow-top" ]
      [ Ui.Button.circular [ Event.onClick NewProject ] theme.primary "+" ]
    ]

--
tasksSection : Maybe Project -> Theme -> Html Intent
tasksSection project theme =
  case project of
    Just proj ->
      Html.section
        [ Attr.id "tasks"
        , Attr.class "p-4"
        , Ui.Colour.toBackground theme.background.one
        ]
        [
        ]

    Nothing ->
      Html.section 
        [ Attr.id "tasks"
        , Attr.class "p-4 flex items-center justify-center"
        , Ui.Colour.toBackground theme.background.one
        ]
        [ Html.span [ Attr.class "mx-4 font-bold text-2xl", Ui.Colour.toText theme.text.muted ]
          [ Html.text "Select a project to view your active tasks." ]
        ]

--
notesSection : Maybe Task -> Theme -> Html Intent
notesSection task theme =
  Html.section
    [ Attr.id "notes"
    , Attr.class "p-4 flex items-center justify-center"
    , Ui.Colour.toBackground theme.background.base
    ]
    [ Html.span [ Attr.class "mx-4 font-bold text-2xl", Ui.Colour.toText theme.text.muted ]
      [ Html.text "Select a task to begin taking notes." ]
    ]

-- Subscriptions ---------------------------------------------------------------
--
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [
    ]