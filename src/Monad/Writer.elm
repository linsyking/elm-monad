module Monad.Writer exposing
    ( Writer(..)
    , return, runWriter, bind, tell
    )

{-|


# Writer Monad

Computations which produce a stream of data in addition to the computed values.

Binding strategy: A Writer monad value is a (computation value, log value) pair.
Binding replaces the computation value with the result of applying the bound function to the previous value and appends any log data from the computation to the existing log data.

Useful for: Logging, or other computations that produce output "on the side".

The definition of writer monad in Haskell is

    newtype Writer w a = Writer { runWriter :: (a,w) }

where `w` should be monoid (with mappend function).

We assume you only use List so we replace `w` with `List w`

@docs Writer
@docs return, runWriter, bind, tell

-}


{-| Writer
-}
type Writer w a
    = Writer ( a, List w )


{-| return function for Writer
-}
return : a -> Writer w a
return x =
    Writer ( x, [] )


{-| Run the writer
-}
runWriter : Writer w a -> ( a, List w )
runWriter (Writer f) =
    f


{-| bind function for Writer
-}
bind : Writer w a -> (a -> Writer w b) -> Writer w b
bind (Writer ( v, l )) f =
    Writer <|
        let
            ( v_, l_ ) =
                runWriter <| f v
        in
        ( v_, l ++ l_ )


{-| tell function for Writer
-}
tell : List w -> Writer w ()
tell xs =
    Writer ( (), xs )
