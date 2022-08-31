{
    module Parser ( parser ) where
    import Syntax ( Term )
}

%name parser
%tokentype { Token }
%error { parserError }

%token

    \n    ;
    var   { TokenVar }
    lam   { TokenLambda }
    "."   { TokenDot }
    "("   { TokenLParen }
    ")"   { TokenRParen }
    ";"   { TokenSemiColon }


Var : var { Var $1 }

Term : appTerm
    | lam var . Term  {Lam (Var ($2)) $4}

AppTerm : aTerm { $1 }
        | AppTerm aTern { $1 $2 }

aTerm : "(" Term ")" { $2 }
    | Var

parserError :: [token] -> a
perserError = error "Parser Error"

parser :: [token] -> string


