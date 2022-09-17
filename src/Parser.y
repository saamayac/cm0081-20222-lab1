
{-# OPTIONS_HADDOCK prune#-} 
{

-- | All the documention from the file is from https://bnfc.readthedocs.io/_/
--downloads/en/latest/pdf/
module Parser ( myParser ) where
import Syntax ( Term(..), Token(..) ) -- ^import top level fuction 

}
-- | Generating parser, Attributions
%name happyParser --^Name of the top-level parsing function
-- |Types of tokens: Gives the type of the tokens passed from the lexical 
--analyser to the parser
%tokentype { Token }
--| Error declaration :Specifies the function to be called in the event of a 
--parse error.
%error { parseError }
-- |Tokens: is used to tell Happy about all the terminal symbols used in 
--the grammar. 
%token

    var   { TokenVar $$ }
    lam   { TokenLambda }
    "."   { TokenDot }
    "("   { TokenLParen }
    ")"   { TokenRParen }
    ";"   { TokenSemiColon }

%%
------------------------------------------------------------------------------
--|BNF predefine by the teacher,each grammar expressions has its own precences
-- levels and category symbols, to describe semantic definition
TermList :: { [Term] } --^ This Expression defines the concrete grammar of the
-- input 
TermList : Term ";" TermList { $1 : $3 }
    | {- empty -} { [] } 

Term :: { Term } --^ Rules for this grammar 
Term : AppTerm          { $1 }
    | lam var "." Term  { Lam $2 $4 }

AppTerm :: { Term }
AppTerm : aTerm         { $1 }
        | AppTerm aTerm { App $1 $2 }

aTerm :: { Term }
aTerm : var               { Var $1 }
    | "(" Term ")"    { $2 }

{
-- | Type function
parseError :: [Token] -> String
parseError = error "Parser Error"

myParser :: [Token] -> [Term]
myParser = happyParser
}