# GamesRobot 🤖🎮

![Robot Framework Tests](https://github.com/larissambasso/GameTracker/actions/workflows/robot.yml/badge.svg)

Projeto pessoal de estudo de automação de testes focado no site **Tracker** — uma aplicação de gerenciamento de biblioteca de jogos. Este repositório demonstra a implementação de padrões robustos de automação, garantindo confiabilidade e facilidade de manutenção.

## ✅ Visão Geral
O **GamesRobot** é um framework de automação que cobre desde validações de Smoke Tests até fluxos complexos de regras de negócio (E2E).
- **Cobertura**: UI (Funcional), API (Backend), E2E e Regressão.
- **Stack Tecnológica**:
  - **Framework**: [Robot Framework](https://robotframework.org/)
  - **Engine**: [Browser Library](https://marketsquare.github.io/robotframework-browser/Browser.html) (Baseado em Playwright)
  - **Linguagem**: Python
  - **Runner**: PowerShell Script (`run.ps1`) personalizado para carregamento de ambiente.

---

## ✅ Objetivo e Escopo
O projeto resolve o problema de regressão manual em fluxos críticos de gerenciamento de jogos, onde a interação entre listas (Navegação entre abas: Jogarei, Jogando, Zerados) requer precisão.
- **No Escopo**: Login (sucesso/falha), CRUD de jogos, transição entre estados da biblioteca, validação de estatísticas e integridade da API.

---

## ✅ Sistema/Aplicação Testada
- **Aplicação**: [Tracker Web App](https://ephemeral-alfajores-312419.netlify.app/)
- **Ambiente**: Teste
- **Notas**: Utiliza autenticação via Supabase com massa de dados persistente para validação de estatísticas históricas.

---

## ✅ Estrutura do Projeto
O projeto segue o padrão **Page Object Model (POM)** com separação clara de responsabilidades:

```text
GamesRobot/
├── .github/workflows/    # CI/CD Pipelines (GitHub Actions)
├── access/               # Massa de dados e credenciais (Isolamento de Dados)
├── config/               # Configurações globais e Endpoints
├── resources/
│   ├── components/       # Keywords compartilhadas entre páginas
│   ├── pages/            # Page Objects (Definição de elementos e ações por tela)
│   └── shared/           # Validadores genéricos (ex: API Validator)
├── tests/
│   ├── api/              # Suítes de teste de backend
│   └── functional/       # Suítes de teste de interface (UI)
├── results/              # Relatórios e evidências (Ignorado pelo Git)
└── run.ps1               # Runner personalizado (Carrega .env + Robot)
```

---

## ✅ Como Rodar

### Pré-requisitos
- [Python 3.11+](https://www.python.org/)
- [Node.js](https://nodejs.org/) (Para o Browser library)

### Instalação
1. Clone o repositório.
2. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```
3. Inicialize a Browser Library:
   ```bash
   rfbrowser init
   ```

### Execução
O projeto utiliza um script centralizado (`run.ps1`) que carrega automaticamente o arquivo `.env`.

- **Todos os testes**:
  ```powershell
  .\run.ps1
  ```
- **Por Suite/Arquivo**:
  ```powershell
  .\run.ps1 tests/functional/checklogin.robot
  ```
- **Por Tag (ex: smoke)**:
  ```powershell
  .\run.ps1 -i smoke
  ```
- **Modo Headless (Padrão: True)**: Altere no `.env` para `HEADLESS=False` para ver a execução.

### Relatórios
Após a execução, abra o arquivo `results/log.html` em qualquer navegador para ver o detalhamento passo a passo.

---

## ✅ Variáveis de Ambiente
O projeto utiliza um arquivo `.env` para gerenciar informações sensíveis e endpoints.
1. Copie o arquivo de exemplo: `cp .env.example .env`
2. Preencha com suas credenciais.

> [!IMPORTANT]
> **Nunca commit** o arquivo `.env`. Suas credenciais são protegidas e o arquivo já está no `.gitignore`.

---

## ✅ Estratégia de Testes
Minha abordagem foca em **estabilidade** e **valor de negócio**:
- **Wait Inteligente**: Não utilizamos `Sleep`. O framework utiliza Waits dinâmicos (`Wait For Elements State`) para lidar com a assincronia do React/Supabase.
- **Resiliência do Runner**: O script `run.ps1` garante que o ambiente esteja pronto antes de qualquer execução.

---

## ✅ CI/CD
Implementado via **GitHub Actions** (`robot.yml`):
- **Triggers**: Executa automaticamente em cada `push` ou `pull_request`.
- **Artefatos**: Screenshots e Logs de falha são armazenados como artefatos do GitHub Action após cada rodada.

---

## ✅ Evidências
As evidências de teste (screenshots e vídeos de falha) são geradas automaticamente na pasta `results/` em caso de erro, permitindo depuração rápida.

![Log Exemplo](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide_files/log.html.png) *(Ilustrativo: os relatórios reais são gerados localmente em /results)*
