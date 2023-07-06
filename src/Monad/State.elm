module Monad.State exposing
    ( State(..)
    , return, bind, runState
    , get, put
    )

{-|


# State Monad

Computations which maintain state.

Binding strategy: Binding threads a state parameter through the sequence of bound functions so that the same state value is never used twice, giving the illusion of in-place update.

Useful for: Building computations from sequences of operations that require a shared state.

@docs State
@docs return, bind, runState
@docs get, put

-}


{-| State
-}
type State s a
    = State (s -> ( a, s ))


{-| return function for State
-}
return : a -> State s a
return x =
    State <| \s -> ( x, s )


{-| Run the state
-}
runState : State s a -> s -> ( a, s )
runState (State f) x =
    f x


{-| bind function for State
-}
bind : State s a -> (a -> State s b) -> State s b
bind (State x) f =
    State <|
        \s ->
            let
                ( v, s_ ) =
                    x s
            in
            runState (f v) s_


{-| Get current state
-}
get : State a a
get =
    State <| \s -> ( s, s )


{-| Put a new state
-}
put : s -> State s ()
put st =
    State <| \_ -> ( (), st )
