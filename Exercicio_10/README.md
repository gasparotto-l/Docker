# [Exercicio_10](#exercicio_10)

## Info
- Data de Realização: 24/04/2025
- Autor: Luiz H. Gasparotto

### Descrição
- Ao rodar containers com o usuário root, você expõe seu sistema a riscos maiores em caso de comprometimento. Neste exercício, você deverá criar um Dockerfile para uma aplicação simples (como um script Python ou um servidor Node.js) e configurar a imagem para rodar com um usuário não-root.

- Você precisará:
    - a. Criar um usuário com useradd ou adduser no Dockerfile.
    - b. Definir esse usuário como o padrão com a instrução USER.
    - c. Construir a imagem e iniciar o container.
    - d. Verificar se o processo está rodando com o novo usuário usando docker exec whoami.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Criando-Node](#criando-node) |
- | [Dockerfile](#dockerfile) |
- | [Construindo-e-Iniciando](#construindo-e-iniciando) |
- | [Teste](#teste) |
- | [Observações](#Observações) |
- | [Agradecimentos](#Agradecimentos) |


## Criando-Node
- Crie um diretorio para armazenar o projeto e a acesse-a
```bash
mkdir semroot
cd semroot
```
- Crie um arquivo package.json:
```bash
{
  "name": "semroot-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
```
- Crie um arquivo server.js:
```bash
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Olá! Estou rodando como usuário não-root!');
});

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
```

## Dockerfile
- Crie seu dockerfile para configurar nossa aplicação:
```bash
FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN adduser -D semrootuser

RUN chown -R semrootuser:semrootuser /usr/src/app

USER semrootuser

EXPOSE 3000

CMD ["npm", "start"]
```
## Construindo-e-Iniciando
- Agora construa o container
```bash
docker build -t semroot .
```
- E inicie o seu container
```bash
docker run -d -p 3000:3000 --name semroot-app semroot
```

## Teste
- Verifique o usuario
```bash
docker exec semroot-app whoami
```
- Retorno:


- Teste a aplicação com curl no terminal:
```bash
curl http://localhost:3000
```
- Retorno:

## Observações

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.