#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PERSON_FILE "dataset-person.bin"
#define CAR_FILE "dataset-car.bin"

#ifdef _WIN32
    #define CLEAR "cls"
#elif __linux__
    #define CLEAR "clear"
#endif

typedef struct{
    int age;
    char name[110], address[110], phone[110], cpf[110];
}Person;

typedef struct{
    char owner_cpf[110], brand[110], model[110], color[110], placa[110], n_chassis[110];
}Car;


void write_person(char *file_name, Person *data){
    FILE *file = fopen(file_name, "ab");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }

    fwrite(data, sizeof(Person), 1, file);
    fclose(file);
}

Person *read_person(char *file_name){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Person *data = malloc(sizeof(Person));

    fread(data, sizeof(Person), 1, file);
    fclose(file);
    return data;
}

Person *print_all_persons(char *file_name){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Person *data = malloc(sizeof(Person));

    while(fread(data, sizeof(Person), 1, file) > 0){
        printf("Name: %s\n", data->name);
        printf("Address: %s\n", data->address);
        printf("Phone: %s\n", data->phone);
        printf("CPF: %s\n", data->cpf);
    }
    fclose(file);
    return data;
}

Person *get_person_by_cpf(char *file_name, char *cpf){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Person *data = malloc(sizeof(Person));

    while(fread(data, sizeof(Person), 1, file) > 0){
        if(!strcmp(cpf, data->cpf)){
            fclose(file);
            return data;
        }
    }
    fclose(file);
    return NULL;
}

char **get_all_cpf_persons(char *file_name, int n_persons){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Person *data = malloc(sizeof(Person));
    char **cpfs = (char **)malloc(sizeof(char*)*n_persons);
    int i=0;

    while(fread(data, sizeof(Person), 1, file) > 0){
        char *cpf = malloc(sizeof(char)*110);
        strcpy(cpf, data->cpf);
        cpfs[i++] = cpf;
    }
    fclose(file);
    return cpfs;
}

Person owner_register(){
    Person *p = malloc(sizeof(Person));

    printf("Cadastro de Proprietário\n\n");

    printf("Nome: ");
    scanf(" %100[^\n]", p->name);

    printf("Idade: ");
    scanf("%d", &p->age);

    printf("Endereço: ");
    scanf(" %100[^\n]", p->address);

    printf("Telefone: ");
    scanf(" %100[^\n]", p->phone);

    printf("CPF: ");
    scanf(" %100[^\n]", p->cpf);

    write_person("dataset-person.bin", p);
    return *p;
}

void write_car(char *file_name, Car *data){
    FILE *file = fopen(file_name, "ab");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }

    fwrite(data, sizeof(Car), 1, file);
    fclose(file);
}

Car *read_car(char *file_name){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Car *data = malloc(sizeof(Car));

    fread(data, sizeof(Car), 1, file);
    fclose(file);
    return data;
}

void print_all_cars_from_person(char *file_name, char *cpf){
    FILE *file = fopen(file_name, "rb");
    if(file == NULL){
        fprintf(stderr, "Erro ao abrir o arquivo %s\n", file_name);
        return;
    }
    Car *data = malloc(sizeof(Car));
    Person *p = get_person_by_cpf(PERSON_FILE, cpf);

    print_border_horizontal("==");
    
    printf("\n\tProprietario\n\n");
    printf("CPF: %s\n", p->cpf);
    printf("Nome: %s\n", p->name);
    printf("Idade: %d\n", p->age);
    printf("Endereco: %s\n", p->address);
    printf("Telefone: %s\n\n", p->phone);

    print_border_horizontal("--");
    printf("\n\tVeiculos\n\n");

    while(fread(data, sizeof(Car), 1, file) > 0){
        if(!strcmp(cpf, data->owner_cpf)){
            printf("Marca: %s\n", data->brand);
            printf("Modelo: %s\n", data->model);
            printf("Cor: %s\n", data->color);
            printf("Placa: %s\n", data->placa);
            printf("Chassis: %s\n\n", data->n_chassis);
        }
    }
    printf("\n");
    print_border_horizontal("==");
}

Car car_register(){
    Car *c = malloc(sizeof(Car));

    printf("\nCadastro de Veiculos\n\n");

    printf("CPF do Proprietário: ");
    scanf(" %100[^\n]", c->owner_cpf);

    printf("Marca: ");
    scanf(" %100[^\n]", c->brand);

    printf("Modelo: ");
    scanf(" %100[^\n]", c->model);

    printf("Cor: ");
    scanf(" %100[^\n]", c->color);

    printf("Placa: ");
    scanf(" %100[^\n]", c->placa);

    printf("Número do chassis: ");
    scanf(" %100[^\n]", c->n_chassis);

    write_car("dataset-car.bin", c);
    return *c;
}

void print_border_horizontal(char *border){
    for(int i=0; i<30; ++i)
        printf(border);
    printf("\n");
}


int main(){
    int n_persons;

    remove(PERSON_FILE);
    remove(CAR_FILE);

    printf("\t\tAtividade-1 SBD1\n\n");

    printf("Digite a quantidade de proprietarios que deseja cadastrar: ");
    scanf("%d", &n_persons);

    for(int i=0; i<n_persons; ++i){
        int n_cars;
        owner_register();

        printf("\nDigite a quantidade de veiculos que deseja cadastrar: ");
        scanf("%d", &n_cars);

        for(int k=0; k<n_cars; ++k)
            car_register();
    }

    system(CLEAR);
    printf("\t\tAtividade-1 SBD1\n\n");
    char **all_persons = get_all_cpf_persons(PERSON_FILE, n_persons);
    for(int i=0; i<n_persons; ++i)
        print_all_cars_from_person(CAR_FILE, all_persons[i]);
}
