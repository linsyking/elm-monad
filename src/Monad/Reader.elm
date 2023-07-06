module Monad.Reader exposing
    ( Reader(..)
    , return, runReader, bind
    , ask, local
    )

{-|


# Reader Monad

@docs Reader
@docs return, runReader, bind

@docs ask, local

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


{-| Execute a computation in a modified environment
-}
local : (a -> b) -> Reader b c -> Reader a c
local f c =
    Reader <|
        \e ->
            runReader c (f e)
