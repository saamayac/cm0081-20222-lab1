{-# OPTIONS_GHC -Wno-missing-local-signatures #-}
{-# OPTIONS_HADDOCK prune#-}
{
-- |All the documention from the file is from https://haskell-alex.readthe
--docs.io/en/latest/api.html?highlight=alexScanTokens#the-basic-wrapper
module Lexer ( myLexer ) where

import Syntax ( Token(..) )
}

%encoding "utf-8"
-- | The basic wrapper provides no support for using startcodes; 
--the initial startcode is always set to zero.
%wrapper "basic"
-- | Precedence, These macro definitions are used in the BNF specification, 
--those are our lexical syntax
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

{
-- |alexScanTokens takes a String input and returns a list of the tokens.
myLexer :: String-- ^ This is the String input 
         -> [Token] -- ^ This is the list of Tokens
myLexer n = alexScanTokens n
}