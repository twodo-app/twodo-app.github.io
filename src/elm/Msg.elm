module Msg exposing
  ( Msg (..)
  , Intent (..), Fact (..)
  , none
  )

-- Imports ---------------------------------------------------------------------
import Data.Project exposing (Project)

-- Types -----------------------------------------------------------------------
-- Our Msg type serves simply to unify the Intent type and the Fact type.
type Msg
  = Intent Intent
  | Fact Fact 
  | None

-- The `Intent` type is used when we want to tell the update function **to do
-- something**. 
type Intent
  -- NoIntent exists mainly for debugging and development
  = NoIntent
  | AddProject
  | FocusProject Project
  | RemoveProject

-- The `Fact` type is used when we want to tell the update function **something
-- has happened**.
type Fact
  = NoFact
  | Tick

-- Functions -------------------------------------------------------------------
--
none : Msg
none =
  None
