# [Exercicio_02](#exercicio_02)

## Info
- Data de Realização: 22/04/2025
- Autor: Luiz H. Gasparotto
- Criando e rodando um container interativo. Inicie um container Ubuntu e interaja com o terminal dele. Testando nele um script Bash que imprime logs do sistema.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Iniciando-Container](#iniciando-container) |
- | [Script Bash](#script-bash) |
- | [Configurações](#configurações) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Iniciando Container
- Abra o rancher desktop(ou docker hub), e depois seu terminal linux, para realização do exercicio.
- Neste exercicio podemos fazer de uma maneira mais simples, não é preciso criar um dockerfile ou docker-compose.
- Para criar e rodar um container de forma interativa, utilize o comando abaixo.
```bash
docker run -it --name programa-ubuntu ubuntu bash
# -it inicia o container em modo interativo
# --name "nome-do-programa" 
# ubuntu -> Imagem base(equivalente ao FROM)
# bash -> shell para interagir
```
- Agora dentro do seu container, vamos criar o um script bash para emitir os logs como pedido no exercicio.

## Script Bash
- Crie um arquivo de formato script e altere suas permissões para que a execução seja bem sucedida.
```bash
$ touch script-exemplo.sh #Criando o arquivo script
$ chmod +x script-exemplo.sh #Utilizando +x para dar permissão de execução ao script
```
## Configurando o Script 
- Abra o arquivo de script utilizando algum editor de texto do linux(vim, nano, vi e entre outros). 
```bash
nano script-exemplo.sh
```
- Com o arquivo aberto configure desse maneira ou semelhante, bem simples apenas declarando logs do sistema com echo:
```bash
#!/bin/bash
echo "=== Logs do Sistema ==="
echo "Data/hora: $(date)"
echo "Uso de CPU: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
echo "Memória livre: $(free -h | grep Mem | awk '{print $4}')"
echo "Processos em execução: $(ps aux | wc -l)"
```
- Desse modo teremos a saida do script assim:
![alt text](image.png)

## Explicação do Script
- Agora veja toda explicação do script:
```bash
echo # É o comando que usamos pra declarar algo.
echo "=== Logs do Sistema ===" # Mostra cabeçalho do log
echo "Data/hora: $(date)" # Data e hora atual (formato padrão)

# Uso de CPU (%): 
# - Soma tempos de user ($2) + system ($4) / tempo total
# - Calcula porcentagem de uso
echo "Uso de CPU: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"

# Memória livre:
# - `free -h`: Mostra memória em GB/MB
# - `grep Mem`: Filtra linha da memória principal
# - `awk '{print $4}'`: Pega a coluna "free"
echo "Memória livre: $(free -h | grep Mem | awk '{print $4}')"

# Número de processos ativos:
# - `ps aux`: Lista todos os processos
# - `wc -l`: Conta linhas (1 processo por linha)
echo "Processos em execução: $(ps aux | wc -l)"
```
- Este script mostra informações de logs do sistema da maneira que foi requisitada pelo exercicio.

## Observações
- É possivel fazer esse exercicio também usando dockerfile e/ou compose para configurações, porém por ser um exercicio muito simples, a maneira em que eu demonstrei é mais pratica e intuitiva.
- O script é simples e utilizado diretamente de forma interativa no shell do ubuntu. Para scripts mais extensos e complexos é recomendado criar um volume no conteiner para armazena-lo.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.