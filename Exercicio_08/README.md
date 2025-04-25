# [Exercicio_08](#exercicio_08)

## Info
- Data de Realização: 23/04/2025
- Autor: Luiz H. Gasparotto
- Utilize Docker Compose para configurar uma aplicação com um banco de dados PostgreSQL

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Repositorio-postgresql-pgadmin](#repositorio-postgresql-pgadmin) |
- | [Clonando](#Clonando) |
- | [Postgresql-pgadmin](#Postgresql-pgadmin) |
- | [Configurando-e-Iniciando-o-Container](#Configurando-e-Iniciando-o-Container) |
- | [Acessando-pelo-terminal](#Acessando-pelo-terminal) |
- | [Acesso-pela-Web](#acesso-pela-Web) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Repositorio-postgresql-pgadmin

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o postgresql-pgadmin, clonaremos e configuraremos um container docker com essa aplicação.

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/docker/awesome-compose
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash
 git clone https://github.com/docker/awesome-compose
```

## Postgresql-pgadmin
- Crie uma pasta para armazenar o container da aplicação. E acesse ela:
```bash
mkdir postgresql-pgadmin
cd postgresql-pgadmin/
```
- Agora vamos passar a aplicação para essa pasta, e fazer o build do container nela. Isso vai garantir uma boa organização para realização da atividade.
```bash
cp -r awesome-compose/postgresql-pgadmin/* .
```
## Configurando-e-Iniciando-o-Container
- Essa aplicação necessita que criemos um arquivo de configuração para armazenar as variaveis de usuario. Sem esse arquivo não conseguiremos criar o container.
- Crie esse arquivo o .env :
```bash
touch .env
nano .env
```
- Agora configure de acordo com o exemplo abaixo:
```bash
# Banco de Dados PostgreSQL
POSTGRES_USER=admin
POSTGRES_PASSWORD=Senha@Segura123
POSTGRES_DB=meu_banco

# pgAdmin (interface web)
PGADMIN_DEFAULT_EMAIL=admin@email.com
PGADMIN_DEFAULT_PASSWORD=SenhaPgAdmin@456
```
- No meu caso o .env ficou assim:
```bash
POSTGRES_USER=luizh
POSTGRES_PW=senhalegal
POSTGRES_DB=postgres
PGADMIN_MAIL=gasparottoluiz31@gmail.com
PGADMIN_PW=senhalegaladmin
```
- Agora pra subir o container utilize o comando abaixo:
```bash
docker compose up -d
```

## Acessando-pelo-terminal

- Para acessar pela linha de comando utilize o seguinte comando, utilizando as configurações do SEU .env
- Este é apenas o exemplo do meu...
```bash
docker exec -t postgres psql -U luizh -d postgres
```
![alt text](bdpeloterminal.png)

## Acesso-pela-Web
- Acesse o http://localhost:5050
- Com suas credenciais configuradas no .env agora basta fazer login no pgAdmin.

![alt text](loginNopgAdmin.png)
- Clique em "Add New Server" 

![alt text](image-1.png)

- Selecione um Nome para esse Server

![alt text](image.png)

- Agora vá para a opção de Connection e adicione os detalhes do seu arquivo .env

![alt text](image-2.png)

- Clique em "Save" e agora temos um database no pgAdmin

![alt text](image4.png)

- Confira seu container
```bash
docker ps
```

## Observações
- Utilizei o repositório awesome-compose do GitHub para clonar a aplicação postgresql-pgadmin,
mas você pode adaptar o processo com outro repositório semelhante, desde que siga a mesma estrutura.
O importante é garantir que os arquivos necessários estejam corretamente organizados.

- Optei por separar os arquivos em uma pasta específica para manter a organização do projeto,
mas caso prefira, é possível executar os comandos diretamente na pasta clonada.
Organizar as pastas ajuda bastante na visualização e manutenção.

- As credenciais usadas no .env são apenas um exemplo e podem ser personalizadas conforme sua preferência.
O essencial é manter o padrão dos nomes das variáveis, para que o container funcione corretamente.
Lembre-se de usar senhas seguras, especialmente em ambientes reais.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.


