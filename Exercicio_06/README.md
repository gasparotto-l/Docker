# [Exercicio_06](#exercicio_06)

## Info
- Data de Realização: 23/04/2025
- Autor: Luiz H. Gasparotto
- Utilize um multi-stage build para otimizar uma aplicação Go, reduzindo o tamanho da imagem final. Utilize para praticar o projeto GS PING desenvolvido em Golang.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Repositorio-Gs-Ping](#repositorio-Gs-Ping) |
- | [Clonando](#clonando) |
- | [Configurando](#Configurando) |
- | [Dockerfile-e-Multistage](#dockerfile-e-multistage) |
- | [Subindo-e-Comparando](#subindo-e-comparando) |
- | [Rodando-e-Acessando](#rodando-e-acessando) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Repositorio-Gs-Ping

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o GS Ping desenvolvido em golang, clonaremos e configuraremos um container docker com essa aplicação.

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/docker/docker-gs-ping.git
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash
 git clone https://github.com/docker/docker-gs-ping.git
```
- Acesse o diretorio onde clonou o repositorio e vamos para as configurações
```bash
 cd docker-gs-ping
```

## Configurando
- Remova os arquivos de Dockerfile e Dockerfile.multistage, pois vamos configurar nossos proprios arquivos
```bash
 rm Dockerfile
 rm Dockerfile.multistage
```
- Abra o VS code e criei agora os novos arquivos de Dockerfile e Multistage
```bash
code .
```
![image](https://github.com/user-attachments/assets/452959c8-71be-4b9f-932b-51f8b97d4b86)


## Dockerfile-e-Multistage
- Configure o Dockerfile
```bash
FROM golang:1.19

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

EXPOSE 8080

CMD [ "/docker-gs-ping" ]
```
- Configure o Dockerfile.multistage
```bash
FROM golang:1.19 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

FROM build-stage AS run-test-stage
RUN go test -v ./...

FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /docker-gs-ping /docker-gs-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping"]
```

## Subindo-e-Comparando
- Agora vamos subir os containers e realizar um teste
- Primeiro vamos subir o container com multistage:
```bash
 docker build -t docker-gs-ping -f Dockerfile.multistage .
```
- E agora vamos subir o container sem multistage:
```bash
docker build -t docker-gs-ping-normal -f Dockerfile .
```
- Observe o tamanho das imagens para ver se temos diferença
```bash
docker images | grep docker-gs-ping
```
![image](https://github.com/user-attachments/assets/c745ecc4-103e-4a3f-b7af-8abe4e8adf44)


- Visivel que as imagens apresentam tamanhos diferentes.

## Rodando-e-Acessando
- Agora vamos rodar ambos os containers:
    - Com multistage:
    ```bash
    docker run -d -p 8080:8080 --name docker-gs-ping docker-gs-ping
    ```
    - Sem multistage:
    ```bash
    docker run -d -p 8081:8080 --name docker-gs-ping-normal docker-gs-ping-normal
    ```
- Agora vamos testar ambos os containers no terminal com curl
```bash
curl http://localhost:8080 && echo #Multistage
curl http://localhost:8081 && echo #Normal
```
- Resultado esperado:
![image](https://github.com/user-attachments/assets/bbfba272-619a-47b9-971c-9cfccf4bcd82)


- Por ultimo acesse ambos os urls abaixo no seu navegador e confira se o resultado é equivalente aos mostrados.
```bash
http://localhost:8080
http://localhost:8081
```
- 8080:

![image](https://github.com/user-attachments/assets/60f631fb-d788-4946-b268-7521129de8a6)

- 8081:

![image](https://github.com/user-attachments/assets/fa536cf3-e8e8-4f95-bf75-8f0540e39230)


## Observações
-

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.
