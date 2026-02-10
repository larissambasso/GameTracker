# GamesRobot 🤖🎮

Projeto PESSOAL de automação de testes E2E (UI) e validações de API para o **Tracker** — uma aplicação web de biblioteca de jogos, com foco em cenários de regressão e smoke.


Suíte confiável e de facil manutençao para validar fluxos críticos de biblioteca de jogos:

Cobertura: UI funcional + API, Smoke/E2E/Regressão

Stack: Robot Framework + Browser (Playwright), Python, runner run.ps1

Boas práticas: POM, keywords reutilizáveis, waits inteligentes (sem Sleep)

CI/CD: GitHub Actions em push/PR com logs e evidências (screenshots) 


O objetivo é ter uma suíte simples, organizada e confiável para validar:
- Fluxos críticos de UI (login, navegação, cards de jogos, salvar/remover/mover entre listas)
- Mensagens e feedbacks (toasts, modais, empty states)
- Disponibilidade e autenticação da API antes de rodar os testes (Suite Setup Global)
