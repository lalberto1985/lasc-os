# LASC OS v1.1
### Sistema Operacional Mobile Linux

# LASC OS v1.1
### Sistema Operacional Mobile Linux

![Version](https://img.shields.io/badge/version-1.1-brightgreen)
![License](https://img.shields.io/badge/license-MIT%20%2B%20GPL%20v3-blue)
![Platform](https://img.shields.io/badge/platform-Linux%20Mobile-orange)
![Commands](https://img.shields.io/badge/commands-15%20exclusive-yellow)
![Apps](https://img.shields.io/badge/apps-18%20installed-purple)
![Status](https://img.shields.io/badge/status-Beta%20Public-green)
![Language](https://img.shields.io/badge/language-Shell-lightgrey)
![Made in Brazil](https://img.shields.io/badge/made%20in-Brazil%20🇧🇷-green)

**Sistema operacional mobile completo baseado em postmarketOS, desenvolvido do zero com foco em privacidade, customização e controle total.**

---

## 🚀 Features

- ✅ **12 comandos exclusivos** desenvolvidos do zero
- ✅ **Interface Android-style** via terminal
- ✅ **18+ apps disponíveis** via instalador integrado
- ✅ **Sistema de backup** automatizado
- ✅ **Diagnóstico completo** do sistema
- ✅ **Launcher mobile** com categorias organizadas
- ✅ **Documentação completa** em português

## 📱 Screenshots
```
     ██╗      █████╗ ███████╗ ██████╗ 
     ██║     ██╔══██╗██╔════╝██╔════╝ 
     ██║     ███████║███████╗██║      
     ██║     ██╔══██║╚════██║██║      
     ███████╗██║  ██║███████║╚██████╗ 
     ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ 
```

## 🎯 Visão do Projeto

O LASC OS é uma alternativa open source aos sistemas proprietários (Android, iOS), oferecendo:

- 🔒 **Privacidade total** - Sem Google, sem tracking
- 🔓 **Open Source 100%** - Código aberto completo
- ⚙️ **Customização infinita** - Controle total do sistema
- 💻 **Terminal poderoso** - Acesso root completo
- 📱 **Interface mobile** - Phosh UI otimizada

## 📦 Instalação

### Pré-requisitos
- Linux (Ubuntu, Debian, Arch, etc)
- Python 3.7+
- Git
- 10GB espaço livre

### Quick Start
```bash
# 1. Instalar pmbootstrap
pip install pmbootstrap

# 2. Clonar repositório LASC OS
git clone https://github.com/[seu-usuario]/lasc-os.git
cd lasc-os

# 3. Extrair customizações
tar -xzf backups/lasc_scripts.tar.gz -C /
tar -xzf backups/lasc_backup.tar.gz -C ~/

# 4. Configurar sistema
source ~/.profile

# 5. Testar
lasc-fetch
```

### Instalação Completa (VM)
```bash
# Inicializar pmbootstrap
pmbootstrap init

# Vendor: qemu
# Device: amd64
# UI: phosh

# Instalar sistema
pmbootstrap install

# Iniciar VM
pmbootstrap qemu --display=none -p 3333 &

# Conectar via SSH
ssh -p 3333 user@localhost

# Instalar LASC OS
# [Instruções detalhadas no wiki]
```

### Instalação em Hardware Real

Dispositivos suportados:
- **PinePhone / PinePhone Pro** (~$150)
- **OnePlus 6 / 6T**
- **Xiaomi Poco F1**
- **Google Pixel 3a/3aXL**

[Ver guia completo de instalação →](docs/INSTALLATION.md)

## ⚡ Comandos Exclusivos

### Launcher e Menus
- `android` - Menu principal (15 opções)
- `store` - Loja de apps (9 opções)

### Sistema
- `fetch` - Info estilizada
- `info` - Info detalhada
- `apps` - Lista de apps instalados
- `lasc-doctor` - Diagnóstico completo
- `lasc-clean` - Limpeza do sistema
- `lasc-backup` - Backup automático
- `about` - Sobre o sistema
- **`lasc-network` / `network`** - Gerenciador de rede ✨ **NOVO v1.1**
- **`lasc-process` / `processos`** - Monitor de processos ✨ **NOVO v1.1**
- **`lasc-log` / `logs`** - Visualizador de logs ✨ **NOVO v1.1**

### Gerenciamento
- `lasc-apps` - Instalador interativo (18 apps)
- `update` - Atualizar sistema

[Documentação completa dos comandos →](docs/COMMANDS.md)

## 🏗️ Arquitetura
```
LASC OS
├── Base: postmarketOS v25.12 (Alpine Linux)
├── Kernel: Linux 6.18.7-0-lts
├── Init: systemd
├── UI: Phosh (Mobile)
├── Shell: ash (BusyBox)
└── Package Manager: apk
```

## 🛠️ Tecnologias

- **Base:** postmarketOS / Alpine Linux
- **Linguagem:** Shell Script (600+ linhas)
- **UI Framework:** Phosh (GNOME mobile)
- **Virtualização:** QEMU/KVM
- **Build System:** pmbootstrap

## 📚 Documentação

- [Guia de Instalação](docs/INSTALLATION.md)
- [Comandos Completos](docs/COMMANDS.md)
- [FAQ](docs/FAQ.md)
- [Contribuindo](CONTRIBUTING.md)
- [Roadmap](ROADMAP.md)

## 🤝 Contribuindo

Contribuições são bem-vindas! Veja [CONTRIBUTING.md](CONTRIBUTING.md) para detalhes.

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📝 Roadmap

### v1.0 (Atual) ✅
- [x] Sistema base funcional
- [x] 12 comandos exclusivos
- [x] Dashboard e launchers
- [x] Sistema de backup
- [x] Documentação completa

### v1.1 (Próximo)
- [ ] Testes em hardware real (PinePhone)
- [ ] Interface gráfica validada
- [ ] Waydroid integrado (apps Android)
- [ ] LASC Store online
- [ ] Sistema de updates automático

### v2.0 (Futuro)
- [ ] Multi-dispositivo
- [ ] Comunidade ativa
- [ ] Marketplace de temas
- [ ] Sincronização em nuvem

[Ver roadmap completo →](ROADMAP.md)

## 📄 Licença

**Sistema base:** GPL v3 (postmarketOS/Alpine Linux)  
**Customizações LASC:** MIT License

Ver [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**Luiz A. S. Corrêa**  
- LinkedIn: [Seu LinkedIn]
- Email: [luizascorrea@hotmail.com]
- Localização: Pinhais/PR, Brasil

## 🌟 Reconhecimentos

- [postmarketOS](https://postmarketos.org/) - Base do sistema
- [Alpine Linux](https://alpinelinux.org/) - Distribuição base
- [Phosh](https://gitlab.gnome.org/World/Phosh) - Interface mobile
- Comunidade open source 💚

## 📊 Status do Projeto

- **Status:** Beta Público
- **Versão:** 1.0
- **Última atualização:** Fevereiro 2026
- **Dispositivos testados:** QEMU VM (x86_64)
- **Hardware real:** Em desenvolvimento

## 🔗 Links Úteis

- [Site Oficial](https://lasc-os.com) _(em breve)_
- [Wiki](https://github.com/lalberto1985/lasc-os/wiki)
- [Issues](https://github.com/lalberto1985/lasc-os/issues)
- [Discussões](https://github.com/lalberto1985/lasc-os/discussions)

---

**LASC OS** - *Privacidade, Liberdade, Controle* 🚀

Made with ❤️ in Brazil 🇧🇷
