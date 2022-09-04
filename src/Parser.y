{
module Parser ( parser ) where
import Syntax ( Term(..), Token(..) )
}

%name HappyParser
%tokentype { Token }
%error { parserError }

%token

    var   { TokenVar $$ }
    lam   { TokenLambda $$ }
    "."   { TokenDot }
    "("   { TokenLParen }
    ")"   { TokenRParen }
    ";"   { TokenSemiColon }

%%

Term :: { Term }
Term : AppTerm        { $1 }
    | lam var "." Term  { Lam $2 $4 }

AppTerm :: { AppTerm }
AppTerm : aTerm         { $1 }
        | AppTerm aTerm { App $1 $2 }

aTerm :: { aTerm }
aTerm : "(" Term ")"    { Var $2 }
    | var               { Var $1 }

program :: { program }
program : TermList { $1 }

TermList :: { TermList }
TermList : Term ";" TermList { $2 $3 }


{
parserError :: [token] -> a
perserError = error "Parser Error"

parser :: [token] -> string
parser n = HappyParser n
}