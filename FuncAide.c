
#include"TS.h"


listTSidf CreateCellidf(){
listTSidf temp=NULL;
temp=(listTSidf)malloc(sizeof(idfCell));
if(temp ==NULL){
printf(" Erreur à la creation de la table de symbole IDF/CONST \n");
exit(-1);

}

    return temp;
}

void InsererEntite(char* entite, char* nature, char* type, char* val, int borneinf, int taille, int boolCons, int y){

switch(y){

case 0 : ;
listTSidf temp0=CreateCellidf();
temp0->suivant=listeidf;
temp0->entite=strdup(entite);
temp0->nature=strdup(nature);
temp0->type=strdup(type);
temp0->val=strdup(val);
temp0->borneinf = borneinf;
temp0->taille= taille;
temp0->boolConstVar= boolCons;
listeidf=temp0;
break;

case 1:;
listMcSep temp1=CreateCellMcSep();
temp1->suivant=listeMc;
temp1->entite=strdup(entite);
temp1->nature=strdup(nature);
listeMc=temp1;


break;

case 2:;
listMcSep temp2=CreateCellMcSep();
temp2->suivant=listeSep;
temp2->entite=strdup(entite);
temp2->nature=strdup(nature);
listeSep=temp2;


break;



}

}


void RechercherEntite(char* entite, char* nature, char* type, char* val, int borneinf, int taille, int boolCons, int y){

switch(y){

case 0 :;
listTSidf temp0=listeidf;
while(temp0){

if(!strcmp(temp0->entite,entite)) break;

temp0=temp0->suivant;
}
if(temp0) printf(" L'entite existe deja\n");
else
InsererEntite(entite,nature,type,val,borneinf,taille,boolCons,y);
break;

case 1 :;
listMcSep temp1=listeMc;
while(temp1){

if(!strcmp(temp1->entite,entite)) break;

temp1=temp1->suivant;
}
if(temp1) printf(" L'entite existe deja\n");
else
InsererEntite(entite,nature,type,val,borneinf,taille,boolCons,y);
break;


case 2 :;
listMcSep temp2=listeSep;
while(temp2){

if(!strcmp(temp2->entite,entite)) break;

temp2=temp2->suivant;
}
if(temp2) printf(" L'entite existe deja\n");
else
InsererEntite(entite,nature,type,val,borneinf,taille,boolCons,y);
break;


}


}


void afficher(int y){

switch (y){
case 0:;
listTSidf temp0=listeidf;
printf("\n\n_______________________________________________________________________________________________________\n");
printf("\t| Nom_Entite | Code_Entite | Type_Entite | Val_Entite | Borne_Entite | Taille_Entite | Bool_Entite |\n");
printf("_______________________________________________________________________________________________________\n");
while(temp0){

printf("\t| %10s | %11s | %11s | %9s | %12d | %12d | %11d\n",temp0->entite,temp0->nature,temp0->type,temp0->val,temp0->borneinf,temp0->taille,temp0->boolConstVar);

temp0=temp0->suivant;


}  

    break;

case 1:;
listMcSep temp1=listeMc;
printf("\n\n_____________________________\n");
printf("\t| Nom_Entite | Code_Entite |\n");
printf("_____________________________\n");
while(temp1){

printf("\t| %10s | %11s |\n",temp1->entite,temp1->nature);

temp1=temp1->suivant;


}  

    break;

case 2:;
listMcSep temp2=listeSep;
printf("\n\n_____________________________\n");
printf("\t| Nom_Entite | Code_Entite |\n");
printf("_____________________________\n");
while(temp2){

printf("\t| %10s | %11s |\n",temp2->entite,temp2->nature);

temp2=temp2->suivant;


}  

    break;




    


}





}



listMcSep CreateCellMcSep(){
listMcSep temp=NULL;
temp=(listMcSep)malloc(sizeof(McSepCell));
if(temp ==NULL){
printf(" Erreur à la creation de la table de symbole IDF/CONST \n");
exit(-1);

}

    return temp;
}



int DoubleDecala(char *entite){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0 && strcmp(temp->type,"")!=0) 
return 1;

    temp=temp->suivant;
}



return 0;

}


void InsererType(char *entite, char* type,int bool){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

temp->type=strdup(type);
temp->boolConstVar=bool;
break;}

    temp=temp->suivant;
}



    
}



void InsererBorneTaille(char *entite, int borne,int taille){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

temp->borneinf =borne;
temp->taille=taille;
break;}

    temp=temp->suivant;
}



    
}


void InsererVal(char *entite, char* Val){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

temp->val=strdup(Val);

break;}

    temp=temp->suivant;
}



    
}


int checkVar(char *entite){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

return temp->boolConstVar;

break;}

    temp=temp->suivant;
}

return -1;


    
}

int Declarer(char *entite){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0) 
{if( strcmp(temp->type,"")==0)
return 0;
else 
return 1;}

  temp=temp->suivant;  
}



return 0;

}


int checkType(char *entite, char *type){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){
if(strcmp(temp->type,type)==0)return 0;
else return 1;


}

    temp=temp->suivant;
}

return -1;


    
}


char* rechercheVal(char *entite){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

return temp->val;


}

    temp=temp->suivant;
}

return NULL;





}


int ioType(char *entite, char c){

listTSidf temp=listeidf;

while(temp){
 
if(strcmp(temp->entite, entite)==0){

switch(c){

case '$':;
return strcmp(temp->type,"INTEGER");
break;
case '%':;
return strcmp(temp->type,"FLOAT");
break;

case '#':;
return strcmp(temp->type,"STRING");
break;

case '&':;
return strcmp(temp->type,"CHAR");
break;



}


}

    temp=temp->suivant;
}


return 1;



}

