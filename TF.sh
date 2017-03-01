#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 2.0.2
# Script TempFreezer

###########################
# CONFIGURAÇÕES DO SCRIPT #
###########################

diretorio="/etc/.TempFreezer"               # Caminho onde sera armazenado os dados do script
usuario="user"			                        # Nome do usuario
contador=$diretorio"/Contador.txt"          # Arquivo onde sera salvo a contagem
userBackup=$diretorio"/Backup/"$usuario     # Pasta onde fica toda
userDir="/home/"$usuario            	      # Caminho do diretorio que sera apagado
manterPasta="Downloads"                     # Diretorio que não sera apagado
vezesIniciado=5                             # Quantia de inicializações do sistema para o reset

tempfreezer(){
  # Verifica se arquivo de contagem existe
  if [ -d $diretorio -o -f $contador ]; then

    # Captura primeira linha do contador
  	linha=$(head $contador)

    # Se 'linha' for maior ou igual do que 'vezesiniciado'
  	if [ $linha -gt $vezesIniciado -o $linha -eq $vezesIniciado ];
  	then
  		find $userDir/* -maxdepth 0 -name $manterPasta -o -exec rm -rf '{}' ';'
      rm -R $userDir/.*
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
}
# Função que testa se é permitido contar
capturarConfigs(){
  # Capturando se é permitido ou não inicializar o contador
  configs_cont_boot=`grep -i CONTAGEM_NO_BOOT /etc/.TempFreezer/cont.txt`
  if [ $configs_cont_boot == 'CONTAGEM_NO_BOOT=sim' ];
  then
      # Trocando valor do arquivo cont.txt
      sed -i 's/'"CONTAGEM_NO_BOOT=sim"'/'"CONTAGEM_NO_BOOT=nao"'/g' /etc/.TempFreezer/cont.txt
      # Capturando se é permitido ou não inicializar o contador
      configs_ini_boot=`grep -i INICIALIZACAO_NO_BOOT /etc/.TempFreezer/Configs.txt`
      if [ $configs_ini_boot == 'INICIALIZACAO_NO_BOOT=sim' ];
      then
        tempfreezer
      else
        exit 1
      fi
  else
    # Trocando valor do arquivo cont.txt
    sed -i 's/'"CONTAGEM_NO_BOOT=nao"'/'"CONTAGEM_NO_BOOT=sim"'/g' /etc/.TempFreezer/cont.txt
    exit 1
  fi

}

capturarConfigs
