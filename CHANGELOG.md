# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [1.1.1] - 2026-02-08

### ✨ Adicionado
- **lasc-help** - Central de ajuda completa
  - Lista todos os 17 comandos
  - Descrição de cada um
  - Dicas e atalhos
  
- **lasc-version** - Informações de versão
  - Versão atual e codinome
  - Novidades da versão
  - Links úteis

### 🔄 Mudado
- Welcome message aprimorada (/etc/motd)
- lasc-doctor agora valida 17 comandos
- Total de comandos: 15 → 17

---

### 🎉 Recuperação e Expansão

Esta versão marca a recuperação completa do sistema após perda acidental durante reinstalação, e adiciona 3 novas ferramentas essenciais.

### ✨ Adicionado
- **lasc-network** - Gerenciador de rede completo
  - Status de interfaces (UP/DOWN)
  - IP local, Gateway e DNS
  - Teste de conectividade
  - Estatísticas de rede (RX/TX)
  
- **lasc-process** - Monitor de processos
  - Estatísticas de processos (total, rodando, dormindo)
  - Lista de processos ativos
  - Integração com htop
  
- **lasc-log** - Visualizador de logs do sistema
  - Últimos logs via journalctl
  - Comandos úteis para debug
  - Integração com dmesg

- **18 Apps Essenciais Instalados:**
  - Comunicação: Firefox ESR, Telegram, Geary
  - Mídia: Lollypop, Celluloid, Eye of GNOME
  - Produtividade: Text Editor, Calculator, Calendar, Contacts, Clocks, Weather, Evince
  - Desenvolvimento: Git 2.52.0, Python 3.12.12, Node.js, Vim, Htop

### 🔄 Mudado
- Menus atualizados (store: 12 opções, android: 18 opções)
- lasc-doctor agora valida 15 comandos (antes 12)
- Aliases expandidos para novos comandos
- README atualizado com badges profissionais

### 🐛 Corrigido
- Sistema recuperado após perda total (reinstalação acidental)
- .profile restaurado completamente
- Compatibilidade BusyBox nos novos comandos
- Espaço em disco otimizado (98MB liberados via journalctl)

### 📚 Documentação
- CHANGELOG.md criado
- Badges atualizados no README
- Versão atualizada para 1.1

### 💾 Backup
- Sistema de backup testado e validado
- Recuperação bem-sucedida usando backups
- Novos backups criados com v1.1 completa

---

## [1.0] - 2026-02-07

### 🎊 Lançamento Inicial

Primeira versão pública do LASC OS - Sistema Operacional Mobile Linux completo baseado em postmarketOS.

### ✨ Adicionado

**Sistema Base:**
- postmarketOS v25.12 (Alpine Linux)
- Kernel Linux 6.18.7-0-lts
- Interface Phosh (Mobile UI)
- Systemd init system
- 3.6GB sistema otimizado

**12 Comandos Exclusivos:**
1. **lasc-dashboard** - Dashboard automático com:
   - Logo LASC em ASCII art (verde)
   - Data e hora
   - Status do sistema (uptime, kernel, processos)
   - Recursos (RAM, disco)
   - Status de rede
   - Atalhos rápidos

2. **lasc-fetch** - Informações estilizadas:
   - Logo em caixa ASCII
   - Info do sistema formatada
   - Visual neofetch-style

3. **lasc-info** - Informações detalhadas do sistema

4. **lasc-apps** - Instalador interativo:
   - 18 apps disponíveis
   - Categorizado (Comunicação, Mídia, Produtividade, Dev)
   - Opção "TUDO" para instalar todos
   - Interface numerada clara

5. **lasc-update** - Atualizador de sistema (apk update + upgrade)

6. **lasc-store** - Hub central:
   - 9 ferramentas em menu interativo
   - Loop contínuo
   - Navegação fácil

7. **lasc-android** - Launcher mobile:
   - 15 opções organizadas
   - Estilo Android com categorias
   - Apps em background (&)

8. **lasc-list** - Lista de apps instalados:
   - Checkmarks ✓/✗
   - Organizado por categoria
   - Detecção em tempo real

9. **lasc-clean** - Limpeza do sistema:
   - Cache APK
   - Arquivos temporários
   - Logs antigos (journalctl)
   - Mostra espaço liberado

10. **lasc-doctor** - Diagnóstico completo:
    - Espaço em disco
    - Uso de memória
    - Validação de comandos LASC
    - Validação de apps essenciais
    - Contador de problemas

11. **lasc-about** - Sobre o sistema:
    - Logo completo
    - Informações de versão
    - Dados do desenvolvedor
    - Licença
    - Links

12. **lasc-backup** - Sistema de backup:
    - Backup de configs (~/.profile, ~/.bashrc)
    - Backup de documentação
    - Backup de scripts (/usr/local/bin/lasc-*)
    - Timestamped archives

**Customizações:**
- Prompt colorido: `[user@LASC-OS]`
- Logo LASC verde em ASCII art
- Dashboard automático no login
- 15+ aliases úteis
- /etc/motd personalizado
- Cores ANSI em todos os comandos

**Aliases:**
- `fetch`, `info`, `store`, `android`, `apps`, `about`, `update`
- `readme`, `espaço`, `memoria`, `ll`, `cls`

**Documentação:**
- README.md completo (400+ linhas)
- Guia de instalação
- Lista de comandos
- Roadmap detalhado
- CONTRIBUTING.md
- LICENSE (MIT + GPL v3)

### 🏗️ Arquitetura
- Shell scripts POSIX-compatible
- Modular e expansível
- Compatível com BusyBox
- Package manager: apk (Alpine)

### 🎯 Dispositivos Suportados
- QEMU VM (x86_64) - Testado ✅
- PinePhone / PinePhone Pro
- OnePlus 6 / 6T
- Xiaomi Poco F1
- Google Pixel 3a/3aXL

### 📊 Estatísticas v1.0
- 12 comandos exclusivos
- 600+ linhas de código Shell
- 15+ aliases
- 400+ linhas de documentação
- ~15 horas de desenvolvimento

---

## [Unreleased]

### Planejado para v1.2
- [ ] Testes em hardware real (PinePhone)
- [ ] Interface gráfica validada (Phosh)
- [ ] Waydroid integrado (apps Android)
- [ ] LASC Store online
- [ ] Sistema de updates OTA

### Planejado para v2.0
- [ ] Suporte multi-dispositivo
- [ ] Comunidade ativa (100+ usuários)
- [ ] Marketplace de temas
- [ ] Sincronização em nuvem
- [ ] Recursos premium

---

## Tipos de Mudanças
- `✨ Adicionado` - Novas funcionalidades
- `🔄 Mudado` - Mudanças em funcionalidades existentes
- `❌ Descontinuado` - Funcionalidades que serão removidas
- `🗑️ Removido` - Funcionalidades removidas
- `🐛 Corrigido` - Correção de bugs
- `🔒 Segurança` - Vulnerabilidades corrigidas

---

**LASC OS** - *Privacidade, Liberdade, Controle* 🚀
