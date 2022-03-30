#!/usr/bin/env bash

DB=alunos-soa-2021-2.csv

DIR_NAME=$(dirname $(realpath $0));
source ${DIR_NAME}/menus.sh;

main(){
    main_menu
    read -p "Enter with an option(1 - 5): " op
    while [ $op -ne 5 ]; do

        case "$op" in 
            1)
                create;;
            2)
                list;;
            3)
                update;;
            4)
                delete;;
            5)
                exit;;
        esac
        main_menu
        read -p "Enter an option(1 - 5): " op
    done
}

create(){
    read -p "Enter user data(nome,idade,salario,app): " usuario;
    if ! egrep -q "^$user," $DB; then
        read -p "Matricula: " matricula
        read -p "Nome: " nome
        read -p "Aniversario: " aniversario
    fi
    echo "$usuario,$matricula,$nome,$aniversario" >> $DB;
}

list(){
    # column -t -s, $DB;
    tail +2 $DB | while IFS=, read usr mat nome niver;do
        cat << FIM
Dados de $usr:
- Matricula: $mat
- Nome: $nome
- Aniversario: $niver
$
FIM
    done
}

update(){
    read -p "Enter a old user data to update: " old;
    read -p "Enter a new user data to update: " new;
    egrep -q "^$old," $DB | "s/${old}/${new}/" $DB; 
}

delete(){
    read -p "Enter a username: " user;
    if egrep -q "^$user," $DB; then
        # echo "done ${user}";
        sed -i "/^${user},/d" $DB;
    fi
}

main