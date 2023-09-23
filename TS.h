
#ifndef TS_H
#define TS_H

#include<string.h>
#include<stdlib.h>
#include<stdio.h>





typedef struct idfCell* listTSidf;
typedef struct idfCell{

char *entite;
char *nature;
char *type;
char *val;     
int borneinf;
int taille;
int boolConstVar; 
listTSidf suivant;

}idfCell;

typedef struct McSepCell* listMcSep;
typedef struct McSepCell{

char *entite;
char *nature;
 
listMcSep suivant;

}McSepCell;











extern listTSidf listeidf;
extern listMcSep listeMc; 
extern listMcSep listeSep;

listTSidf CreateCellidf();
void InsererEntite(char* entite, char* nature, char* type, char* val, int borneinf, int taille, int boolCons, int y);
void RechercherEntite(char* entite, char* nature, char* type, char* val, int borneinf, int taille, int boolCons, int y);
void afficher(int y);

listMcSep CreateCellMcSep();
int DoubleDecala(char *entite);
void InsererType(char *entite, char* type,int bool);
void InsererBorneTaille(char *entite, int borne,int taille);
void InsererVal(char *entite, char* Val);
int checkVar(char *entite);
int Declarer(char *entite);
int checkType(char *entite, char *type);
char* rechercheVal(char *entite);
int ioType(char *entite, char c);







#endif


