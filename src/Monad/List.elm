module Monad.List exposing (return, bind, fail)

{-|


# List Monad

Computations which may return 0, 1, or more possible results.

Binding strategy: The bound function is applied to all possible values in the input list and the resulting lists are concatenated to produce a list of all possible results.

Useful for: Building computations from sequences of non-deterministic operations. Parsing ambiguous grammars is a common example.

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
