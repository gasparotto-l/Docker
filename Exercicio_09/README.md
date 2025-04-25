# [Exercicio_09](#exercicio_09)

## Info
- Data de Realização: 24/04/2025
- Autor: Luiz H. Gasparotto
- Construa uma imagem baseada no Nginx ou Apache, adicionando um site HTML/CSS estático. Utilize a landing page do Creative-Tim para criar uma página moderna hospedada no container.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [](#) |

## Repositorio-Creative-Tim

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o Creative-Tim, clonaremos e configuraremos um container docker com essa aplicação.

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/creativetimofficial/material-kit.git
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Crie uma pasta para armazenar o container da aplicação. E acesse ela:
```bash
mkdir creative-tim
cd creative-tim/
```
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash 
git clone https://github.com/creativetimofficial/material-kit.git
```
## Creative-Tim

- Entre na pasta material-kit
```bash 
cd material-kit
```
- Abra o VS code para com o codigo abaixo e vamos criar um Dockerfile
```bash 
code .
```

## Dockerfile
- Crie um arquivo de Dockerfile no VS code, e configure como abaixo:
```bash
FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY ./ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```
- Crie o Container
```bash
docker build -t creative-tim-image .
```
- Rode seu Container
```bash
docker run -d -p 8080:80 --name creative-tim-container creative-tim-image
```

## Acesso Web
- Acesse a pagina web utilizando esse url
```bash
http://localhost:8080
```
- Pagina Web

## Observações


## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.