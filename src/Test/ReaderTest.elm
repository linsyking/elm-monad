module Test.ReaderTest exposing (..)

import Monad.Reader exposing (..)



-- Every sheep has a number


type alias Sheep =
    Int


type alias Env =
    { name : String
    , number : Int
    , parents : Sheep -> List Sheep
    }


testEnv : Env
testEnv =
    { name = "HappyFarm"
    , number = 10
    , parents = \x -> [ x, x + 1 ]
    }


getParents : Int -> Env -> List Sheep
getParents id e =
    e.parents id


testParentNumber : Reader Env Int
testParentNumber =
    bind (asks <| getParents 0) <| \x ->
    return (List.length x)
