# [Exercicio_11](#exercicio_11)

## Info
- Data de Realização: 24/04/2025
- Autor: Luiz H. Gasparotto

### Descrição
- Trivy é uma ferramenta open source para análise de vulnerabilidades
em imagens Docker. Neste exercício, você irá analisar uma imagem
pública, como python:3.9 ou node:16, em busca de vulnerabilidades
conhecidas.
- Você deverá:
    - a. Instalar o Trivy na sua máquina (via script ou pacote).
    - b. Rodar trivy image python:3.9 para analisar.
    - c. Identificar vulnerabilidades com severidade HIGH ou CRITICAL.
    - d. Anotar os pacotes ou bibliotecas afetadas e sugerir possíveis ações
(como atualização da imagem base ou substituição de
dependências).

## Requisitos
- Um computador pessoal e acesso a internet
- Visual studio code instalado(ou outra interface)
- Subsistema Linux, SO linux ou VM linux.
- Rancher desktop ou docker hub instalado.

## Menu de Navegação do projeto
- | [Info](#info) | [requisitos](#requisitos) |
- | [Instalando-Trivy](#instalando-trivy) |
- | [Rodando-Trivy](#rodando-trivy) |
- | [Vulnerabilidades-Critical-High](#vulnerabilidades-critical-high) |
- | [Anotar-Vulnerabilidades](#anotar-vulnerabilidades) |
- | [Observações](#observações) |
- | [Agradecimentos](#agradecimentos) |

## Instalando-Trivy
- Utilize o metodo e comandos abaixo para instalar o trivy, e a maneira recomendada pelo proprio site do trivy:
```bash
sudo apt-get install wget gnupg

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt-get update

sudo apt-get install trivy
```
- Vefique se o trivy está instalado
```bash
trivy --version
```

## Rodando-Trivy
- Rode o trivy verificando a imagem escolhida, no caso python:3.9
```bash
trivy image python:3.9
```
- Retorno:
IMAGEM 

## Vulnerabilidades-Critical-High

- Agora vamos filtrar apenas pelas vulnerabilidades high e critical
```bash
trivy image --severity HIGH,CRITICAL python:3.9
```

## Anotar-Vulnerabilidades
- Fiz de forma automatizada pra não termos que ficar lendos e anotando cada erro.
- Então executamos o comando anterior e salvamos em uma saida JSON
```bash
trivy image --severity HIGH,CRITICAL --format json python:3.9 > resultado.json
```
- Agora processamos nosso JSON
```bash
jq -r '[
    "| Pacote | Versão atual | Correção disponível | Severidade | Ação sugerida |",
    "|--------|--------------|---------------------|------------|---------------|",
    (.Results[] | .Vulnerabilities[] | 
      "| \(.PkgName) | \(.InstalledVersion) | \(.FixedVersion // "❌ Não") | \(.Severity) | \(
        if .FixedVersion then 
          "Atualizar para a versão \(.FixedVersion)" 
        else 
          "Considerar substituição ou monitorar atualizações futuras" 
        end
      ) |"
    )
  ] | .[]' resultado.json > relatorio.md
```
- Caso não funcione, verifique se o jq está instalado. 
```bash
jq --version

```
- Se não tiver instalado, instale com o comando abaixo e tente processar o JSON novamente
```bash
sudo apt-get install jq
```

- Leia o documento criado e por agora é só!
```bash
cat relatorio.md | column -t -s '|'
```

- Retorno:
IMAGEM

## Observações


## Agradecimentos
- Obrigado pela atenção, espero que tenha gostado.
- Caso encontre erros a serem corrigidos, me informe e estou totalmente disponivel para editar.

