%{
	#include "TS.h"
	#include "AnalyseSyntax.tab.h"
	extern int nb_ligne;
	extern int Col;
	extern YYSTYPE yylval;
%}

lettreM [A-Z]
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettreM}({lettre}|{chiffre})*
com #.*!
entier ("("[+-]{chiffre}+")")|({chiffre}+)
reel ("("[+-]{chiffre}+"."{chiffre}+")")|({chiffre}+"."{chiffre}+)
chaine \"[^"\n]*\"
cara '.'

%%

"IDENTIFICATION"      { Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_iden;   }
"DIVISION"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_div;   }
"PROGRAM-ID"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_progId;   }
"DATA"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_data;   }
"WORKING-STORAGE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_workStg;   }
"SECTION"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_sect;   }
"CONST"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_const;   }
"INTEGER"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_int;   }
"FLOAT"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_float;   }
"CHAR"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_char;   }
"STRING"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_str;   }
"SIZE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_size;   }
"LINE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_line;   }
"PROCEDURE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_proc;   }

"ACCEPT"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_accept;   }
"DISPLAY"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_display;   }
"IF"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_if;   }
"ELSE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_else;   }
"END"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_end;   }
"MOVE"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_move;   }
"TO"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_to;   }
"STOP RUN"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_stopRun;   }
 
".GE."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_ge;   } 
".G."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_g;   } 
".LE."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_le;   } 
".L."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_l;   } 
".EQ."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_eq;   } 
".DI."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_di;   } 

".AND."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_and;   } 
".OR."      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_or;   } 
"NOT"      {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"MotClef","","",-1,-1,-1,1); return mc_not;   } 




{entier}   {  char* temp=strdup(yytext);	
	        if(yytext[0]=='('){temp=strncpy(temp,yytext+1,yyleng-2); temp[yyleng-2]='\0';}
			yylval.entier=atoi(temp);			
			Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"CONST","INTEGER",temp,-1,-1,-1,0);
			if(yylval.entier>32767 || yylval.entier<-32768){printf("Erreur Lexical: Entier depasse l'intervalle des entiers a la ligne %d a la colonne %d \n ",nb_ligne, Col);afficher(0);afficher(1);afficher(2); exit(-1);} return entier;   } 
{reel}   {  char* temp=strdup(yytext);	
	        if(yytext[0]=='('){temp=strncpy(temp,yytext+1,yyleng-2); temp[yyleng-2]='\0';}
			yylval.reel=atof(temp);
			
		 Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"CONST","FLOAT",temp,-1,-1,-1,0); return reel;   }
{cara}   {yylval.cara=yytext[1]; 
		 
	     Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"CONST","CHAR",yytext,-1,-1,-1,0); return cara;   }
{chaine}   { char* temp=strdup(yytext);	
	        if(yytext[0]=='"'){temp=strncpy(temp,yytext+1,yyleng-2); temp[yyleng-2]='\0';}
		   yylval.str=strdup(temp);
           
		   Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"CONST","STRING",temp,-1,-1,-1,0); return chaine;   }


{IDF}      { if (yyleng>8){ printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne, Col);afficher(0);afficher(1);afficher(2); exit(-1);}
             printf (" L'entite reconnue est \"%s\" \n", yytext); 
			 yylval.str=strdup(yytext);
			 Col= Col + strlen(yytext);
			 RechercherEntite(yytext,"IDF","","",-1,-1,-1,0);
			 
			 return idf;
		   }


,          {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return vrg;}
"."        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return point;}
"|"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return pipe;}
")"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return pFer;}
"("        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return pOuv;}

"@"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return arobase;}
"="        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return egal;}
"+"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return plus;}
"*"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return etoile;}
"/"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return slash;}
"-"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return tiret;}

":"        {Col= Col + strlen(yytext); printf (" L'entite reconnue est \"%s\" \n", yytext);RechercherEntite(yytext,"Separateur","","",-1,-1,-1,2); return deuxPoints;}
<<EOF>>    return End_Of_File;

[ \t]       Col= Col + strlen(yytext);
{com}      Col= Col + strlen(yytext);
\n        {Col= 1; nb_ligne++;}
. { printf (" Erreur lexicale : Entite non reconnue a la ligne [%d] et a la colonne [%d] l'entite : %s \n\n", nb_ligne, Col,yytext); return err;}







