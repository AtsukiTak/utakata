module ClockSvg exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import YearClock

circleStrokeWidth : Int -> Int
circleStrokeWidth rad = rad // 30

draw : Int -> YearClock.YearClock -> Html msg
draw scale yc =
  let
    turn = YearClock.toRatio yc
  in
  svg
    [ width (String.fromInt (105 * 2 * scale))
    , height (String.fromInt (105 * 2 * scale))
    ]
    [
      g
        [ transform ("scale(" ++ (String.fromInt scale) ++ ")")]
        [
          circle
            [ cx "105"
            , cy "105"
            , r "100"
            , stroke "black"
            , strokeWidth "5"
            , fill "transparent"
            ]
            []
        , line
            [ x1 "105"
            , y1 "105"
            , x2 (String.fromInt (105 + floor (90 * sin (turns turn))))
            , y2 (String.fromInt (15 + floor (90 * cos (turns turn))))
            , stroke "black"
            , strokeWidth "5"
            ]
            []
        ]
    ]
