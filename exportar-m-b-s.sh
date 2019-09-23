#!/bin/bash
destino="./databases"
usuario="root"
echo "Informe a senha do usuário $usuario para Mysql:"
read senha
log="$destino/erro.log"
 
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
 
# Cria diretório para armazenamento dos bancos se não existe
if [ ! -d $destino ];then
    mkdir $destino
fi
 
for i in $(mysql -u$usuario -p$senha -e "show databases")
do
        #echo "Executando dump do banco de dados $i"
        mysqldump -u$usuario -p$senha $i > $destino/$i > /dev/null 2>&1
        if [ $? -ne 0 ];then
                echo "Erro ao exportar $i"
                echo "Erro ao exportar $i" >> $log
        fi
        echo "Banco de dados $i exportado."
done
 
echo "Sucesso!"
echo "Verifique o diretório $destino"
