#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PERSON_FILE "dataset-person.bin"
#define CAR_FILE "dataset-car.bin"

#ifdef _WIN32
    #define CLEAR "cls"
#else
    #define CLEAR "clear"
#endif

typedef struct{
    int PERSONS_COUNT, CARS_COUNT;
}DB_DATA;

typedef struct{
    char name[110], cpf[110];
}Person;

typedef struct{
    char owner_cpf[110], brand[110], model[110], placa[110];
}Car;


int get_total_persons(){
    FILE *file = fopen(PERSON_FILE, "rb");
    if(file == NULL)
        return 0;
    fseek(file, 0, SEEK_END);
    int total = ftell(file)/sizeof(Person);
    fclose(file);
    return total;
}

int get_total_cars(){
    FILE *file = fopen(CAR_FILE, "rb");
    if(file == NULL)
        return 0;
    fseek(file, 0, SEEK_END);
    int total = ftell(file)/sizeof(Car);
    fclose(file);
    return total;
}

void set_db_data(DB_DATA *data){
    FILE *file = fopen("db_data.bin", "wb");
    if(file == NULL)
        return;
    fwrite(data, sizeof(DB_DATA), 1, file);
    fclose(file);
}

DB_DATA *get_db_data(){
    FILE *file = fopen("db_data.bin", "rb");
    if(file == NULL)
        return NULL;
    DB_DATA *data = (DB_DATA*)malloc(sizeof(DB_DATA));
    fread(data, sizeof(DB_DATA), 1, file);
    fclose(file);
    return data;
}

void write_person(Person *data){
    FILE *file = fopen(PERSON_FILE, "ab");
    if(file == NULL)
        return;
    fwrite(data, sizeof(Person), 1, file);
    fclose(file);
}

Person *get_person_by_cpf(char *cpf){
    FILE *file = fopen(PERSON_FILE, "rb");
    if(file == NULL)
        return NULL;
    Person *p = (Person*)malloc(sizeof(Person));

    while(fread(p, sizeof(Person), 1, file) > 0){
        if(!strcmp(p->cpf, cpf)){
            fclose(file);
            return p;
        }
    }
    fclose(file);
    return NULL;
}

char **get_all_cpf_persons(){
    FILE *file = fopen(PERSON_FILE, "rb");
    if(file == NULL)
        return NULL;
    Person *data = (Person*)malloc(sizeof(Person));
    char **cpfs = (char**)malloc(sizeof(char*)*1<<21);
    int i=0;

    while(fread(data, sizeof(Person), 1, file) > 0){
        char *cpf = (char*)malloc(sizeof(char)*110);
        strcpy(cpf, data->cpf);
        cpfs[i++] = cpf;
    }
    fclose(file);
    return cpfs;
}

Person owner_register(){
    Person *p=(Person*)malloc(sizeof(Person)), *s=((void*)1);

    printf("Cadastro de Proprietário\n\n");

    while(s != NULL){
        printf("CPF: ");
        scanf(" %100[^\n]", p->cpf);
        s = get_person_by_cpf(p->cpf);
        if(s == NULL)
            break;
        printf("CPF já cadastrado\n");
    }

    printf("Nome: ");
    scanf(" %100[^\n]", p->name);

    write_person(p);
    return *p;
}

void write_car(Car *data){
    FILE *file = fopen(CAR_FILE, "ab");
    if(file == NULL)
        return;
    fwrite(data, sizeof(Car), 1, file);
    fclose(file);
}

Car *get_car_by_placa(char *placa){
    FILE *file = fopen(CAR_FILE, "rb");
    if(file == NULL)
        return NULL;
    Car *p = (Car*)malloc(sizeof(Car));

    while(fread(p, sizeof(Car), 1, file) > 0){
        if(!strcmp(p->placa, placa)){
            fclose(file);
            return p;
        }
    }
    fclose(file);
    return NULL;
}


void print_all_cars_from_person(char *cpf){
    FILE *file = fopen(CAR_FILE, "rb");
    if(file == NULL)
        return;
    Car *data = (Car*)malloc(sizeof(Car));
    Person *p = get_person_by_cpf(cpf);

    print_border_horizontal("==");
    
    printf("\n\tProprietario\n\n");
    printf("CPF: %s\n", p->cpf);
    printf("Nome: %s\n", p->name);

    print_border_horizontal("--");
    printf("\n\tVeiculos\n\n");

    while(fread(data, sizeof(Car), 1, file) > 0){
        if(!strcmp(cpf, data->owner_cpf)){
            printf("Marca: %s\n", data->brand);
            printf("Modelo: %s\n", data->model);
            printf("Placa: %s\n\n", data->placa);
        }
    }
    printf("\n");
    print_border_horizontal("==");
}

Car car_register(){
    Car *c = (Car*)malloc(sizeof(Car));

    printf("\nCadastro de Veiculos\n\n");

    printf("CPF do Proprietário: ");
    scanf(" %100[^\n]", c->owner_cpf);

    printf("Marca: ");
    scanf(" %100[^\n]", c->brand);

    printf("Modelo: ");
    scanf(" %100[^\n]", c->model);

    printf("Placa: ");
    scanf(" %100[^\n]", c->placa);

    write_car(c);
    return *c;
}

void print_border_horizontal(char *border){
    for(int i=0; i<30; ++i)
        printf(border);
    printf("\n");
}

void option_owner_register(){
    int n_persons;

    system(CLEAR);
    printf("\t\tAtividade-1 SBD1\n\n");
    printf("Digite a quantidade de proprietarios que deseja cadastrar: ");
    scanf("%d", &n_persons);

    for(int i=0; i<n_persons; ++i)
        owner_register();
}

void option_car_register(){
    int n_cars;

    system(CLEAR);
    printf("\t\tAtividade-1 SBD1\n\n");
    printf("\nDigite a quantidade de veiculos que deseja cadastrar: ");
    scanf("%d", &n_cars);

    for(int k=0; k<n_cars; ++k)
        car_register();
}

void option_print_data(){
    system(CLEAR);
    printf("\t\tAtividade-1 SBD1\n\n");
    char **all_persons = get_all_cpf_persons();
    for(int i=0; i<get_total_persons(); ++i)
        print_all_cars_from_person(all_persons[i]);
    printf("\nDigite um caracter para continuar: ");
    scanf(" %*[^\n]");
}
