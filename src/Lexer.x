{
module Lexer ( myLexer ) where

import Syntax ( Token(..) )
}

%encoding "utf-8"
%wrapper "basic"

$digit = 0-9
$alpha = [a-z A-Z]
$special = [\. \; \( \) \;]
$alphaNum = [$alpha $digit]

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
myLexer :: String -> [Token]
myLexer n = alexScanTokens n
}