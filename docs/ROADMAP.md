# LASC OS — Roadmap

Planejamento técnico do LASC OS a partir da Foundation 1.5.0.

> O roadmap representa direção de desenvolvimento e pode ser ajustado
> conforme validações técnicas e evolução do projeto.

Última atualização: Setembro de 2026.

---

## Visão geral

| Versão | Foco | Status |
|--------|------|--------|
| 1.5.0 | Foundation técnica | 🔄 Em desenvolvimento |
| 1.6.0 | Control Center GTK4/Libadwaita | 📅 Planejado |
| 1.7.0 | Hardware real e PinePhone | 📅 Planejado |
| 1.8.0 | Distribuição, repositório e updates | 📅 Planejado |
| 1.9.0 | Waydroid experimental | 📅 Planejado |
| 2.0.0 | Primeira versão estável | 📅 Planejado |

---

## 1.5.0 — Foundation

Objetivo: transformar o projeto histórico em uma base técnica
versionada, testável, empacotável e reproduzível.

### Runtime

- [x] Estrutura `src/bin` para comandos
- [x] 17 comandos `lasc-*` atuais
- [x] Bibliotecas compartilhadas em `src/lib/lasc`
- [x] 3 bibliotecas compartilhadas
- [x] Compatibilidade POSIX `sh`
- [x] Versão central em `VERSION`
- [x] Layout de runtime padronizado em `/usr`

### Instalação

- [x] Remover dependência de tarballs históricos
- [x] Remover restauração de backups como método de instalação
- [x] Reescrever `scripts/install.sh`
- [x] Suportar instalação isolada com `DESTDIR`
- [x] Usar no instalador o mesmo layout do pacote APK

### Empacotamento Alpine

- [x] Criar `APKBUILD`
- [x] Construir pacote `lasc-os`
- [x] Criar subpacote `lasc-os-doc`
- [x] Instalar e validar o APK em Alpine isolado
- [x] Publicar APKs como artifacts da CI
- [x] Validar metadados do pacote
- [x] Atualizar snapshot final da Foundation no `APKBUILD`
- [ ] Gerar e validar release de pacote final da etapa

### Testes e CI

- [x] Criar suíte `test-foundation.sh`
- [x] Validar os 17 comandos
- [x] Validar as 3 bibliotecas
- [x] Validar sintaxe POSIX
- [x] Detectar padrões legados/perigosos
- [x] Testar operações seguras
- [x] Testar instalador com `DESTDIR`
- [x] Criar Foundation CI
- [x] Criar APK Build CI

### Documentação

- [x] Atualizar README
- [x] Atualizar guia de instalação
- [x] Atualizar troubleshooting
- [x] Remover backups históricos do estado atual do repositório
- [x] Atualizar changelog para 1.5.0
- [x] Atualizar guia de contribuição
- [x] Concluir documentação da Foundation

### Critério de conclusão

A 1.5.0 estará concluída quando:

- testes locais estiverem verdes;
- Foundation CI estiver verde;
- APK Build CI estiver verde;
- documentação representar a arquitetura atual;
- snapshot final do `APKBUILD` estiver atualizado;
- pacote final da Foundation tiver sido validado.

---

## 1.6.0 — Control Center

Objetivo: criar uma interface gráfica própria para configuração e
administração do LASC OS.

### Interface

- [ ] Criar aplicação com GTK4
- [ ] Utilizar Libadwaita
- [ ] Definir identidade visual do LASC OS
- [ ] Criar navegação adequada para dispositivos mobile
- [ ] Integrar informações de versão e sistema

### Funcionalidades iniciais

- [ ] Informações do sistema
- [ ] Rede
- [ ] Processos
- [ ] Logs
- [ ] Atualizações
- [ ] Aplicativos
- [ ] Limpeza
- [ ] Backup
- [ ] Sobre o LASC OS

### Arquitetura

- [ ] Reutilizar a lógica existente quando apropriado
- [ ] Evitar duplicação de regras entre CLI e interface gráfica
- [ ] Definir APIs internas estáveis para o Control Center

---

## 1.7.0 — Hardware

Objetivo: validar o LASC OS em hardware mobile real.

### Dispositivo inicial

- [ ] Definir PinePhone como primeiro alvo de validação
- [ ] Preparar ambiente postmarketOS correspondente
- [ ] Validar boot
- [ ] Validar Phosh
- [ ] Validar display e touchscreen
- [ ] Validar Wi-Fi
- [ ] Validar Bluetooth
- [ ] Validar áudio
- [ ] Validar bateria
- [ ] Validar suspensão e retomada
- [ ] Validar os componentes LASC no dispositivo

### Qualidade

- [ ] Documentar limitações encontradas
- [ ] Criar procedimento reproduzível de instalação
- [ ] Definir matriz inicial de hardware suportado

---

## 1.8.0 — Distribuição

Objetivo: transformar os APKs validados em um canal real de
distribuição.

### Repositório

- [ ] Criar repositório APK do LASC OS
- [ ] Definir chave permanente de assinatura
- [ ] Proteger e documentar o processo de assinatura
- [ ] Publicar índice de pacotes
- [ ] Definir canais de desenvolvimento e estabilidade

### Atualizações

- [ ] Instalar `lasc-os` através do repositório
- [ ] Atualizar `lasc-os` através do `apk`
- [ ] Definir política de versões
- [ ] Definir política de rollback
- [ ] Documentar upgrade entre versões

### Automação

- [ ] Automatizar publicação de pacotes
- [ ] Validar artifacts antes da publicação
- [ ] Criar processo de release reproduzível

---

## 1.9.0 — Waydroid Experimental

Objetivo: estudar integração opcional com aplicações Android.

- [ ] Validar requisitos do Waydroid no ambiente alvo
- [ ] Avaliar compatibilidade com hardware escolhido
- [ ] Criar instalação experimental
- [ ] Testar aplicações Android
- [ ] Medir consumo de memória e armazenamento
- [ ] Documentar limitações
- [ ] Manter a integração opcional

Waydroid não faz parte da Foundation e não é requisito para o LASC OS
funcionar.

---

## 2.0.0 — Stable

Objetivo: primeira versão estável do LASC OS.

### Requisitos

- [ ] Foundation consolidada
- [ ] Control Center estável
- [ ] Hardware alvo validado
- [ ] Instalação reproduzível
- [ ] Repositório APK operacional
- [ ] Atualizações validadas
- [ ] Documentação completa
- [ ] Processo de release definido
- [ ] Ausência de bugs críticos conhecidos

### Resultado esperado

Uma experiência mobile Linux consistente, instalável, atualizável e
documentada sobre Alpine Linux/postmarketOS.

---

## Princípios do projeto

O desenvolvimento deve priorizar:

1. segurança;
2. reprodutibilidade;
3. simplicidade;
4. compatibilidade com Alpine/postmarketOS;
5. código versionado como fonte de verdade;
6. testes antes de distribuição;
7. funcionalidades comprovadas antes de serem anunciadas como prontas.

---

**LASC OS — Privacidade • Liberdade • Controle**
