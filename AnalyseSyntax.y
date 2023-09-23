%{
    #include"TS.h"
    int nb_ligne=1;
    int Col=0;
    int yyerror();
    int yylex(); 
    listTSidf listeidf=NULL; 
    listMcSep listeMc=NULL; 
    listMcSep listeSep=NULL;
    extern FILE* yyin;
    char *sauveType;
    
%}

%union{
int entier;   
float reel;
char* str; 
char cara; 

struct {
int entier;
float reel;
int type;

}Cal;

struct{
int taille;
char tab[30][30];
}io;

}


%type <Cal>FactArth 
%type <Cal>TermArth
%type <Cal>ExpArth
%type <io>ListeIdf
%type <io>listIDF
%token mc_iden mc_div mc_progId mc_data mc_workStg mc_sect mc_const mc_int mc_float mc_char mc_str mc_size mc_line mc_proc mc_accept mc_display mc_if mc_else mc_end mc_move mc_to mc_stopRun mc_ge mc_g mc_le mc_l mc_eq mc_di mc_and mc_or mc_not 
%token vrg point pipe pFer pOuv arobase egal plus etoile slash tiret deuxPoints err End_Of_File
%token <entier>entier <reel>reel <cara>cara <str>chaine <str>idf

%start S
%%

S : ProgDiv DecDiv InsDiv mc_stopRun point End_Of_File {afficher(0);afficher(1);afficher(2);printf("\n\n\n-----------------------------------Compilation reussite---------------------------------\n\n\n");  YYACCEPT;}
;

ProgDiv : mc_iden mc_div point mc_progId point idf point
;

DecDiv : mc_data mc_div point mc_workStg mc_sect point ListDec 
;

ListDec : ListDec Dec 
|
;

Dec : ListVar
| Const
| TabVar
;


