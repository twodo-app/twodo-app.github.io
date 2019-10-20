port module Main exposing (main)

-- Imports ---------------------------------------------------------------------
import Browser
import Data.Project exposing (Project)
import Data.Task exposing (Task)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode
import Json.Decode exposing (Value)
import Maybe.Extra as Maybe
import Msg exposing (Msg, Intent(..), Fact(..), none)
import Time
import Ui.Button
import Ui.Colour exposing (Colour)
import Ui.Theme exposing (Theme)
import Utils
import View.Notes
import View.Projects
import View.Tasks

-- Ports -----------------------------------------------------------------------
port fromElm : Value -> Cmd msg
port fromJs : (Value -> msg) -> Sub msg

-- Main ------------------------------------------------------------------------
-- For now Flags is an alias for an empty tuple, commonly referred to as _the_
-- unit type (although there are many unit types...). This exists so that when
-- we do eventually want to introduce flags into our application, we don't have 
-- to make so many changes.
type alias Flags
  = Value


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
    , view = view >> Html.map Msg.Intent
    -- Similarly, our subscriptions can only return values of type `Sub Fact`.
    -- This makes sense because we are subscribing to things that happen so we
    -- represent "this thing happened" as a Fact.
    , subscriptions = subscriptions >> Sub.map Msg.Fact
    }

-- Model -----------------------------------------------------------------------
--
type alias Model =
  { projects : List Project
  , focusedProject : Maybe Project
  , count : Int
  , theme : Theme
  }

--
initialModel : Result Json.Decode.Error (List Project) -> Model
initialModel json =
  { projects = Result.withDefault [] json
  , focusedProject = Nothing
  , count = 0
  , theme = Ui.Theme.light
  }

--
initialCmd : Model -> Cmd Msg
initialCmd model =
  Cmd.batch
    [
    ]

--
init : Flags -> ( Model, Cmd Msg )
init json =
  Json.Decode.decodeValue (Json.Decode.list Data.Project.decoder) json
    |> initialModel
    |> withCmd initialCmd

-- Update ----------------------------------------------------------------------
--
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Msg.Intent intent ->
      updateByIntent intent model

    Msg.Fact fact ->
      updateByFact fact model

    Msg.None ->
      ( model, Cmd.none )
    
--
updateByIntent : Intent -> Model -> ( Model, Cmd Msg )
updateByIntent intent model =
  case intent of
    NoIntent ->
      ( model, Cmd.none )

    AddProject ->
      Data.Project.empty (model.count + 1)
        |> List.singleton
        |> List.append model.projects
        |> \projects -> { model | projects = projects, count = model.count + 1 }
        |> withCmd (.projects >> Json.Encode.list Data.Project.encode >> fromElm)      

    FocusProject project ->
      Utils.toggle (.id >> (==) project.id) project model.focusedProject
        |> \focusedProject -> { model | focusedProject = focusedProject }
        |> withCmdNone

    RemoveProject ->
      Maybe.map .id model.focusedProject
        |> Maybe.withDefault -1
        |> \id -> List.filter (.id >> (/=) id) model.projects
        |> \projects -> { model | projects = projects, focusedProject = Nothing }
        |> withCmd (.projects >> Json.Encode.list Data.Project.encode >> fromElm)

--
updateByFact : Fact -> Model -> ( Model, Cmd Msg )
updateByFact fact model =
  case fact of
    NoFact ->
      ( model, Cmd.none )

    Tick ->
      model
        |> withCmd (.projects >> Json.Encode.list Data.Project.encode >> fromElm)

-- This makes it nicer to work with pipes in the `update` function. We can
-- modify the model and then pipe it into this function to pair that model with
-- a command.
--
--   incrementCount model
--     |> withCmd (always Cmd.none)
withCmd : (Model -> Cmd Msg) -> Model -> ( Model, Cmd Msg )
withCmd cmd model =
  ( model, cmd model )

-- Calling `withCmd Cmd.none` is a common enough occurance that it makes sense
-- to create another little utility function just for this.
--   incrementCount model
--     |> withCmdNone
withCmdNone : Model -> ( Model, Cmd Msg )
withCmdNone =
  withCmd (always Cmd.none)

-- View ------------------------------------------------------------------------
--
view : Model -> Html Intent
view ({ theme, focusedProject } as model )=
  Html.main_ 
    [ id "app" ]
    [ View.Projects.section theme model
    , View.Tasks.section theme focusedProject
    , View.Notes.section theme {}
    ]

-- Subscriptions ---------------------------------------------------------------
--
subscriptions : Model -> Sub Fact
subscriptions model =
  Sub.batch
    [ Time.every 10000 (always Tick)
    ]
