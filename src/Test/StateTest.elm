module Test.StateTest exposing (..)

import Monad.State exposing (..)


type TurnstileState
    = Locked
    | Unlocked


type TurnstileOutput
    = Thank
    | Open
    | Tut


coin : TurnstileState -> ( TurnstileOutput, TurnstileState )
coin _ =
    ( Thank, Unlocked )


push : TurnstileState -> ( TurnstileOutput, TurnstileState )
push x =
    case x of
        Locked ->
            ( Tut, Locked )

        Unlocked ->
            ( Open, Locked )


coinS : State TurnstileState TurnstileOutput
coinS =
    bind (put Unlocked) <| \_ ->
    return Thank


pushS : State TurnstileState TurnstileOutput
pushS =
    bind get <| \s ->
    bind (put Locked) <| \_ ->
    case s of
        Locked ->
            return Tut
        
        Unlocked ->
            return Open


mondayS : State TurnstileState (List TurnstileOutput)
mondayS =
    bind (coinS) <| \a1 ->
    bind (pushS) <| \a2 ->
    bind (pushS) <| \a3 ->
    bind (coinS) <| \a4 ->
    bind (pushS) <| \a5 ->
    return [a1, a2, a3, a4, a5]


testTurnstile : State TurnstileState (List TurnstileOutput)
testTurnstile =
    bind (put Locked) <| \_ ->
    bind (pushS) <| \check1 ->
    bind (put Unlocked) <| \_ ->
    bind (pushS) <| \check2 ->
    bind (put Locked) <| \_ ->
    return [check1, check2]
