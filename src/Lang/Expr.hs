{-# LANGUAGE BangPatterns #-}
module Lang.Expr where

import           System.Process (callCommand)
import           Control.Monad (unless)
import           System.Exit (ExitCode(ExitSuccess))
import qualified Data.Map.Strict                     as Map

data Rule =  Rule [String] -- procedure
                  [String] -- dependency
          deriving (Show, Eq)

type Rules = Map.Map String Rule

join _ [h] = h
join c (h:r)  = h ++ c ++ join c r

ruleDeps :: Rule -> [String]
ruleDeps r = let (Rule _ deps) = r in deps

flattenCommands :: Rules -> String -> [String]
flattenCommands r t = tList ++ depLists 
    where
        (Rule tList deps) = r Map.! t
        depLists = concatMap (flattenCommands r ) deps
        

eval :: Rules -> String -> IO ()
eval r n = do
    let command = join "&&" $ flattenCommands r n
    callCommand command

