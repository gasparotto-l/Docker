# [Exercicio_03](#exercicio_03)

## Info
- Data de Realização: 22/04/2025
- Autor: Luiz H. Gasparotto
- Listando e removendo containers:
Liste todos os containers em execução e parados, pare um container em
execução e remova um container específico.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Listando-Conteiners](#listando-containers) |
- | [Parando-Conteiners](#parando-containers) |
- | [Removendo-Conteiners](#removendo-containers) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Listando-Conteiners
- Para conseguir parar e/ou remover containers é preciso saber quais containers temos, por isso vamos lista-los, com esses comandos:
```bash
docker ps -a #docker ps para listar os containers
-a #É um parametro para listar também os containers parados
```
- Feito isso sera possivel visualizar todos seus conteiners. Observe o resultado exemplo na minha maquina:

[IMG]![alt text](image.png)

- Imagem ampliada:

![alt text](image-1.png)

## Parando-Conteiners

- Agora que sabemos ver os conteiners, está na hora de parar algum!
- Para isso usamos o seguinte comando:
```bash
docker stop <ID_ou_nome_do_container>
```
- Exemplo pratico:
![alt text](image-2.png)

- Caso precisa iniciar esse container novamente, basta utilizar esse comando:
```bash
docker start <ID_ou_nome_do_container>
```
- Exemplo pratico:
![alt text](image-3.png)

## Removendo-Containers

- Por ultimo, vamos resolver um container. Para isso é preciso que o conteiner em questão esteja parado, e isso já sabemos fazer!
- Para remover então usaremos o seguinte comando:
```bash
docker rm <ID_ou_nome_do_container> 
```
- Exemplo pratico:
![alt text](dockerm.png)
- Confira se o container foi removido corretamente usando novamente esse comando:
```bash
docker ps -a
```
- Se tudo deu certo não será mais possivel visualizar o container removido.

## Observações
- Tome cuidado quando estiver realizando essa pratica, para não parar ou remover algum container importante
- Sugiro que crie um container novo para realizar a pratica, se o seu objetivo for somente aprender.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.