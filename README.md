# TempFreezer [ Atualizando ARQUIVO ]

O TempFreezer é um script que possui o objetivo de substituir a pasta home apos um numero determinado de reinicializações.

## Notas de atualização 2.0
 ```html
  1 - Desenvolvido um script para instalação
      A - Opção de instalação rapida [ Não é necessario configurar nada apos a instalação ]
      B - Opção de instalação manual [ Cria apenas a estrutura de arquivos necessaria ]
  2 - Acrescentado o comando tempfreeze
      A - tempfreezer start     -> Para ativar contagem na inicialização do sistema
      B - tempfreezer stop      -> Para desativar contagem na inicialização do sistema
      C - tempfreezer reset     -> Para resetar a contagem do tempfreezer
      D - tempfreezer contagem  -> Para mostrar a contagem atual
 ```
## Instalação [ Caso utilizado instalação manual ]
 
 1. Copie a pasta do usuario para __/etc/.TempFreezer/Backup__ e mude o dono para o usuario padrao da maquina</br>
 
 2.  </br>
 
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

No Arquivo __/etc/init.d/TF.sh__ você vai poder fazer todas as alterações que necessitar.
  ```shell
    diretorio="/etc/TempFreezer"                # Caminho onde sera armazenado os dados do script
    contador=$diretorio"/Contador.txt"          # Arquivo onde sera salvo a contagem
    userBackup=$diretorio"/Backup/biblioteca"   # Pasta onde fica toda 
    userDir="/home/biblioteca"                  # Caminho do diretorio que sera apagado
    manterPasta="Downloads"                     # Diretorio que não sera apagado
    usuario="biblioteca"                        # Nome do usuario
    vezesIniciado=5                             # Quantia de inicializações do sistema para o reset
  ```
  
  
