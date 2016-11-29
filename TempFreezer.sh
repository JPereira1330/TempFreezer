#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 0.0.5 Dev

###########################
# CONFIGURAÇÕES DO SCRIPT #
###########################

diretorio="/etc/TempFreezer"                # Caminho onde sera armazenado os dados do script
contador=$diretorio"/contador.txt"          # Arquivo onde sera salvo a contagem
userBackup=$diretorio"/backup"              # Pasta onde fica toda 
userDir="/home/biblioteca"           	    # Caminho do diretorio que sera apagado
manterPasta="/Downloads"                    # Diretorio que não sera apagado
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
		rm -r $userDir!($manterArq)	# Deleta pasta do usuario
        	cp -R $userBackup /home/	# Copia a pasta backup do usuario para home
		chown -R $usuario $userDir	# Altera dono no diretorio
		chgrp -R $usuario $usuaDir	# Altera o grupo do diretorio
		sed -i 's/'"$linha"'/'"1"'/g' $contador
	else
		linha_new=$(($linha + 1))
		sed -i 's/'"$linha"'/'"$linha_new"'/g' $contador
		cp -r $userBackup /home/	# Manter as configurações padrões
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
