module WriterTest exposing (..)

import Monad.Writer exposing (..)
import String exposing (fromInt)


test1 : ( Int, List String )
test1 =
    runWriter (return 3)


logNumber : Int -> Writer String Int
logNumber x =
    Writer ( x, ["logged " ++ fromInt x] )


mlog1 : Writer String Int
mlog1 =
    bind (logNumber 3) <| \a ->
    bind (tell ["hi1"]) <| \_->
    bind (logNumber 5) <| \b ->
    bind (tell ["hi2"]) <| \_->
    return <| a * b
