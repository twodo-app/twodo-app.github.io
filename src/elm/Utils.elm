module Utils exposing (..)

-- Functions -------------------------------------------------------------------
--
toggle : (a -> Bool) -> a -> Maybe a -> Maybe a
toggle predicate b maybe =
  case maybe of
    Just a ->
      if predicate a then Nothing else Just b

    Nothing ->
      Just b
