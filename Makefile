all: lexer

lexer: flexfile
	 gcc -o lexer lex.yy.c -lfl

flexfile: 
	flex 861302910_862136048.lex
