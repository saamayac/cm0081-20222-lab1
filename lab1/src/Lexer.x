

{
module Lexer ( lexer ) where
import Syntax ( Token )
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-z A-Z]
$special = [\. \; \( \)]
$alphaNum = [$alpha $digit]

tokens :-

    $alphaNum           { \s -> TokenVar }
    \)                  { \s -> TokenRParen }
    \(                  { \s -> TokenLParen }
    \;                  { \s -> TokenSemiColon }
    \.                  { \s -> TokenDot }
    \n                  ;
    $digit+				{ \s -> TokenDigit }
    $alpha		        { \s -> TokenAlpha }

{
lexer :: String -> [Token]
lexer n = alexScanTokens n
}