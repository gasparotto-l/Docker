# [Exercicio_04](#exercicio_04)

## Info
- Data de Realização: 22/04/2025
- Autor: Luiz H. Gasparotto
- Crie um Dockerfile para uma aplicação Flask que retorna uma mensagem ao acessar um endpoint.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Repositorio-Flask](#repositorio-flask) |
- | [Clonando](#clonando) |
- | [Flask](#flask) |
- | [Configuração-Dockerfile](#configuração-dockerfile) |
- | [Subindo-Container](#subindo-container) |
- | [Testes](#testes) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Repositorio-Flask

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o flask, clonaremos e configuraremos um container docker com essa aplicação

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/docker/awesome-compose
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash
 git clone https://github.com/docker/awesome-compose
```

## Flask
- Crie uma pasta para armazenar o container da aplicação. E acesse ela:
```bash
mkdir exercicio04 
cd exercicio04/
```
- Agora vamos passar o flask para essa pasta, e fazer o build do container nela. Isso vai garantir uma boa organização para realização da ativiade.
```bash
cp -r awesome-compose/flask ./
```
- Agora entramos no diretorio da aplicação do flask
```bash
cd flask/app
```
## Configuração-Dockerfile
- Agora na pasta /flask/app vamos excluir e criar um novo dockerfile.
```bash
rm Dockerfile
```
- Acessei a pasta no vs code para criar o novo Dockerfile, se quiser fazer os mesmo, basta utilizar o comando abaixo:
```bash
code . #Dentro da pasta do flask
```
- Com a pagina aberto no vs e agora configure o dockerfile.

![alt text](image.png)

## Subindo-Container

- Primeiro construa o container
```bash
docker build -t flask-app-image .
```
- Depois coloque-o para rodar na porta definida no dockerfile, no nosso caso 8000.
```bash
docker run -d -p 8000:8000 --name flask-app-container flask-app-image
```

- Demonstração no Terminal:
![alt text](image.png)

## Testes

- Comprove se funcionou, acessando o url abaixo no seu navegador
```bash
http://localhost:8000
```
- Oque deve aparecer:
![alt text](image.png)

- Comprove também se funcionou utilizando curl no terminal para fazer um chamado da sua pagina web:
```bash
curl http://localhost:8000 && echo
```
- Oque deve aparecer:
![alt text](image.png)

## Observações
- Altere o aplicação da maneira que mais o agrade, mas não se esqueça de respeitar coisas como, a ordem no dockerfile, ou as portas utilizadas para acesso na web, isso pode ser a diferença entre encontrar erros ou não praticando.
- Sugiro que faça testes modificando configurações e observe as mudanças, ver na pratica oque as coisas fazem ajuda muito a aprender.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.