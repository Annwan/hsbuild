module Main where

import Lang.Expr 
import Data.Map.Strict (fromList)
import StrictList
main :: IO ()
main = interact id

rules :: Rules
rules = fromList
    [ ( "foo", Rule ["echo foo"]  ["dat", "pwd"] )
    , ( "dat", Rule ["date"] [] )
    , ( "pwd", Rule ["pwd"] [] )
    ]
