# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [1.5.0] - 2026-09-07

### Foundation

Esta versão reorganiza o LASC OS sobre uma fundação técnica versionada,
testável, empacotável e reproduzível.

### Adicionado

- Estrutura de comandos em `src/bin`.
- Bibliotecas compartilhadas em `src/lib/lasc`:
  - `version.sh`
  - `system.sh`
  - `privilege.sh`
- Arquivo `VERSION` como fonte de versão do projeto.
- Suíte automatizada `tests/test-foundation.sh`.
- Foundation CI.
- APK Build CI utilizando Alpine Linux.
- Empacotamento Alpine através de `packaging/alpine/APKBUILD`.
- Pacote principal `lasc-os`.
- Subpacote de documentação `lasc-os-doc`.
- Teste automatizado de instalação do APK.
- Publicação dos APKs como artifacts da CI.
- Instalador de desenvolvimento com suporte a `DESTDIR`.

### Alterado

- Runtime consolidado em 17 comandos `lasc-*`.
- Scripts modernizados para POSIX `sh`.
- Bibliotecas compartilhadas instaladas em `/usr/lib/lasc-os`.
- Comandos instalados em `/usr/bin`.
- Metadados do runtime instalados em `/usr/share/lasc-os`.
- `lasc-version` passou a utilizar a versão central do projeto.
- Changelog de runtime passou para `/usr/share/lasc-os/CHANGELOG.md`.
- Instalador passou a utilizar o mesmo layout do pacote APK.
- README atualizado para representar a Foundation 1.5.0.
- Guia de instalação reescrito.
- Guia de troubleshooting reescrito.
- Roadmap reorganizado em etapas técnicas até a 2.0.

### Removido

- Dependência de backups históricos como método de instalação.
- Extração de tarballs diretamente em `/`.
- Restauração de arquivos do usuário como parte do instalador.
- Oito tarballs antigos de instalação do estado atual do repositório.
- Dependência de `/usr/local/bin` para os comandos LASC.
- Comandos históricos que não fazem parte do runtime atual:
  - `lasc-theme`
  - `lasc-quote`
  - `lasc-ascii`
  - `lasc-wifi`
  - `lasc-battery`
  - `lasc-brightness`

### Validação

- 17 comandos validados automaticamente.
- 3 bibliotecas compartilhadas validadas.
- Sintaxe POSIX validada.
- Padrões legados e perigosos verificados.
- Operações seguras de limpeza e backup testadas.
- Instalador validado em ambiente isolado com `DESTDIR`.
- Pacote APK construído e instalado em Alpine isolado.
- Pacote de documentação separado do runtime.

---

## [1.4.0] - 2026-02-10

### 🎨 Visual Premium Edition

Esta versão transforma o LASC OS em uma experiência visual completa e personalizável.

### ✨ Adicionado

- **4 Temas Novos** — Total de 8 temas disponíveis
  - Fire — Vermelho intenso
  - Ice — Azul gelo
  - Sunset — Laranja pôr do sol
  - Forest — Verde floresta
- **10 Frases Novas** — Total de 30 frases motivacionais sobre programação, Linux e sucesso
- **5 ASCII Arts Novos** — Total de 10 palavras: CODE, OPEN, FREE, POWER, BRAVE

### 🔄 Mudado

- Sistema de temas expandido de 4 para 8 opções
- `lasc-quote` com 50% mais conteúdo
- `lasc-ascii` com 100% mais palavras

### 📊 Estatísticas da Versão

- 8 temas disponíveis
- 30 frases motivacionais
- 10 ASCII arts diferentes

---

## [1.3.0] - 2026-02-09

### 📱 Mobile Ready

### ✨ Adicionado

- **`lasc-wifi`** — Gerenciador WiFi completo (escanear, conectar, desconectar, status)
- **`lasc-battery`** — Monitor de bateria com barra visual, voltagem e alertas
- **`lasc-brightness`** — Controle de brilho com presets e ajuste interativo

### 🎯 Marco

- **23 comandos exclusivos** — Sistema completo para dispositivos móveis

