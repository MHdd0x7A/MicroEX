%{
#include "y.tab.h"
%}

%%
[ \t] ;
[\n] ;
\%\%.*\n ;		// Comment


[Pp][Rr][Oo][Gg][Rr][Aa][Mm]    {return PROGRAM;}
[Bb][Ee][Gg][Ii][Nn] 	{return BEGINT;} 
[Ee][Nn][Dd] 		{return END;}

[Dd][Ee][Cc][Ll][Aa][Rr][Ee]	{return DECLARE;}
[Aa][Ss]    {return AS;}


[Ii][Nn][Tt][Ee][Gg][Ee][Rr] { strcpy(yylval.vartype, yytext); return VARTYPE; }
[Ff][Ll][Oo][Aa][Tt]    { strcpy(yylval.vartype, yytext); return VARTYPE; }


[a-zA-Z][a-zA-Z0-9_]* {	strcpy(yylval.varname, yytext);	return NAME;} 
[0-9]+ { yylval.val = atof(yytext);	return NUMBER;}
([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+) { yylval.val = atof(yytext); return NUMBER;}   //0.9 or .9


.  {return yytext[0];}

%%