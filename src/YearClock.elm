module YearClock exposing
  ( YearClock
  , fromPosix
  , toRatio
  , toHour, toMinute, toSecond
  )

import Time

type alias YearClock =
  {
    elapsedSecs : Int
  }


secondsOfYear : Int
secondsOfYear = 365 * 24 * 60 * 60


fromPosix : Time.Posix -> YearClock
fromPosix posix =
  YearClock (modBy secondsOfYear (Time.posixToMillis posix // 1000))


toRatio : YearClock -> Float
toRatio yc = (toFloat yc.elapsedSecs) / (toFloat secondsOfYear)


toHour : YearClock -> Int
toHour yc =
  floor ((toRatio yc) * 24)

toMinute : YearClock -> Int
toMinute yc =
  modBy 60 (floor ((toRatio yc) * 24 * 60 ))

toSecond : YearClock -> Int
toSecond yc =
  modBy 60 (floor ((toRatio yc) * 24 * 60 * 60))
