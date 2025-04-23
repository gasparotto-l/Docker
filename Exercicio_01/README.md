# [Exercicio_01](#exercicio_01)

## Info
- Data de Realização: 22/04/2025
- Autor: Luiz H. Gasparotto
- Rodando um container básico, utilizando um docker com a imagem do Nginx e acessando a página padrão no navegador(TailWind).

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Passo-a-Passo](#passo-a-passo) |
    - | [Preparação](#preparação) |
    - | [Criando e utilizando o Docker](#criando-e-utilizando-o-docker) | 
    - | [Dockerfile e Docker Compose](#dockerfile-e-docker-compose) |
- | [Execução e Teste](#execução-e-teste) |
- | [Comandos e configurações](#comandos-e-configurações) |
    - | [Linux](#linux) |
    - | [Docker](#docker) |
- | [Comandos](#comandos) |
- | [Configurações](#configurações) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |


## Passo-a-Passo:
### Preparação
- Abra o rancher desktop(ou docker hub), e depois seu terminal linux, para realização do exercicio.
- Crie um diretorio para armezenar o html que irá utilizar no site. Utilizei os comandos abaixo:
```bash
    $ cd ~ #Para ir até o diretorio home do usuario
    $ mkdir exercicio01 #Crie um diretorio para armazenar as coisas do exercicio
    $ cd exercicio01/ #Acesse o diretorio criado 
    $ mkdir site #Criando um diretorio para colocar o html
    $ cd site/ #Entre na pasta criada
    $ touch index.html #Crie o arquivo de html
```
- Agora copie o index.html do TailWind e cole no arquivo de html criado no seu sistema linux.

### Criando e utilizando o Docker
- Para facilitar o processo de criação dos seus arquivos docker, abra o Visual studio code na pasta do exercicio. Siga os comandos abaixo:
```bash
    $ cd exercicio01 #Acesse a pasta onde está o html
    $ code . #Para acessar a pasta atual no visual code.
```
- Com vscode aberto, crie dois arquivos, um "Dockerfile" e um "docker-compose.yml". Vamos utilizar esses arquivos para realizar a conteirnização.

- IMAGEM

#### Dockerfile & Docker Compose
- Acesse o seu arquivo Dockerfile e configure da seguinte maneira, para que o site esteja disponivel apos a criação do conteiner.
```bash
FROM 

RUN rm -rf /usr/share/nginx/html/*

COPY ./site /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```
- Configure também o arquivo de docker-compose e depois disso podemos partir para execução.
```bash
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80" #Não precisa ser necessariamente 8080
```
#### Execução e Teste
- Execute o docker compose, e tudo deve estar funcionando como esperado. Utilize o comando abaixo:
```bash
    docker compose up -d
```
- Espere o carregamento, e depois acesse o site em "http://localhost:8080", se tudo deu certo voce deve vizualizar isso no site:

![alt text](image.png)

## Comandos e Configurações
### Linux
- Utilizei comandos simples para navegação e criação de diretorios. De uma olhada em quais foram:
```bash
cd #Navegar até um diretorio
ls #Listar conteudos de um diretorio
mkdir #Criar um diretorio
touch #Criar um Arquivo
```

### Docker
#### Comandos
- Os comandos que utilizei que tem ligação com docker são os seguintes:
```bash
docker compose up -d #Roda o conteiner sem prender o terminal(-d)
docker-compose config  #Validar o arquivo compose
docker-compose ps #Para verificar os docker composes ativos
```
#### Configurações
- Explicação das configurações do Dockerfile:
```bash
#Usa a imagem oficial leve do Nginx
FROM nginx:alpine

#Remove os arquivos padrão do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia a pasta local 'site/' (com seu HTML) para o diretório do Nginx no container
COPY ./site /usr/share/nginx/html

# Expõe a porta 80 (HTTP) do container
EXPOSE 80

# Inicia o Nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
```
- Explicação das configurações do docker-compose.yml:
```bash
#Lista de serviços/containers a serem executados
services:
  #Nome do serviço 
  web:
    #Constrói a imagem usando o Dockerfile no diretório atual (.)
    build: .

    #Mapeia a porta 80 do container para a 8080 do host
    #"HOST:CONTAINER"
    ports:
      - "8080:80"
```

## Observações
- Realizei esse exercicio em um subsistema do windows(WSL Ubuntu), mas saiba que é possivel replicar o exercicio em um SO linux propriamente, ou em uma Virtual Machine.
- Eu fiz as criações dos arquivos do Docker no visual studio, porém saiba que é possivel utilizar outra interface ide que seja semelhante, ou criar os arquivos diretamente no terminal.
- A utilização da porta localhost como 8080 não é obrigatoria, voce pode utilizar outra porta se preferir.

## Agradecimentos
- Obrigado pela atenção, espero que tudo tenha ficado claro.
- Se tiver alguma sugestão de alteração no documento, estou a disposição a para correções e atualizações.