### 📊 Estatísticas da Versão

- Comandos: 20 → 23 (+15%)
- Funcionalidades mobile: 100% implementadas

---

## [1.2.0] - 2026-02-09

### 🎨 Arte ASCII e Documentação Visual

### ✨ Adicionado

- **`lasc-ascii`** — Gerador de arte ASCII com 5 palavras (LASC, LINUX, HELLO, LOVE, COOL)
- Screenshots profissionais no README (6 imagens)

### 🔄 Mudado

- `lasc-doctor` agora valida 20 comandos
- Total de comandos: 18 → 20

---

## [1.1.1] - 2026-02-08

### 🛠 Usabilidade

### ✨ Adicionado

- **`lasc-help`** — Central de ajuda com lista de todos os comandos, descrições e dicas
- **`lasc-version`** — Informações de versão, codinome e novidades

### 🔄 Mudado

- Welcome message aprimorada (`/etc/motd`)
- `lasc-doctor` agora valida 17 comandos
- Total de comandos: 15 → 17

---

## [1.1.0] - 2026-02-08

### 🔄 Validação e Expansão

Esta versão marca a recuperação completa do sistema após perda acidental durante reinstalação.

### ✨ Adicionado

- **`lasc-network`** — Status de rede, IP, Gateway, DNS e estatísticas RX/TX
- **`lasc-process`** — Monitor de processos com integração ao htop
- **`lasc-log`** — Visualizador de logs via journalctl e dmesg
- **18 Apps instalados**: Firefox ESR, Telegram, Geary, Lollypop, Celluloid, Eye of GNOME, Text Editor, Calculator, Calendar, Contacts, Clocks, Weather, Evince, Git 2.52.0, Python 3.12.12, Node.js, Vim, Htop

### 🔄 Mudado

- Menus atualizados (store: 12 opções, android: 18 opções)
- `lasc-doctor` valida 15 comandos
- Aliases expandidos

### 🐛 Corrigido

- Sistema recuperado após perda total (reinstalação acidental)
- `.profile` restaurado completamente
- Compatibilidade BusyBox nos novos comandos
- Otimização de espaço em disco (98MB liberados)

---

## [1.0.0] - 2026-02-07

### 🎊 Lançamento Inicial

Primeira versão pública do LASC OS — Sistema Operacional Mobile Linux completo baseado em postmarketOS.

### ✨ Adicionado

**Sistema Base:**
- postmarketOS v25.12 (Alpine Linux)
- Kernel Linux 6.18.7-0-lts
- Interface Phosh (Mobile UI)
- Sistema de 3.6GB otimizado

**12 Comandos Exclusivos:**
- `lasc-dashboard` — Dashboard automático com status do sistema
- `lasc-fetch` / `fetch` — Informações estilizadas com logo ASCII
- `lasc-info` / `info` — Informações detalhadas do sistema
- `lasc-apps` — Instalador de aplicativos
- `lasc-update` / `update` — Atualizador de sistema
- `lasc-store` / `store` — Hub central com ferramentas
- `lasc-android` / `android` — Launcher mobile
- `lasc-list` / `apps` — Lista de apps instalados
- `lasc-clean` — Limpeza de sistema
- `lasc-doctor` — Diagnóstico completo
- `lasc-about` / `about` — Sobre o sistema
- `lasc-backup` — Sistema de backup

**Customizações:**
- Logo LASC verde personalizado
- Prompt colorido `[user@LASC-OS]`
- 15+ aliases úteis configurados
- README e documentação em português

---

## Tipos de Mudanças

- `✨ Adicionado` — Novas funcionalidades
- `🔄 Mudado` — Mudanças em funcionalidades existentes
- `❌ Descontinuado` — Funcionalidades que serão removidas
- `🗑️ Removido` — Funcionalidades removidas
- `🐛 Corrigido` — Correção de bugs
- `🔒 Segurança` — Vulnerabilidades corrigidas

---

**LASC OS** — *Privacidade, Liberdade, Controle*
