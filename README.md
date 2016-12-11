# TempFreezer

O TempFreezer é um script que possui o objetivo de substituir a pasta home apos um numero determinado de reinicializações.

## Instalação
 
 1. Crie a seguinte pasta e arquivo dentro de: __/etc/.TempFreezer__ </br>
  1.A Crie a pasta: __Backup__ </br>
  1.B Crie o arquivo: __Contador.txt__ </br>
  
 2. Dentro de __Backup__ coloque a pasta do usuario com apenas os arquivos e diretorios padrões </br>
 
 3. Dentro de __/etc/init.d__ coloque o Script __TempFreezer.sh__ </br>
 
 4. De permissão de execução para o script __TempFreezer.sh__ </br>
 ```bash
  chmod +x /etc/init.d/TempFreezer.sh 
 ```
 
 5. Adicione na lista de inicialização do sistema com os seguintes comandos </br>
 ```bash
  update-rc.d TempFreezer.sh defaults 16
  touch /etc/rc2.d/S16TempFreezer.sh
  chmod +x /etc/rc2.d/S16TempFreezer.sh
  ln -S /etc/init.d/TempFreezer.sh /etc/rc2.d/S16TempFreezer.sh
 ```
 
 6. Verifique se o arquivo /etc/TempFreezer/contador.txt foi inicializado com '0'
 
## Configurações

No Arquivo __/etc/init.d/TempFreezer.sh__ você vai poder fazer todas as alterações que necessitar.
  ```shell
    diretorio="/etc/TempFreezer"                # Caminho onde sera armazenado os dados do script
    contador=$diretorio"/Contador.txt"          # Arquivo onde sera salvo a contagem
    userBackup=$diretorio"/Backup/biblioteca"   # Pasta onde fica toda 
    userDir="/home/biblioteca"           	      # Caminho do diretorio que sera apagado
    manterPasta="Downloads"                     # Diretorio que não sera apagado
    usuario="biblioteca"			                  # Nome do usuario
    vezesIniciado=5                             # Quantia de inicializações do sistema para o reset
  ```
  
  
