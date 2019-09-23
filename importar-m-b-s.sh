#!/bin/bash
origem="databases"
read senha
 
if [ -z $senha ]; then
        echo "Define a senha do Root para Mysql"
        exit
else
        echo "Testando senha..."
        mysql -uroot -p$senha -e "show databases;" > /dev/null 2>&1
        if [ $? -ne 0 ];then
                echo "Nao pode conectar ao Mysql com password informado."
                exit
        fi
        echo "Prosseguindo..."
fi
 
for i in $(ls $origem)
do
        echo "Criando banco de dados $i"
        mysql -uroot -p$senha -e "CREATE DATABASE $i CHARACTER SET utf8 COLLATE utf8_general_ci;"
        echo "Importando banco de dados $i"
        mysql -uroot -p$senha -e "use $i ; source $origem/$i;"
done
echo "Terminado."
