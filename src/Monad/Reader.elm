module Monad.Reader exposing
    ( Reader(..)
    , return, runReader, bind
    , ask, asks, local
    )

{-|


# Reader Monad

Computations which read values from a shared environment.

Binding strategy: Monad values are functions from the environment to a value. The bound function is applied to the bound value, and both have access to the shared environment.

Useful for: Maintaining variable bindings, or other shared environment.

@docs Reader
@docs return, runReader, bind

@docs ask, asks, local

-}


{-| Reader
-}
type Reader e a
    = Reader (e -> a)


{-| return function for Reader
-}
return : a -> Reader e a
return x =
    Reader (\_ -> x)


{-| Run the reader
-}
runReader : Reader e a -> (e -> a)
runReader (Reader f) =
    f


{-| bind function for Reader
-}
bind : Reader e a -> (a -> Reader e b) -> Reader e b
bind (Reader r) f =
    Reader <|
        \e ->
            runReader (f (r e)) e


{-| Ask the environment
-}
ask : Reader e e
ask =
    Reader identity


{-| Asks the environment to get something
-}
asks : (e -> a) -> Reader e a
asks sel =
    bind ask <| return << sel


{-| Execute a computation in a modified environment
-}
local : (e -> e) -> Reader e c -> Reader e c
local f c =
    Reader <|
        \e ->
            runReader c (f e)
