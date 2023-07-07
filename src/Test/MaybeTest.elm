module Test.MaybeTest exposing (..)

import Monad.Maybe as MaybeM
import Monad.List as ListM


type Sheep
    = Sheep


father : Sheep -> Maybe Sheep
father _ =
    Nothing


mother : Sheep -> Maybe Sheep
mother _ =
    Nothing


parent : Sheep -> List Sheep
parent x =
    [ x, x ]


maternalGrandfatherBind : Sheep -> Maybe Sheep
maternalGrandfatherBind s =
    MaybeM.bind (mother s) <| \x ->
    MaybeM.bind (father x) <| \y ->
    MaybeM.return y


maternalGrandfatherChain : Sheep -> Maybe Sheep
maternalGrandfatherChain s =
    mother s |> Maybe.andThen (\x ->
    father x |> Maybe.andThen (\y->
    Just y))


grandParent: Sheep -> List Sheep
grandParent x =
    ListM.bind (ListM.return x) <| \y ->   
    ListM.bind (parent y) <| \z->
    parent z
