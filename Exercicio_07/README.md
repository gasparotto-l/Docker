# [Exercicio_07](#exercicio_07)

## Info
- Data de Realização: 23/04/2025
- Autor: Luiz H. Gasparotto
- Crie uma rede Docker personalizada e faça dois containers, um Node.js e um MongoDB, se comunicarem.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Repositorio-React-Mongodb](#Repositorio-React-Mongodb) |
- | [Clonando](#Clonando) |
- | [React-Express-Mongodb](#React-Express-Mongodb) |
- | [Configurando](#Configurando) |
- | [Backend-Dockerfile](#Backend-Dockerfile) |
- | [Frontend-Dockerfile](#Frontend-Dockerfile) |
- | [Testes](#Testes) |
- | [Acessando-Web](#Acessando-Web) |
- | [Observações](#Observações) |
- | [Agradecimentos](#Agradecimentos) |

## Repositorio-React-Mongodb

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o react-express-mongodb, clonaremos e configuraremos um container docker com essa aplicação.

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/docker/awesome-compose
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash
 git clone https://github.com/docker/awesome-compose
```

## React-Express-Mongodb
- Crie uma pasta para armazenar o container da aplicação. E acesse ela:
```bash
mkdir react-express-mongodb
cd react-express-mongodb/
```
- Agora vamos passar a aplicação para essa pasta, e fazer o build do container nela. Isso vai garantir uma boa organização para realização da atividade.
```bash
cp -r awesome-compose/react-express-mongodb/* .
```

## Configurando
- Dentro da pasta react-express-mongodb, vamos acessar o VS code começar a alterar configurações.
```bash
cd react-express-mongodb/
code .
```
## Backend-Dockerfile
```bash
FROM node:lts-buster-slim AS development

RUN apt-get update && apt-get install -y --no-install-recommends iputils-ping && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package.json /usr/src/app/package.json
COPY package-lock.json /usr/src/app/package-lock.json
RUN npm ci

COPY . /usr/src/app

EXPOSE 3000

CMD [ "npm", "run", "dev" ]

FROM development as dev-envs
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
EOF

RUN <<EOF
useradd -s /bin/bash -m vscode
groupadd docker
usermod -aG docker vscode
EOF

COPY --from=gloursdocker/docker / /
CMD [ "npm", "run", "dev" ]
```
## Frontend-Dockerfile
```bash
FROM node:lts-buster AS development

RUN apt-get update && apt-get install -y --no-install-recommends iputils-ping && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package.json /usr/src/app
COPY package-lock.json /usr/src/app

RUN npm ci

COPY . /usr/src/app

EXPOSE 3000

CMD ["npm", "start"]

FROM development as dev-envs
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
EOF

RUN <<EOF
useradd -s /bin/bash -m vscode
groupadd docker
usermod -aG docker vscode
EOF

COPY --from=gloursdocker/docker / /
CMD [ "npm", "start" ]
```
- Apos essas alterações, vamos subir o container e iniciar os testes!
```bash
docker compose up --build -d #Subindo o container
```
- Observe se os containers foram criados
```bash
docker ps
```

## Testes
- Vamos testar a conexão entre as camadas da aplicação usando ping, que instalamos anteriormente no dockerfile.
    - Testar comunicação do Backend com o MongoDB:
    ```bash
    docker exec -it react-express-mongodb-backend-1 ping -c 2 react-express-mongodb-mongo-1
    ```
    - Testar comunicação do Frontend com o Backend
    ```bash
    docker exec -it react-express-mongodb-frontend-1 ping -c 2 react-express-mongodb-backend-1
    ```
    - Testar comunicação do Backend com o Frontend
    ```bash
    docker exec -it react-express-mongodb-backend-1 ping -c 2 react-express-mongodb-frontend-1
    ```
- Resultado desses testes:

    ![image](https://github.com/user-attachments/assets/0f8d6f6f-50e9-4dae-b81d-83b85d785026)


## Acessando-Web
- Acesse a pagina em https://localhost:3000 e se tudo deu certo será capaz de observar a pagina web.

![image](https://github.com/user-attachments/assets/b9124781-a65a-49c7-bc4e-809e7e91e012)


## Observações

- Fiz o exercício no WSL Ubuntu, mas dá tranquilo pra fazer num Linux puro ou até numa VM. O importante é ter o ambiente certinho configurado. No fim, o resultado vai ser o mesmo.
- Criei os arquivos do Docker usando o Visual Studio, mas você pode usar outra IDE parecida, tipo o VS Code ou até fazer tudo direto no terminal. Vai do que você se sentir mais confortável.
- Usei a porta 8080 no localhost, mas isso não é uma regra fixa.
Você pode escolher outra porta sem problemas. Só lembra de verificar se ela está liberada no sistema.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.
