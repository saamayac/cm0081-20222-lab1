
##############################################################################
# GHC warnings

GHCFLAGS1 := -Wall \
            -Wmissing-local-signatures

GHCFLAGS := -Werror \
            -Weverything \
            -Wno-implicit-prelude \
            -Wno-missing-deriving-strategies \
            -Wno-missing-home-modules \
            -Wno-missing-kind-signatures \
            -Wno-missing-safe-haskell-mode \
            -Wno-prepositive-qualified-module \
            -Wno-unsafe \
            -Wno-unused-packages

##############################################################################

Lexer.hs : Lexer.x
	alex $<

Parser.hs : Parser.y
	happy $<

.DEFAULT_GOAL := lab1
lab1 : Lexer.hs Main.hs Parser.hs Syntax.hs
	ghc $(GHCFLAGS) Main.hs -o $@

hlint :
	hlint --ignore-glob=Lexer.hs --ignore-glob=Parser.hs .

clean :
	rm -f *.hi
	rm -f *.o
	rm -f Lexer.hs
	rm -f Parser.hs
	rm -f lab1

very-clean : clean
