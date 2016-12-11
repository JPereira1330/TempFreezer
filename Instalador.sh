#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 2.0.0
# Instalador do TempFreezer


# Metodo responsavel pelo menu
menu(){

  clear # Limpando a tela

  # Printando menu para usuario
  echo "+---> TempFreezer V2.0  - Instalador <---+"
  echo "|                                        |"
  echo "|  [ 1 ] Instalação rapida               |"
  echo "|  [ 2 ] Instalar manualmente            |"
  echo "|  [ 3 ] Remover TempFreezer V2.0        |"
  echo "|  [ 4 ] Ajuda para escolher uma opção   |"
  echo "|  [ 9 ] Finalizar instalação            |"
  echo "|                                        |"
  echo "+----------------------------------------+"

  read opcao # Capturando opção escolhida pelo usuario
  clear # Limpando a tela

  case "$opcao" in
    "1") install_rapida ;;
    "2") echo "teste2"
    ;;
    "3") echo "teste3"
    ;;
    "4") echo "teste4"
    ;;
    "9") echo "teste9"
    ;;
    *)
      echo " [ERRO] Opção inexistente."
      read
      clear
      menu
      ;;
  esac
}

# Metodo install_rapida - instalação rapida [Opcao 1]
install_rapida(){

  ####
  # CRIANDO A ESTRUTURA DE PASTAS E ARQUIVOS NECESSARIOS
  ####

  # Criando pasta ./TempFreezer em /etc/ e Criando arquivo de log
  mkdir /etc/.TempFreezer
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado a pasta .TempFreezer em /etc/" >> /etc/.TempFreezer/log_instalacao.txt

  # Criando pasta Backup em /etc/.TempFreezer
  mkdir /etc/.TempFreezer/Backup
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado a pasta Backup em /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

  # Criando arquivo contador e inicializando ele com o numeiro '0'
  echo "0" >> /etc/.TempFreezer/Contador.txt
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado o arquivo Contador em /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

  # Criando arquivo Configs e inicializando
  echo "DIR_PADRAO=/etc/.TempFreezer" >> /etc/.TempFreezer/Configs.txt
  echo "DIRETORIO_BACKUP=Biblioteca" >> /etc/.TempFreezer/Configs.txt
  echo "VEZES_PARA_RESTAURAR=5" >> /etc/.TempFreezer/Configs.txt
  echo "MANTER_PASTA=Downloads" >> /etc/.TempFreezer/Configs.txt
  echo "INICIALIZAO_NO_BOOT=sim" >> /etc/.TempFreezer/Configs.txt
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado o arquivo Configs em /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

  ####
  # INSTALANDO E CONFIGURANDO SCRIPT NA INICIALIZAÇÃO DO SISTEMA
  ####

  echo "-- INSTALANDO E CONFIGURANDO SCRIPT NA INICIALIZAÇÃO DO SISTEMA --" >> /etc/.TempFreezer/log_instalacao.txt

  # Copiando Script TF para a pasta /etc/.TempFreezer e dando permissão para executar
  cp TF.sh /etc/.TempFreezer/TF.sh
  chmod +x /etc/.TempFreezer/TF.sh
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Copiando arquivo TF para /etc/.TempFreezer e dando permissão para executar" >> /etc/.TempFreezer/log_instalacao.txt

  # Copiando Script tempfreezer para a pasta /etc/init.d e dando permissão para executar
  cp tempfreezer.sh /etc/init.d/tempfreezer.sh
  chmod +x /etc/init.d/tempfreezer.sh
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Copiando arquivo tempfreezer para /etc/init.d e dando permissão para executar" >> /etc/.TempFreezer/log_instalacao.txt

  # Deletear arquivos de instalação
  echo "+---------------------------------------------+"
  echo "| Deseja realizar uma instalação limpa? [S/N] |"
  echo "+---------------------------------------------+"
  echo "| Caso essa função seja aceita sera deletado  |"
  echo "| todos os arquivos usados para efetuar essa  |"
  echo "| instalação.                                 |"
  echo "+---------------------------------------------+"
  read opcao

  case "$opcao" in
    "S")
    "s")
      rm Instalador.sh
      rm tempfreezer.sh
      rm TF.sh
      ;;
}


# Chamando menu
menu
