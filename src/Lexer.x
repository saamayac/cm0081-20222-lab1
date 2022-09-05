{
module Lexer ( myLexer ) where

import Syntax ( Token(..) )

}

%wrapper "basic"

$digit = 0-9
$alpha = [a-z A-Z]
$special = [\. \; \( \) \; \\]
$alphaNum = [$alpha $digit]

tokens :-

    \n                  ;
    "--".*				;
    $white+             ;
    $alphaNum+          { \s -> TokenVar s }
    \)                  { \s -> TokenRParen }
    \(                  { \s -> TokenLParen }
    \;                  { \s -> TokenSemiColon}
    \.                  { \s -> TokenDot}
    \\                  { \s -> TokenLambda}

{
myLexer :: String -> [Token]
myLexer n = alexScanTokens n
}