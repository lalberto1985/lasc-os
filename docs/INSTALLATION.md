# Guia de Instalação - LASC OS v1.3.0

## 📋 Requisitos

### Hardware Mínimo
- **Dispositivo suportado:**
  - PinePhone / PinePhone Pro (Recomendado)
  - OnePlus 6 / 6T
  - Xiaomi Poco F1
  - Google Pixel 3a / 3aXL
  - QEMU VM (para testes)

- **Especificações:**
  - RAM: 2GB+ (4GB recomendado)
  - Storage: 8GB+ (16GB recomendado)
  - Bootloader desbloqueado (para devices Android)

### Software Necessário
- Linux (Ubuntu 20.04+, Debian, Arch, Fedora)
- Python 3.7+
- Git
- pmbootstrap
- 10GB espaço livre no PC

---

## 🚀 Instalação Rápida (VM - Testes)

### 1. Instalar pmbootstrap
```bash
pip3 install --user pmbootstrap
```

### 2. Inicializar
```bash
pmbootstrap init
```

**Configurações:**
- Vendor: `qemu`
- Device: `amd64`
- Username: `user`
- UI: `phosh`
- Extra packages: (deixe vazio)

### 3. Instalar Sistema Base
```bash
pmbootstrap install
```

### 4. Iniciar VM
```bash
pmbootstrap qemu --display=none -p 3333 &
```

Aguarde 60 segundos para boot.

### 5. Conectar via SSH
```bash
ssh -p 3333 user@localhost
```

Senha: a que você definiu no `pmbootstrap init`

### 6. Instalar LASC OS
```bash
# Baixar instalador
wget https://raw.githubusercontent.com/lalberto1985/lasc-os/main/install.sh

# Executar
chmod +x install.sh
./install.sh
```

**OU manualmente:**
```bash
# Baixar backups
wget https://github.com/lalberto1985/lasc-os/raw/main/backups/lasc_scripts_latest.tar.gz
wget https://github.com/lalberto1985/lasc-os/raw/main/backups/lasc_backup_latest.tar.gz

# Extrair
sudo tar -xzf lasc_scripts_latest.tar.gz -C /
tar -xzf lasc_backup_latest.tar.gz -C ~/

# Recarregar configuração
source ~/.profile
```

### 7. Testar
```bash
lasc-doctor
```

Deve mostrar 23 comandos com ✓!

---

## 📱 Instalação em Hardware Real

### PinePhone (Mais Fácil)

#### 1. Preparar SD Card
```bash
pmbootstrap init
# Vendor: pine64
# Device: pinephone
# UI: phosh
```

#### 2. Instalar no SD
```bash
pmbootstrap install --sdcard=/dev/sdX
# Substitua sdX pelo seu cartão SD (cuidado!)
```

#### 3. Instalar LASC OS

Insira o SD no PinePhone, ligue, conecte WiFi e:
```bash
ssh user@[IP_DO_PINEPHONE]
# Execute instalador LASC (passo 6 acima)
```

---

### OnePlus 6 / 6T (Avançado)

#### 1. Desbloquear Bootloader
```bash
# No PC com Android SDK:
adb reboot bootloader
fastboot oem unlock
```

⚠️ **AVISO:** Isso apaga todos os dados!

#### 2. Preparar Sistema
```bash
pmbootstrap init
# Vendor: oneplus
# Device: enchilada (OnePlus 6) ou fajita (6T)
# UI: phosh
```

#### 3. Flash
```bash
pmbootstrap flasher flash_rootfs
pmbootstrap flasher flash_kernel
```

#### 4. Boot

Reinicie o dispositivo. No primeiro boot:
```bash
# Conecte via SSH (USB ou WiFi)
ssh user@[IP_DO_DISPOSITIVO]

# Instale LASC OS
```

---

## 🔧 Pós-Instalação

### Configuração Inicial
```bash
# 1. Atualizar sistema
update

# 2. Instalar apps essenciais
lasc-apps
# Digite: 14 15 17 18 (Git, Python, Vim, Htop)

# 3. Escolher tema
theme
# Escolha 1-4

# 4. Testar WiFi (hardware real)
wifi

# 5. Fazer backup
lasc-backup
```

### Comandos Úteis
```bash
help        # Central de ajuda
android     # Menu principal
store       # Hub de ferramentas
fetch       # Info do sistema
doctor      # Diagnóstico
```

---

## ❓ Troubleshooting

### VM não inicia
```bash
# Verificar se já está rodando
ps aux | grep qemu

# Matar processo
killall qemu-system-x86_64

# Tentar novamente
pmbootstrap qemu --display=none -p 3333 &
```

### SSH não conecta
```bash
# Aguardar mais tempo (até 2 minutos)
# Verificar porta
sudo lsof -i :3333

# Limpar known_hosts
ssh-keygen -f ~/.ssh/known_hosts -R '[localhost]:3333'
```

### Comandos LASC não encontrados
```bash
# Recarregar profile
source ~/.profile

# Verificar instalação
ls -la /usr/local/bin/lasc-*

# Reinstalar se necessário
```

### Interface gráfica não funciona em VM
- Normal! GUI só funciona em hardware real
- Use SSH para tudo em VM

---

## 📚 Próximos Passos

Após instalação:
1. Leia `readme` para documentação completa
2. Execute `help` para ver todos os comandos
3. Personalize com `theme`
4. Faça backup: `lasc-backup`
5. Explore com `android` ou `store`

---

## 🆘 Suporte

- **GitHub Issues:** https://github.com/lalberto1985/lasc-os/issues
- **Documentação:** README.md completo
- **Comunidade:** (em breve)

---

**LASC OS - Sistema Mobile Linux**  
**Privacidade • Liberdade • Controle** 💚
