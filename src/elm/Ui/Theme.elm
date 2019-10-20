module Ui.Theme exposing
  ( Theme
  , light, dark
  )

-- Imports ---------------------------------------------------------------------
import Ui.Colour exposing (..)

-- Types -----------------------------------------------------------------------
--
type alias Theme =
  { primary : Colour
  , secondary : Colour
  , accent : Colour
  , background :
    { base : Colour
    , one : Colour
    , two : Colour
    }
  , text : 
    { base : Colour
    , muted : Colour
    }
  }

-- Functions -------------------------------------------------------------------
--
light : Theme
light =
  { primary = indigo
  , secondary = yellow
  , accent = white
  , background =
    { base = lightenBy 4 grey
    , one = lightenBy 3 grey
    , two = lightenBy 2 grey
    }
  , text =
    { base = darkenBy 3 grey
    , muted = darken grey
    }
  }

--
dark : Theme
dark =
  { primary = indigo
  , secondary = yellow
  , accent = black
  , background =
    { base = darkenBy 4 grey 
    , one = darkenBy 3 grey
    , two = darkenBy 2 grey
    }
  , text =
    { base = lightenBy 4 grey
    , muted = lightenBy 2 grey
    }
  }