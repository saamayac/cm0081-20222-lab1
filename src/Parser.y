{
module Parser ( myParser ) where

import Syntax ( Term(..), Token(..) )
}

%name happyParser
%tokentype { Token }
%error { parseError }

%token

    var   { TokenVar $$ }
    lam   { TokenLambda }
    "."   { TokenDot }
    "("   { TokenLParen }
    ")"   { TokenRParen }
    ";"   { TokenSemiColon }

%%

TermList :: { [Term] }
TermList : Term ";" TermList { $1 : $3 }
    | {- empty -} { [] }

Term :: { Term }
Term : AppTerm          { $1 }
    | lam var "." Term  { Lam $2 $4 }

AppTerm :: { Term }
AppTerm : aTerm         { $1 }
        | AppTerm aTerm { App $1 $2 }

aTerm :: { Term }
aTerm : var               { Var $1 }
    | "(" Term ")"    { $2 }

{
parseError :: [Token] -> a
parseError = error "Parser Error"

myParser :: [Token] -> [Term]
myParser = happyParser
}

