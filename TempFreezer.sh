#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 0.0.4 Dev

###########################
# CONFIGURAÇÕES DO SCRIPT #
###########################

diretorio="/etc/TempFreezer"                # Diretorio onde sera armazenado os dados do script
contador=$diretorio"/contador.txt"          # Arquivo onde sera salvo a contagem
userBackup=$diretorio"/backup.tar.gz"       # Pasta do usuario zipada em tar.gz 
manterArq[0]="/home/biblioteca/Downloads"   # Array de diretorio que não seram apagados
vezesIniciado=5                             # Quantia de inicializações do sistema para o reset

####################
# INICIO DO SCRIPT #
####################

# Verifica se arquivo de contagem existe.
if [ -d $diretorio -o -f $contador ]; then
	
	linha=$(head $contador) # Captura primeira linha do contador

	if [ $linha -gt $vezesIniciado -o $linha -eq $vezesIniciado ]; # Se 'linha' for maior ou igual do que 'vezesiniciado'
	then
        echo "teste"
	else
		linha_new=$(($linha + 1))
		sed -i 's/'"$linha"'/'"$linha_new"'/g' $contador
	fi
else

    # Cria uma pasta caso nao exista
	if [ ! -d $diretorio ]; then
        mkdir $diretorio
    fi

    # Cria o arquivo e inicializa ele com 1 caso não exista
	echo "1" >> $contador
	chmod 755 $contador

fi
