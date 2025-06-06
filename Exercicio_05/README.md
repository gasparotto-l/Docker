# [Exercicio_05](#exercicio_05)

## Info
- Data de Realização: 23/04/2025
- Autor: Luiz H. Gasparotto
- Execute um container MySQL e configure um volume para armazenar os dados do banco de forma persistente.

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Repositorio-React-Mysql](#repositorio-react-mysql) |
- | [Clonando](#clonando) |
- | [React-Express-Mysql](#react-express-mysql) |
- | [Subindo-Container](#subindo-container) |
- | [Volumes](#Volumes) |
- | [Testes](#Testes) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Repositorio-React-Mysql

- Para essa atividade usaremos um repositorio do github com o aplicação que desejamos, no caso o react-express-mysql, clonaremos e configuraremos um container docker com essa aplicação.

## Clonando
- Acesse o link do Repositorio que usaremos: https://github.com/docker/awesome-compose
- Em seguida clique no botão verde escrito code e copie o link https, usaremos esse link para colar o repositorio no linux.
- Agora utilize esse comando no seu terminal, para clonar o repositorio:
```bash
 git clone https://github.com/docker/awesome-compose
```

## React-Express-Mysql
- Crie uma pasta para armazenar o container da aplicação. E acesse ela:
```bash
mkdir react-express-mysql
cd react-express-mysql/
```
- Agora vamos passar a aplicação para essa pasta, e fazer o build do container nela. Isso vai garantir uma boa organização para realização da atividade.
```bash
cp -r awesome-compose/react-express-mysql/* .
```

## Subindo Container
- Utilize docker-compose e suba o container:
```bash
docker-compose up -d
```
- Resultado esperado:

![image](https://github.com/user-attachments/assets/400590c2-e933-4c87-be31-69e797a1ea12)


- Confira se os containers foram criados corretamente:
```bash
docker ps 
```
- Tudo deu certo voce deve ser capaz de ver as tres camadas da nossa aplicação.

![image](https://github.com/user-attachments/assets/83356746-a7df-47e1-ba6a-a6f69ab5ede6)


## Volumes
- Veja o volume para confirmar que a execução foi bem sucedida
```bash
docker volume ls 
```
- Terminal:
![image](https://github.com/user-attachments/assets/cd4258b6-84e6-4c94-b996-22db83075755)


- Também inspecione o volume utilizando o codigo abaixo:
```bash
docker volume inspect react-express-mysql_db-data
```
![image](https://github.com/user-attachments/assets/f744a1b1-0938-4d27-b40d-39508b71b207)


## Testes
- Acesse http://localhost:3000 para ver o frontend da pagina

![image](https://github.com/user-attachments/assets/34d722a9-232e-447f-8670-51d9b6e50adf)


- Utilize o comando abaixo para comprovar o backend:
```bash
$ curl localhost:80
{"message":"Hello from MySQL 8.0.19"}
```
- Se os seus testes deram certo, quer dizer que tudo correu bem, parabéns.

## Observações
- Fazer os testes é essencial para comprovar a execução da pratica, então recomendo que faça os testes mostrados, e mais testes possiveis se quiser.
- Tome cuidado a fazer mudanças nessa aplicação, por se tratar de um programa de tres camadas, é importante que toda mudança considere as condições presentes em cada camada.
- Se quiser acessar esse banco de dados para aprender mais, é possivel utilizar aplicações do DBeaver ou semelhantes.

## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.

