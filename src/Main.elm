import Browser
import Html exposing (..)
import Time
import Task
import Svg exposing (svg)
import Svg.Attributes exposing (..)

import YearClock
import ClockSvg


-- Main

main =
  Browser.element
  {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
  }


-- Model

type alias Model =
  {
    zone : Time.Zone,
    time : Time.Posix
  }

init : () -> (Model, Cmd Msg)
init _ =
  (
    Model Time.utc (Time.millisToPosix 0),
    Task.perform identity (Task.map2 Initialize Time.here Time.now)
  )


-- Update

type Msg
  = Initialize Time.Zone Time.Posix
  | UpdateTick Time.Posix

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Initialize zone time ->
      (
        Model zone time,
        Cmd.none
      )
    UpdateTick tick ->
      (
        { model | time = tick },
        Cmd.none
      )


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 UpdateTick


-- View

view : Model -> Html Msg
view model =
  let
    yc = YearClock.fromPosix model.time
    hour = String.fromInt (YearClock.toHour yc)
    minute = String.fromInt (YearClock.toMinute yc)
    second = String.fromInt (YearClock.toSecond yc)
  in
  div []
  [ h1 [] [ text ( hour ++ " : " ++ minute ++ " : " ++ second ) ]
  , ClockSvg.draw 2 yc
  ]
