%{
#include <stdio.h>
#include <string.h>

//name means var name 
//if var is array ,size will >=1,esle size == 1
struct VARTAB{
	char name[30];	      
	int size;            
} varmp[30];

//vsize  means ,now declare how many var
int vsize = 0;

%}

%union {
	int varno;
	double val;
	char varname[30];
    char vartype[10];
}


%token <varname> NAME 
%token <vartype> VARTYPE
%token <val> NUMBER

%token PROGRAM BEGINT END 
%token DECLARE AS 

%%

Program : 	PROGRAM micro_prog BEGINT stmt_list END 	{ printf("\n**  Done  **\n");}
	;

micro_prog :	NAME        { printf("\t\tSTART %s\n", $1)}
	;

stmt_list :	stmt 	
	|	stmt stmt_list 	
	;

stmt : 	    vardeclare ';'
	;


vardeclare :  DECLARE varlist AS VARTYPE 	
	{
		for(int i = 0; i < vsize; ++i ){
			if( varmp[i].size == 1 )
			{
				printf("\t\tDeclare %s, %s\n", varmp[i].name, $4);
			}
			else
			{
				printf("\t\tDeclare %s, %s_array, %d\n", varmp[i].name, $4, varmp[i].size);
			}
		}	
        //clear var array
		vsize = 0;		
	}
	;


varlist	:	var	
    |       var ',' varlist 
    ;


var :	NAME
	{		
		strcpy( varmp[vsize].name, $1);
		varmp[vsize].size =  1;
		vsize += 1;
	}
	| 	NAME '[' NUMBER ']'
	{
		strcpy( varmp[vsize].name, $1);
		varmp[vsize].size = $3;
		vsize += 1;
	}
	;
%%

	
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern FILE *fopen(const char *filename, const char *mode);

int main(int argc ,char *argv[]){

    yyin = fopen(argv[1], "r");
    
    do{
		yyparse();

    }while(!feof(yyin));
    
    
    fclose(yyin);
    return 0;
}