################################################################################
# specific settings.



################################################################################
# main targets 

top :
	make MiniJava.hs

bin :
	# make top
	${ghc} --make Main.lhs -o a.out
	chmod 755 a.out


# dependencies due to customisation (still needed?)
${PARSER}.hs : ${PARSER}.ly 
Parser.hi : ${PARSER}.hs

tar :
	tar cf - ${FILES} Makefile | gzip -c > dist.tgz 

zip :
	zip -r compiler.zip ${FILES} Makefile 

oozip :
	zip -r compiler.zip ${FILES} Makefile *.java

wintar :
	make bin GHC=ghc
	cp a.out compiler.exe
	strip compiler.exe
	zip binary.zip compiler.exe rts.[ch] README* *va

shift : wintar oozip
	scp binary.zip dur:public_html
	scp compiler.zip dur:public_html
	


FILES = Misc.lhs Lexer.lhs Main.lhs MiniJava.hs MiniJava.ly \
	Syntax.lhs PrintBasics.lhs Printer.lhs \
	SymbolTable.lhs BuildTable.lhs TypeCheck.lhs \
	Temp.lhs IR.lhs PrintIR.lhs TransBasics.lhs Translate.lhs \
	Canonicalise.lhs FormTraces.lhs ProduceC_Code.lhs \
	README rts.c rts.h \
	QuickSort.java BinaryTree.java mthd_sub.java


################
# standard lumps



################################################################################
# various bits of general config.

# declaring significant suffixes
.SUFFIXES: .hi .o .hs .lhs .ly .c .hc

# various paths 
HAPPY = /users/haskell/happy-1.10/bin/happy-1.10


GHC = /users/haskell/ghc-5/bin/ghc 
GHC = ghc
ghc = ${GHC} -H20M -cpp -package lang -package text -fglasgow-exts -fallow-undecidable-instances 


################################################################################
# make rules

.hs.hi :
	${ghc} -c $*.hs
.lhs.hi :
	${ghc} -c $*.lhs

.hs.o :
	${ghc} -c $*.hs
.lhs.o :
	${ghc} -c $*.lhs
.hc.o :
	${ghc} -c $*.hc

# this needed because ghc also produces .hi files in compilation
.o.hi :
	@ # .o -> .hi for $*

.ly.hs : 
	${HAPPY} --info $*.ly



################################################################################
# aux targets 

deps :
	${ghc} -M *.lhs *.ly

ci : 
	cvs ci Makefile *.lhs *.ly rts.c rts.h README


clean :
	rm *.o *.hi a.out
	rm *.[1-6]-*
	rm `ls *.c | grep -v rts.c`
	@ echo 
	@ echo do the rest by hand 
	@ echo



################################################################################
# DO NOT DELETE: Beginning of Haskell dependencies
Canonicalise.o : Canonicalise.lhs
Canonicalise.o : ./PrintIR.hi
Canonicalise.o : ./IR.hi
Canonicalise.o : ./TransBasics.hi
Canonicalise.o : ./Temp.hi
FormTraces.o : FormTraces.lhs
FormTraces.o : ./PrintIR.hi
FormTraces.o : ./IR.hi
FormTraces.o : ./TransBasics.hi
IR.o : IR.lhs
IR.o : ./Temp.hi
Lexer.o : Lexer.lhs
Lexer.o : ./Misc.hi
Main.o : Main.lhs
Main.o : ./ProduceC_Code.hi
Main.o : FormTraces.hi
Main.o : ./PrintIR.hi
Main.o : Canonicalise.hi
Main.o : ./Translate.hi
Main.o : ./SymbolTable.hi
Main.o : ./TypeCheck.hi
Main.o : ./BuildTable.hi
Main.o : ./Syntax.hi
Main.o : ./Printer.hi
Main.o : ./MiniJava.hi
Main.o : Lexer.hi
Main.o : ./Misc.hi
Misc.o : Misc.lhs
PrintBasics.o : PrintBasics.lhs
PrintIR.o : PrintIR.lhs
PrintIR.o : IR.hi
PrintIR.o : PrintBasics.hi
Printer.o : Printer.lhs
Printer.o : ./Syntax.hi
Printer.o : PrintBasics.hi
ProduceC_Code.o : ProduceC_Code.lhs
ProduceC_Code.o : ./TransBasics.hi
ProduceC_Code.o : PrintIR.hi
ProduceC_Code.o : IR.hi
SymbolTable.o : SymbolTable.lhs
SymbolTable.o : PrintBasics.hi
SymbolTable.o : ./Syntax.hi
Syntax.o : Syntax.lhs
Temp.o : Temp.lhs
Temp.o : Syntax.hi
Temp.o : PrintBasics.hi
TransBasics.o : TransBasics.lhs
TransBasics.o : IR.hi
TransBasics.o : SymbolTable.hi
TransBasics.o : Temp.hi
Translate.o : Translate.lhs
Translate.o : TransBasics.hi
Translate.o : Syntax.hi
Translate.o : PrintIR.hi
Translate.o : IR.hi
Translate.o : Temp.hi
Translate.o : SymbolTable.hi
TypeCheck.o : TypeCheck.lhs
TypeCheck.o : Printer.hi
TypeCheck.o : SymbolTable.hi
TypeCheck.o : Syntax.hi
buildTable.o : buildTable.lhs
buildTable.o : SymbolTable.hi
buildTable.o : Syntax.hi
# DO NOT DELETE: End of Haskell dependencies
