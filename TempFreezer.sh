#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 0.0.3 Dev


###########################
# CONFIGURAÇÕES DO SCRIPT #
###########################

# Diretorio onde sera armazenado os dados do contador
diretorio=/etc/TempFreezer/contador

# Array de diretorio que não seram apagados
manterArq[0]=/home/biblioteca/Área\ de\ Trabalho/Salvar\ dados
manterArq[1]=/home/biblioteca/Downloads

# Quantia de inicializações do sistema para o reset
vezesIniciado=5

####################
# INICIO DO SCRIPT #
####################

# Verifica se arquivo de contagem existe.
if [ -f $diretorio ];
then
	
	linha=$(head $diretorio) # Captura primeira linha do contador

	if [ $linha -gt $vezesIniciado -o $linha -eq $vezesIniciado ]; # Se 'linha' for maior ou igual do que 'vezesiniciado'
	then
		echo "Maior ou igual"
	else
		linha_new=$(($linha + 1))
		sed -i 's/'"$linha"'/'"$linha_new"'/g' $diretorio
	fi
else
	
	echo "1" >> $diretorio
	chmod 755 $diretorio
fi
