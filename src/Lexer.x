-- Tested with alex 3.2.7.1
{
{-# OPTIONS_GHC -Wno-missing-local-signatures #-}
{-# OPTIONS_HADDOCK prune#-}

-- | All the documention from the file is from https://haskell-alex.readthe
--   docs.io/en/latest/api.html?highlight=alexScanTokens#the-basic-wrapper

------------------------------------------------------------------------------

module Lexer ( myLexer ) where

-- local imports

import Syntax ( Token(..) )

}

------------------------------------------------------------------------------
-- Wrapper

-- | The basic wrapper provides no support for using startcodes;
--   the initial startcode is always set to zero.

%wrapper "basic"

------------------------------------------------------------------------------
-- Macro definitions

-- | Precedence, These macro definitions are used in the BNF specification,
--   those are our lexical syntax

$digit = 0-9
$alpha = [a-z A-Z]
$special = [\. \; \( \) \;]
$alphaNum = [$alpha $digit]

-- | Specification of the Strings that lexer will accept to make the Tokens

tokens :-

    \n                  ;
    "--".*				;
    $white+             ;
    $alpha $alphaNum*   { \s -> TokenVar s }
    \)                  { \s -> TokenRParen }
    \(                  { \s -> TokenLParen }
    \;                  { \s -> TokenSemiColon}
    \.                  { \s -> TokenDot}
    "λ" | \\            { \s -> TokenLambda}

------------------------------------------------------------------------------
-- functions

{

-- | alexScanTokens takes a String input and returns a list of the tokens.
-- | myLexer funtion resives an String input and outputs a list of Tokens

myLexer :: String -> [Token]
myLexer n = alexScanTokens n

}
