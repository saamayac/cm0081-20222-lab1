
module Syntax ( Term(..), Token(..) ) where

data Term = Var String
          | Lam String Term
          | App Term Term
          deriving Show

-- Tokens use by the lexer and the parser.
data Token = TokenDot
           | TokenLambda
           | TokenLParen
           | TokenSemiColon
           | TokenRParen
           | TokenVar String
           deriving Show
