#!/bin/bash

# Programador: José Claudio Pereira <Nyex>
# TempFreezer - Ver: 2.1
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
  echo "|  [ 9 ] Finalizar instalação            |"
  echo "|                                        |"
  echo "+----------------------------------------+"

  read opcao # Capturando opção escolhida pelo usuario
  clear # Limpando a tela

  case "$opcao" in
    "1") install_rapida ;;
    "2") install_manual ;;
    "3")
      rm -R /etc/.TempFreezer
      rm /bin/tempfreezer
      rm /etc/init.d/TF
      rm /etc/rc2.d/S16*
    ;;
    "9") echo "Tchau!!!"
         read
         clear
         exit
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
  echo "CONTAGEM_NO_BOOT=sim" >> /etc/.TempFreezer/cont.txt
  echo "INICIALIZACAO_NO_BOOT=sim" >> /etc/.TempFreezer/Configs.txt
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado o arquivo Configs em /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

  # Trocar dono da pasta /etc/.TempFreezer
  echo "+---------------------------------------------+"
  echo "| Insira abaixo o usuario da maquina          |"
  echo "+---------------------------------------------+"
  read user
  chown $user -R /etc/.TempFreezer
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Trocando dono da pasta /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

  clear

  # Criar a pasta salvar dados
  echo "+---------------------------------------------+"
  echo "| Deseja criar a pasta salvar dados [s/n]     |"
  echo "+---------------------------------------------+"
  read salvarDados

  case "$salvarDados" in
    "S")
      mkdir /home/$user/Downloads/.salvarDados
      ln -s /home/$user/Downloads/.salvarDados /home/$user/Área\ de\ Trabalho/Salvar\ Dados
      chown -R $user /home/$user/Downloads/.salvarDados
      chgrp -R $user /home/$user/Downloads/.salvarDados
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criando pasta salvar Dados" >> /etc/.TempFreezer/log_instalacao.txt
      ;;
    "s")
      mkdir /home/$user/Downloads/.salvarDados
      ln -s /home/$user/Downloads/.salvarDados /home/$user/Área\ de\ Trabalho/Salvar\ Dados
      chown -R $user /home/$user/Downloads/.salvarDados
      chgrp -R $user /home/$user/Downloads/.salvarDados
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criando pasta salvar Dados" >> /etc/.TempFreezer/log_instalacao.txt
      ;;
  esac

  clear

  # Criar a pasta salvar dados
  echo "+-----------------------------------------------------------+"
  echo "| Deseja o script prepare o Backup que sera utilizado [s/n] |"
  echo "+-----------------------------------------------------------+"
  read prepararBackup

  case "$prepararBackup" in
    "S")
      echo "+-----------------------------------------------------------+"
      echo "| Recomendo que apos a instação vá até o diretorio:         |"
      echo "|   - /etc/.TempFreezer/Backup                              |"
      echo "| Acesse a pasta do usuario copiada e delete os arquivos    |"
      echo "| de logs, Cache ou arquivos inuteis.                       |"
      echo "| Exemplo de arquivos não utilizado:                        |"
      echo "|   - ~/.Cache                                              |"
      echo "|   - ~/.Mozilla                                            |"
      echo "|   - ~/.bash_history                                       |"
      echo "+-----------------------------------------------------------+"
      cp -R /home/$user /etc/.TempFreezer/Backup/
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Copiando a pasta do usuario para /etc/.TempFreezer/Backups" >> /etc/.TempFreezer/log_instalacao.txt
      ;;
    "s")
      echo "+-----------------------------------------------------------+"
      echo "| Recomendo que apos a instação vá até o diretorio:         |"
      echo "|   - /etc/.TempFreezer/Backup                              |"
      echo "| Acesse a pasta do usuario copiada e delete os arquivos    |"
      echo "| de logs, Cache ou arquivos inuteis.                       |"
      echo "| Exemplo de arquivos não utilizado:                        |"
      echo "|   - ~/.Cache                                              |"
      echo "|   - ~/.Mozilla                                            |"
      echo "|   - ~/.bash_history                                       |"
      echo "+-----------------------------------------------------------+"
      cp -R /home/$user /etc/.TempFreezer/Backup/
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Copiando a pasta do usuario para /etc/.TempFreezer/Backups" >> /etc/.TempFreezer/log_instalacao.txt
      ;;

  esac

  read continuar
  clear

  ####
  # INSTALANDO E CONFIGURANDO SCRIPT NA INICIALIZAÇÃO DO SISTEMA
  ####

  echo "-- INSTALANDO E CONFIGURANDO SCRIPT NA INICIALIZAÇÃO DO SISTEMA --" >> /etc/.TempFreezer/log_instalacao.txt

  # Copiando Script TF para a pasta /etc/init.d e dando permissão para executar
  cp TF /etc/init.d/TF
  sed -i 's/'"usuario=\"user\""'/'"usuario=$user"'/g' /etc/init.d/TF
  chmod +x /etc/init.d/TF
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Copiando arquivo TF para /etc/.TempFreezer e dando permissão para executar" >> /etc/.TempFreezer/log_instalacao.txt

  # Copiando Script tempfreezer para a pasta /etc/init.d e dando permissão para executar
  cp tempfreezer /bin/tempfreezer
  chmod +x /bin/tempfreezer
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criando o comando tempfreezer no diretorio /bin" >> /etc/.TempFreezer/log_instalacao.txt

  # Inserindo na inicilização do sistema
  `update-rc.d TF defaults 16`
  `ln -s /etc/init.d/TF /etc/rc2.d/S16TF`
  `chmod +x /etc/rc2.d/S16TF`
  echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Inserindo o script na inicilizacao do linux" >> /etc/.TempFreezer/log_instalacao.txt

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
      rm Instalador.sh
      rm tempfreezer
      rm TF
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Limpando arquivos de instalação" >> /etc/.TempFreezer/log_instalacao.txt
      ;;
    "s")
      rm Instalador.sh
      rm tempfreezer
      rm TF
      echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Limpando arquivos de instalação" >> /etc/.TempFreezer/log_instalacao.txt
      ;;
  esac
}

install_manual(){

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
    echo "INICIALIZACAO_NO_BOOT=sim" >> /etc/.TempFreezer/Configs.txt
    echo "[ `date +%d/%m/%y` `date +%H:%M:%S` ] Criado o arquivo Configs em /etc/.TempFreezer" >> /etc/.TempFreezer/log_instalacao.txt

    # Trocar dono da pasta /etc/.TempFreezer
    echo "+---------------------------------------------+"
    echo "| Insira abaixo o usuario da maquina          |"
    echo "+---------------------------------------------+"
    read user
    chown $user -R /etc/.TempFreezer
}

# Chamando menu
menu