ListVar : idf pipe ListVar {if(DoubleDecala($1)==0)
            InsererType($1,sauveType,1);
            else { 
                printf("\n Erreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}}
| idf Type point    {if(DoubleDecala($1)==0)
            InsererType($1,sauveType,1);
            else{  
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);;afficher(0);afficher(1);afficher(2);exit(-1);}
                }
;

Type : mc_int {sauveType=strdup("INTEGER");}
| mc_float {sauveType=strdup("FLOAT");}
| mc_char {sauveType=strdup("CHAR");}
| mc_str {sauveType=strdup("STRING");}
;

Const : mc_const idf egal entier point  {if(DoubleDecala($2)==0){InsererType($2,"INTEGER",0);
                char temp[100];
                sprintf(temp, "%d", $4);
                InsererVal($2,temp);
                }
            
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",$2,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}}
| mc_const idf egal reel point {if(DoubleDecala($2)==0){
                InsererType($2,"FLOAT",0);
                char temp[100];
                sprintf(temp,"%f",$4);
                InsererVal($2,temp);}
            
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",$2,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}}
| mc_const idf egal cara point{if(DoubleDecala($2)==0){
            char temp[2];
            temp[0]=$4;
            temp[1]='\0';
            InsererVal($2,temp);
            InsererType($2,"CHAR",0);}
            
            
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",$2,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}}
| mc_const idf egal chaine point {if(DoubleDecala($2)==0){InsererType($2,"STRING",0);InsererVal($2,$4);}
            
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",$2,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}}
| mc_const idf Type point {if(DoubleDecala($2)==0){
            InsererType($2,sauveType,-2);
            }
            
            
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] : %s\n\n",$2,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}}
;

TabVar : idf mc_line entier vrg mc_size entier Type point{if(DoubleDecala($1)==0)
            InsererType($1,sauveType,2);
            else { 
                printf("\nErreur semantique: Double declaration a la ligne [%d] et a la colonne [%d] :  %s\n\n",$1,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}
              if($6<=0){printf("\nErreur semantique: Taille du tableau est negatif a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}
              InsererBorneTaille($1, $3,$6); 
                
                
                }
;

InsDiv : mc_proc mc_div point ListIns
;

ListIns : ListIns InstAff 
| ListIns InstIf
| ListIns InstFor
| ListIns InstAcc
| ListIns InstDis
|
;

InstAff : idf egal ExpArth point {

    if(Declarer($1)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkVar($1)!=1 && checkVar($1)!=-2){
    
   printf("Erreur semantique: Affectation dans une constante a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}


if(!checkType($1,"INTEGER")){if($3.type!=0){printf("Erreur semantique: Compatibilite de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}}
if($3.type==1){if(checkType($1,"FLOAT")){printf("Erreur semantique: Compatibilite de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}}

if(checkVar($1)==-2){
    if(!checkType($1,"INTEGER")) {char temp[30]; sprintf(temp,"%d",$3.entier);InsererType($1,"INTEGER",0);}else{char temp[30]; sprintf(temp,"%f",$3.reel);InsererType($1,"FLOAT",0);}
    
}



}

| idf egal cara point{

    if(Declarer($1)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkVar($1)!=1 && checkVar($1)!=-2){
   
   printf("Erreur semantique: Affectation dans une constante a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkType($1,"CHAR")){

printf("Erreur semantique: Compatibilité de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);

}

if(checkVar($1)==-2){char temp[30]; sprintf(temp,"%c",$3);InsererType($1,"CHAR",0);}




}

| idf egal chaine point{

    if(Declarer($1)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] :  %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkVar($1)!=1){
   printf("Erreur semantique: Affectation dans une constante a la ligne [%d] et a la colonne [%d] :  %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}

if(checkType($1,"STRING")){

printf("Erreur semantique: Compatibilité de Type a la ligne [%d] et a la colonne [%d] :  %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);

}
if(checkVar($1)==-2){char temp[1024]; sprintf(temp,"%s",$3);InsererType($1,"STRING",0);}

}
;

InstIf : mc_if ExpLog deuxPoints ListIns mc_else deuxPoints ListIns mc_end point
;

InstFor : mc_move idf mc_to idf deuxPoints ListIns mc_end point {if(Declarer($2)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$2);afficher(0);afficher(1);afficher(2);exit(-1);
}

if(Declarer($4)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$4);afficher(0);afficher(1);afficher(2);exit(-1);
}

if(checkType($2,"INTEGER")){

printf("Erreur semantique: Compatibilité de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$2);afficher(0);afficher(1);afficher(2);exit(-1);

}

if(checkType($4,"INTEGER")){

printf("Erreur semantique: Compatibilité de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$4);afficher(0);afficher(1);afficher(2);exit(-1);

}

}

| mc_move idf mc_to entier deuxPoints ListIns mc_end point {if(Declarer($2)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$2);afficher(0);afficher(1);afficher(2);exit(-1);
}


if(checkType($2,"INTEGER")){

printf("Erreur semantique: Compatibilité de Type a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$2);afficher(0);afficher(1);afficher(2);exit(-1);

}


}
| mc_move entier mc_to entier deuxPoints ListIns mc_end point
;

ExpArth : ExpArth plus TermArth      {
    if($1.type==0 && $3.type==0){$$.type=0; $$.entier=$1.entier+$3.entier;}
    else{$$.type=1; $$.reel=$1.reel+$3.reel;}}       
| ExpArth tiret TermArth {
    if($1.type==0 && $3.type==0){$$.type=0; $$.entier=$1.entier-$3.entier;}
    else{$$.type=1; $$.reel=$1.reel-$3.reel;}}
    
| TermArth {if($1.type==0){$$.type=0;$$.entier=$1.entier;}else{$$.type=1;$$.reel=$1.reel;}}
;

TermArth : TermArth etoile FactArth  {
    if($1.type==0 && $3.type==0){$$.type=0; $$.entier=$1.entier*$3.entier;}
    else{$$.type=1; $$.reel=$1.reel*$3.reel;}
} 
| TermArth slash FactArth    {
    if($1.type==0 && $3.type==0){
        if($3.entier==0){printf("Erreur semantique: Division par zero a la ligne [%d] et a la colonne [%d]\n\n",nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);} else{
        $$.type=0; $$.entier=$1.entier/$3.entier;}}
    else{
        if($3.reel==0){printf("Erreur semantique: Division par zero a la ligne [%d] et a la colonne [%d]\n\n",nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);} else{
        $$.type=1; $$.reel=$1.reel/$3.reel;}}     


        
 }

| FactArth {if($1.type==0){$$.type=0;$$.entier=$1.entier;}else{$$.type=1;$$.reel=$1.reel;}}
;



FactArth : idf  {   if(Declarer($1)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);
}

if(checkType($1,"INTEGER")==0 && (checkVar($1)==1 || checkVar($1)==0)){$$.type=0; $$.entier=atoi(rechercheVal($1));} else{
if(checkType($1,"FLOAT")==0 && (checkVar($1)==1 || checkVar($1)==0)){$$.type=1; $$.entier=atof(rechercheVal($1));}else{

if(checkType($1,"INTEGER")!=0 && checkType($1,"FLOAT")!=0){printf("Erreur semantique: Compatibilite de Type pour a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}
if(checkVar($1)==-2){printf("Erreur semantique: Constante non initialisee a la ligne [%d] et a la colonne [%d] :  %s\n\n",$1,nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}
if(checkVar($1)==2){printf("Erreur semantique: est un Tableau a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$1);afficher(0);afficher(1);afficher(2);exit(-1);}
}

}

}                   
| entier {$$.entier=$1; $$.type=0;}
| reel {$$.reel=$1; $$.type=1;}
| pOuv ExpArth pFer {if($2.type==0){$$.type=0;$$.entier=$2.entier;}else{$$.type=1;$$.reel=$2.reel;}}
;



ExpLog : ExpLog mc_or TeLog
| TeLog
;

TeLog : TeLog mc_and FaLog
| FaLog
;

FaLog : mc_not FaLog
| pOuv ExpCom pFer
| pOuv ExpLog pFer
;

ExpCom : ExpArth mc_eq ExpArth
| ExpArth mc_di ExpArth
| ExpArth mc_le ExpArth
| ExpArth mc_ge ExpArth
| ExpArth mc_l ExpArth
| ExpArth mc_g ExpArth
;







InstAcc : mc_accept pOuv chaine deuxPoints arobase idf pFer point {if(Declarer($6)==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$6);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkVar($6)!=1 && checkVar($6)!=-2) {printf("Erreur semantique: Lecture d'un Tableau/Constante a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$6);afficher(0);afficher(1);afficher(2);exit(-1);} 
if(strcmp($3,"%") && strcmp($3,"#") && strcmp($3,"$") && strcmp($3,"&") ){ printf("Erreur semantique: Chaine errone a la ligne [%d] et a la colonne [%d] : \"%s\"\n\n",nb_ligne,Col,$3);afficher(0);afficher(1);afficher(2);exit(-1);}
if(ioType($6, $3 [0])){printf("Erreur semantique: Signe de formatage errone avec Type IDF  a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$6);afficher(0);afficher(1);afficher(2);exit(-1);}
}
;

InstDis : mc_display pOuv chaine listIDF pFer point {char temp[30];
int j=0;
for(int i=0;i<strlen($3);i++){
if($3 [i]=='$' || $3 [i]=='#' || $3 [i]=='%' || $3 [i]=='&' ){
temp[j]= $3 [i] ;
j++;

}
temp[j]='\0';

}

if(strlen(temp)!=$4.taille){printf("Erreur semantique: Formatage Errone a la ligne [%d] et a la colonne [%d] \n\n",nb_ligne,Col);afficher(0);afficher(1);afficher(2);exit(-1);}



for(int i=0;i<strlen(temp);i++){

if(Declarer($4.tab[i])==0){
   printf("Erreur semantique: IDF non declare a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$4.tab[i]);afficher(0);afficher(1);afficher(2);exit(-1);
}
if(checkVar($4.tab[i])==2) {printf("Erreur semantique: Ecriture d'un Tableau a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$4.tab[i]);afficher(0);afficher(1);afficher(2);exit(-1);} 
if(ioType($4.tab[i], temp[i])){printf("Erreur semantique: Signe de formatage errone avec Type IDF  a la ligne [%d] et a la colonne [%d] : %s\n\n",nb_ligne,Col,$4.tab[i]);afficher(0);afficher(1);afficher(2);exit(-1);}
}





}





;

listIDF: deuxPoints ListeIdf {$$=$2;}
| {$$.taille=0;}
;
ListeIdf : ListeIdf pipe idf {$$.taille++; strcpy($$.tab[$$.taille-1],$3);}
| idf {$$.taille=1; strcpy($$.tab[$$.taille-1],$1);}
;



%%
int main()
{
yyin=fopen("exemple.txt","rt");
yyparse();
return 0;
}
int yywrap ()
{}
int yyerror ( char*  msg )  
{
    afficher(0);afficher(1);afficher(2);
    printf ("Erreur Syntaxique: a la ligne [%d] et a la colonne [%d] \n\n", nb_ligne,Col);
}
