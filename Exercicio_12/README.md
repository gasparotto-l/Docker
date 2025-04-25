# [Exercicio_12](#exercicio_12)

## Info
- Data de Realização: 25/04/2025
- Autor: Luiz H. Gasparotto
- Após identificar vulnerabilidades com ferramentas como o Trivy, o próximo passo é corrigi-las. Imagens grandes e genéricas frequentemente trazem bibliotecas desnecessárias e vulneráveis, além de usarem o usuário root por padrão. 
- Neste exercício, você irá trabalhar com um exemplo de Dockerfile com más práticas e aplicar melhorias para construir uma imagem mais segura e enxuta. Identifique as melhorias e gere uma nova versão de Dockerfile.

![image](https://github.com/user-attachments/assets/6000746d-d878-4158-8560-9b4eba46aa64)


## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Docker-Vulneravel](#docker-vulneravel) |
- | [Requirements.txt-Vulneravel](#requirements.txt-vulneravel) |
- | [Recapitulando-Exercicio-11](#recapitulando-exercicio-11) |
- | [Iniciando-Configurações](#iniciando-configurações) |
- | [Dockerfile-Seguro](#dockerfile-seguro) |
- | [Requirements-Seguro](#requirements-seguro) |
- | [Construindo-e-Rodando-Imagem-Segura](#construindo-e-rodando-imagem-segura) |
- | [Teste-a-Imagem](#teste-a-imagem) |
- | [Teste-de-Vulnerabilidade](#teste-de-vulnerabilidade) |
- | [Analisando-Relatorios](#analisando-relatorios) |
- | [Observações](#Observações) |
- | [Agradecimentos](#agradecimentos) |

## Docker-Vulneravel
- Antes de partimos para criação de nova imagem segura, vamos analisar porque o dockerfile que estamos usando de exemplo é vulneravel
- Observe o Dockerfile comentado abaixo:
```bash
# Utiliza uma imagem grande (python:3.9), cheia de pacotes desnecessários que podem ter vulnerabilidades.
FROM python:3.9

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo requirements.txt, mas faz isso sem separação de camadas de segurança.
COPY requirements.txt .

# Instala pacotes diretamente sem atualização do pip e sem checar se há versões mais seguras.
RUN pip install -r requirements.txt

# Copia todo o conteúdo do projeto (pode incluir arquivos sensíveis, como .env, chaves privadas etc).
COPY . .

# Executa o app como usuário root (o padrão é root), aumentando o risco em caso de invasão.
CMD ["python", "app.py"]
```
- Agora que sabemos quais são as vulnerabilidades desse docker, podemos pensar em como montar o novo docker.

## Requirements.txt-Vulneravel
- Vamos observar também, porque o requirements é vulneravel:
```bash
flask==1.1.1 # VERSÃO MUITO ANTIGA
requests==2.22.0 #VERSÃO DESATUALIZADA 
```
## Recapitulando-Exercicio-11
- Verificamos no exercicio anterior o número exorbitante de vulnerabilidades numa aplicação como essa, por isso realizar a pratica de agora se faz tão necessaria. Vamos configurar agora a imagem vulneravel e outra segura, e vamos compara-las, assim vai ficar claro se a pratica foi bem sucedida.
- Acesse o [Exercicio_11](#) antes de avançar e confira o processo de verificação de vulnerabilidades e anotação, isso vai ajudar a compreender o uso do trivy.
  
## Iniciando-Configurações
```bash
## Iniciando-Dockerfile-Seguro
- Agora para desenvolver a imagem segura, crie uma pasta:
```bash
mkdir exercicio12-seguro
```
- Acesse-a pelo VS code
```bash
cd exercicio12-seguro/
code .
```
- E Agora podemos partir pra criação e configuração de documentos

## Dockerfile-Seguro
```bash
FROM python:3.9.18-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libffi-dev libssl-dev \
    && pip install --upgrade pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -m appuser

COPY . .

USER appuser

CMD ["python", "app.py"]

```
## Requirements-Seguro
```bash
flask==2.3.2
requests==2.31.0
```

## Construindo-e-Rodando-Imagem-Segura
- Vamos criar a imagem segura configurada anteriormente e roda-la
- Navegue até a pasta
```bash
cd exercicio12-seguro/
```
- Construa a imagem
```bash
docker build -t exercicio12-seguro .
```
- Agora vamos roda-la
```bash
docker run -d --name exercicio12-container -p 8000:8000 exercicio12-seguro
```
- Confira se a mesma está rodando
```bash
docker ps
```
- Retorno:
![image](https://github.com/user-attachments/assets/f457f334-246d-4226-9614-c0f5de1a5458)

## Teste-a-Imagem
- Acesse http://localhost:8000
![image](https://github.com/user-attachments/assets/4989591b-08e2-4872-9e85-c7d42e1638b5)
- Também utilize o curl para verificar a pagina pelo temrminal
```bash
curl http://localhost:8000
```
- Retorno:
![image](https://github.com/user-attachments/assets/270092d3-faec-43ff-b928-ba24fd0b9fe3)
- Verifique também se está configurado como root na maquina:
```bash
docker exec -it exercicio12-container sh
whoami
```
Retorno:
![image](https://github.com/user-attachments/assets/1fd8e41c-78e7-447b-9f71-2d0001c2a1d0)

## Teste-de-Vulnerabilidade
- Agora utilize o trivy baixado anteriormente no exercicio 11 e utilize o mesmo teste no python:3.9, pegue somente os erros high e critical.
- Gere o Relatorio da Imagem do exericio11 novamente:
![image](https://github.com/user-attachments/assets/4318fa1b-fc02-477f-bce7-921a944f6ef9)
```bash
jq -r '
  "| Pacote | Versão atual | Correção disponível | Severidade | Ação sugerida |",
  "|--------|--------------|---------------------|------------|---------------|",
  (.Results[] | select(.Vulnerabilities != null) | .Vulnerabilities[] |
    "| \(.PkgName) | \(.InstalledVersion) | \(.FixedVersion // "❌ Não") | \(.Severity) | \(
      if .FixedVersion then
        "Atualizar para a versão \(.FixedVersion)"
      else
        "Considerar substituição ou monitorar atualizações futuras"
      end
    ) |"
  )
' resultado1.json | uniq | column -t -s '|' > relatorio1.md
```
- Agora vamos gerar o relatorio da nossa imagem segura:
![image](https://github.com/user-attachments/assets/438435a2-a555-4cb0-b830-67887e6379b0)
```bash
jq -r '
  "| Pacote | Versão atual | Correção disponível | Severidade | Ação sugerida |",
  "|--------|--------------|---------------------|------------|---------------|",
  (.Results[] | select(.Vulnerabilities != null) | .Vulnerabilities[] |
    "| \(.PkgName) | \(.InstalledVersion) | \(.FixedVersion // "❌ Não") | \(.Severity) | \(
      if .FixedVersion then
        "Atualizar para a versão \(.FixedVersion)"
      else
        "Considerar substituição ou monitorar atualizações futuras"
      end
    ) |"
  )
' resultado2.json | uniq | column -t -s '|' > relatorio2.md
```
- Agora vamos partir pra proxima etapa.

## Analisando-Relatorios
- Relatorio1 da imagem vulneravel:
![image](https://github.com/user-attachments/assets/d9dfe87e-26d7-46bb-b1de-ea6c1b39fa2f)
- Relatorio2 da imagem segura:
![image](https://github.com/user-attachments/assets/ca14cf16-d45e-40e9-a33c-d5f720687e02)

- Vamos listar o numero de vulnerabilidades e ver se conseguimos reduzir as vulnerabilidades:
```bash
echo $(( $(wc -l < relatorio1.md) - 2 ))
```
- Número de vulnerabilidades da imagem vulneravel:
- 
![image](https://github.com/user-attachments/assets/16286052-d35f-477f-b919-2e963a47935b)

- Número de vulnerabilidades da nova imagem:
```bash
echo $(( $(wc -l < relatorio2.md) - 2 ))
```
![image](https://github.com/user-attachments/assets/697e0b54-386d-45cb-8919-1c0959601041)

- Conseguimos observar a redução de 21 vulnerabilidades criticas ou altas, além de termos um relatorio de que é possivel modificar na nossa imagem, caso quisermos reduzir ainda mais as vulnerabilidades. 


## Observações


## Agradecimentos
Obrigado pela atenção, espero que tenha gostado.
Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.


