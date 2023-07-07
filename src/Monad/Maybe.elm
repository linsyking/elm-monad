module Monad.Maybe exposing (return, bind, fail)

{-|


# Maybe Monad

Computations which may return Nothing

Binding strategy: Nothing values bypass the bound function, other values are used as inputs to the bound function.

Useful for: Building computations from sequences of functions that may return Nothing.

@docs return, bind, fail

-}


{-| return function for Maybe
-}
return : a -> Maybe a
return x =
    Just x


{-| fail function for Maybe
-}
fail : a -> Maybe a
fail _ =
    Nothing


{-| bind function for Maybe
-}
bind : Maybe a -> (a -> Maybe b) -> Maybe b
bind x f =
    Maybe.andThen f x
