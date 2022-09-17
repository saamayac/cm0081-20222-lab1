-- Tested with GHC 9.2.4
module Main ( main ) where

-- Global imports
import System.Environment ( getArgs, getProgName )
import System.Exit        ( exitFailure )
import System.IO          ( hPutStrLn, stderr )

-- Local imports
import Lexer  ( myLexer )
import Parser ( myParser )
import Syntax ( Term )

------------------------------------------------------------------------------

main :: IO ()
main = do
  progName <- getProgName
  args <- getArgs
  case args of
    [file] -> do
      content <- readFile file
      -- lexer  :: String -> [Token]
      -- parser :: [Token] -> [Term]
      let terms :: [Term]
          terms = myParser $ myLexer content
      mapM_ print terms

    _     -> do hPutStrLn stderr $ "Usage: " ++ progName ++ " FILE"
                exitFailure
