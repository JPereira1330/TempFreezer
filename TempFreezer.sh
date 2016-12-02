#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 1.0.1

###########################
# CONFIGURAÇÕES DO SCRIPT #
###########################

diretorio="/etc/TempFreezer"                # Caminho onde sera armazenado os dados do script
contador=$diretorio"/contador.txt"          # Arquivo onde sera salvo a contagem
userBackup=$diretorio"/backup/biblioteca"   # Pasta onde fica toda 
userDir="/home/biblioteca"           	    # Caminho do diretorio que sera apagado
manterPasta="Downloads"                     # Diretorio que não sera apagado
usuario="biblioteca"			    # Nome do usuario
vezesIniciado=5                             # Quantia de inicializações do sistema para o reset

####################
# INICIO DO SCRIPT #
####################

# Verifica se arquivo de contagem existe.
if [ -d $diretorio -o -f $contador ]; then
	
    	# Captura primeira linha do contador
	linha=$(head $contador)

    	# Se 'linha' for maior ou igual do que 'vezesiniciado'
	if [ $linha -gt $vezesIniciado -o $linha -eq $vezesIniciado ];
	then
		find ~/* -maxdepth 0 -name $manterPasta -o -exec rm -rf '{}' ';'
        	cp -R $userBackup /home/	
		chown -R $usuario $userDir	
		chgrp -R $usuario $userDir	
		sed -i 's/'"$linha"'/'"1"'/g' $contador
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
