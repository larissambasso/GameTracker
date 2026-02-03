# Documentação da Reestruturação do Projeto GamesRobot
*Gerado pelo Engenheiro de Automação de QA*

Este documento detalha a transformação da estrutura do projeto para seguir padrões de mercado (Page Object Model e Separação de Preocupações), garantindo escalabilidade e facilidade de manutenção.

---

## 1. Visão Geral da Nova Estrutura

O projeto foi reorganizado para separar **DADOS**, **LÓGICA** e **TESTES**. Antes, estava tudo misturado, o que dificultava saber onde alterar algo quando o sistema mudava.

### Estrutura Final:
```text
GamesRobot/
├── config/                  # Configurações globais
├── data/                    # Dados de teste
├── resources/               # Lógica de interação (Page Objects)
├── tests/                   # Cenários de teste
└── results/                 # Resultados de execução
```

---

## 2. Detalhamento das Mudanças

Abaixo, explico pasta por pasta o que foi criado, o que foi movido para lá e o motivo técnico.

### 📂 1. `config/` (NOVA)
**O que coloquei aqui:**
*   `endpoints.resource` (Antigo `variables/api.resource`)
*   `ui_constants.resource` (Antigo `variables/ui.resource`)

**Por que fiz isso:**
Configurações como URLs de API ou seletores globais não são "variáveis de teste" nem "lógica". Elas são configurações do ambiente. Se a URL da API mudar de `dev` para `qa`, você altera APENAS aqui, e não caça arquivos espalhados.

### 📂 2. `data/` (NOVA)
**O que coloquei aqui:**
*   `users.resource` (Antigo `variables/users.resource`)

**Por que fiz isso:**
**Isolamento de Dados.** Dados de teste (usuários, senhas, produtos) são voláteis. Eles não devem ficar misturados com o código de teste. Ao separá-los em `data/`, facilitamos a atualização da massa de testes sem risco de quebrar a lógica da automação.

### 📂 3. `resources/pages/` (ORGANIZADA)
**O que coloquei aqui:**
*   `LoginPage.resource` (Renomeado de `resources/realizarlogin.resource`)
*   `pages.resource` (Mantido, mas agora importado corretamente)

**Por que fiz isso:**
**Page Object Model (POM).**
*   Cada arquivo aqui representa UMA tela da aplicação.
*   **Regra:** Se o botão de login mudar o ID, você altera **apenas** no `LoginPage.resource`. Os 50 testes que fazem login continuam funcionando sem alteração.
*   A pasta antiga `Tests/pages` continha testes, não páginas, o que era confuso. Movi os testes reais para `tests/` e deixei aqui só a definição das páginas.

### 📂 4. `resources/shared/` (NOVA)
**O que coloquei aqui:**
*   `ApiValidator.resource` (Antigo `resources/validarAPI.resource`)

**Por que fiz isso:**
Keywords que não são de uma tela específica (como chamadas de API, validações de banco, cálculos de data) devem ficar em uma pasta compartilhada. Isso evita duplicidade de código.

### 📂 5. `tests/` (RECRIADA E ORGANIZADA)
**O que coloquei aqui:**
*   `functional/`: Todos os arquivos `.robot` que estavam erroneamente em `Tests/pages` (ex: `games.robot`, `checklogin.robot`).
*   `api/`: Testes de API que estavam em `Tests/api`.

**Por que fiz isso:**
A pasta `Tests` (com T maiúsculo) misturava conceitos. Agora:
*   `tests/` contém APENAS cenários de teste (arquivos que você executa).
*   Eles são organizados por tipo (`functional` para UI, `api` para Backend).
*   Os arquivos `.robot` aqui ficaram mais limpos, pois agora importam as Keywords das pastas corretas (`../../resources/...`).

---

## 3. Resumo da Limpeza
*   🗑 **Removido:** Pasta `Tests` (antiga e bagunçada).
*   🗑 **Removido:** Pasta `variables` (seus arquivos foram para `config/` ou `data/`).
*   ✨ **Criado:** Estrutura semântica onde o nome da pasta diz exatamente o que tem dentro.

Agora seu projeto está pronto para crescer. Use esta estrutura como guia para criar novos testes!
