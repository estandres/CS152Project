/* scanner for a toy Pascal-lke language */
%{
/* need ths for the call to atof() below */
#include <math.h>
int num_lines=1;
int num_chars=1;
%}
DIGIT  [0-9]
LETTER [a-zA-Z]
ID     {LETTER}({LETTER}|{DIGIT}|([_])*([_]{LETTER}|[_]{DIGIT}))*
BADID1 {DIGIT}{LETTER}({LETTER}|{DIGIT}|[_])*(({LETTER}|{DIGIT})+)*
BADID2 {LETTER}({LETTER}|{DIGIT})*[_]+
%%
{DIGIT}+ {
	printf( "NUMBER %s\n", yytext,atoi( yytext ) );
	num_chars+=strlen(yytext);
	}
"function" printf("FUNCTION\n", yytext); 
"beginparams" printf("BEGIN_PARAMS\n", yytext); 
"endparams" printf("END_PARAMS\n", yytext); 
"beginlocals" printf("BEGIN_LOCALS\n", yytext); 
"endlocals" printf("END_LOCALS\n", yytext); 
"beginbody" printf("BEGIN_BODY\n", yytext); 
"endbody" printf("END_BODY\n", yytext); 
"integer" printf("INTEGER\n", yytext); 
"array" printf("ARRAY\n", yytext); 
"of" printf("OF\n", yytext); 
"if" printf("IF\n", yytext); 
"then" printf("THEN\n", yytext); 
"endif" printf("ENDIF\n", yytext); 
"else" printf("ELSE\n", yytext); 
"while" printf("WHILE\n", yytext); 
"do" printf("DO\n", yytext); 
"beginloop" printf("BEGINLOOP\n", yytext); 
"endloop" printf("ENDLOOP\n", yytext); 
"break" printf("BREAK\n", yytext); 
"read" printf("READ\n", yytext); 
"write" printf("WRITE\n", yytext); 
"and" printf("AND\n", yytext); 
"or" printf("OR\n", yytext); 
"not" printf("NOT\n", yytext); 
"true" printf("TRUE\n", yytext); 
"false" printf("FALSE\n", yytext); 
"return" printf("RETURN\n", yytext); 
"-" printf("SUB\n", yytext); num_chars+=strlen(yytext);
"+" printf("ADD\n", yytext); num_chars+=strlen(yytext);
"*" printf("MULT\n", yytext); num_chars+=strlen(yytext);
"/" printf("DIV\n", yytext); num_chars+=strlen(yytext);
"%" printf("MOD\n", yytext); num_chars+=strlen(yytext);
"==" printf("EQ\n", yytext); num_chars+=strlen(yytext);
"<>" printf("NEQ\n", yytext); num_chars+=strlen(yytext);
"<" printf("LT\n", yytext); num_chars+=strlen(yytext);
">" printf("GT\n", yytext); num_chars+=strlen(yytext);
"<=" printf("LTE\n", yytext); num_chars+=strlen(yytext);
">=" printf("GTE\n", yytext); num_chars+=strlen(yytext);
";" printf("SEMICOLON\n", yytext); num_chars+=strlen(yytext);
":" printf("COLON\n", yytext); num_chars+=strlen(yytext);
"," printf("COMMA\n", yytext); num_chars+=strlen(yytext);
"(" printf("L_PAREN\n", yytext); num_chars+=strlen(yytext);
")" printf("R_PAREN\n", yytext); num_chars+=strlen(yytext);
"[" printf("L_SQUARE_BRACKET\n", yytext); num_chars+=strlen(yytext);
"]" printf("R_SQUARE_BRACKET\n", yytext); num_chars+=strlen(yytext);
":=" printf("ASSIGN\n", yytext);num_chars+=strlen(yytext);
{ID} printf( "IDENT %s\n", yytext ); num_chars+=strlen(yytext);
{BADID1} {
    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter \n", num_lines, num_chars, yytext);
    num_chars+=strlen(yytext);
    return 0;  
  }
{BADID2} {
    printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore \n", num_lines, num_chars, yytext);
    num_chars+=strlen(yytext);
    return 0;   
  }
"##".*           /* DO NOTHING on comment*/ ++num_lines;
[\t] num_chars+=strlen(yytext); 
[\n]+ /* eat up tabs and ncrement*/ ++num_lines;num_chars=1;
[ ] ++num_chars;
. {
	printf("Error at line %d, column %d: unrecognized symbol \"%s\" \n", num_lines, num_chars, yytext);
	num_chars+=strlen(yytext);
	return 0;
  }


%%
int main( int argc, char **argv )
	{
	++argv, --argc;  /* skp over program name */
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;
	yylex();

	}

