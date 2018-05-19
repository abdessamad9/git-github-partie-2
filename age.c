#include <stdio.h>
#include <stdlib.h>

int main(){
	printf("entrez votre date de naissance svp : ");
	int date_de_naissance;
	scanf("%d",&date_de_naissance);
	printf("\n vous avez %d ans.\n", 2018 - date_de_naissance);
	return 0;
}

