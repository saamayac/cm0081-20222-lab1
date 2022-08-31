
module Main ( main ) where

-- Global imports
import System.Environment ( getArgs, getProgName )
import System.Exit        ( exitFailure )
import System.IO          ( hPutStrLn, stderr )

-- Local imports
import Lexer  ( lexer )
import Parser ( parser )
import Syntax ( Term ) -- Syntax.hs

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
          terms = parser $ lexer content
      mapM_ print terms

    _     -> do hPutStrLn stderr $ "Usage: " ++ progName ++ " FILE"
                exitFailure
