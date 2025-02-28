#include "aula2exer1_EduardoSilva_221008580.h"

int main(){
    char option;

    while(1){
        system(CLEAR);
        printf("\t\tAtividade-1 SBD1\n\n");

        printf("0 - Sair\n");
        printf("1 - Cadastrar proprietario\n");
        printf("2 - Cadastrar automovel\n");
        printf("3 - Listar automoveis por proprietario\n\n");
        printf("Selecione uma opção: ");
        scanf("%hd", &option);

        if(option == 0)
            return 0;
        else if(option == 1)
            option_owner_register();
        else if(option == 2)
            option_car_register();
        else if(option == 3)
            option_print_data();
        else
            continue;
    }
}
