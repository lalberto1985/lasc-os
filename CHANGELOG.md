# Changelog
Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.
O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## [1.2.1] - 2026-02-08

### 🎨 Arte ASCII

### ✨ Adicionado
- **lasc-ascii** - Gerador de arte ASCII
  - 5 palavras disponíveis: LASC, LINUX, HELLO, LOVE, COOL
  - Arte em ASCII grande e bonita
  - Easter egg divertido!

### 📸 Documentação
- Screenshots profissionais adicionados ao README
- 6 imagens mostrando principais funcionalidades
- Projeto muito mais visual

### 🔄 Mudado
- lasc-doctor agora valida 20 comandos
- Total: 18 → 20 comandos exclusivos!

---

### 📊 Estatísticas
- **18 comandos exclusivos** (12 → 15 → 17 → 18)
- 4 temas de cores disponíveis
- 20 frases motivacionais

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
1. **lasc-dashboard** - Dashboard automático com: ...
[... resto do 1.0 mantido igual ao original ...]

## [Unreleased]
### Planejado para v1.2
- [ ] Testes em hardware real (PinePhone)
[...]

## Tipos de Mudanças
- `✨ Adicionado` - Novas funcionalidades
- `🔄 Mudado` - Mudanças em funcionalidades existentes
- `❌ Descontinuado` - Funcionalidades que serão removidas
- `🗑️ Removido` - Funcionalidades removidas
- `🐛 Corrigido` - Correção de bugs
- `🔒 Segurança` - Vulnerabilidades corrigidas

**LASC OS** - *Privacidade, Liberdade, Controle* 🚀
