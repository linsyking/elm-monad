module Monad.List exposing (return, bind, fail)

{-|


# List Monad

@docs return, bind, fail

-}


{-| return function for List
-}
return : a -> List a
return x =
    [ x ]


{-| fail function for List
-}
fail : a -> List a
fail _ =
    []


{-| bind function for List

The behavior is the same as the concatMap

-}
bind : List a -> (a -> List b) -> List b
bind x f =
    List.concatMap f x
