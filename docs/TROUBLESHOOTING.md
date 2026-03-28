# LASC OS — Troubleshooting

Guia de solução de problemas para o LASC OS.

---

## Sumário

- [Problemas de Instalação](#problemas-de-instalacao)
- [Comandos Não Encontrados](#comandos-nao-encontrados)
- [Problemas de Interface (Phosh)](#problemas-de-interface-phosh)
- [Problemas de Rede e WiFi](#problemas-de-rede-e-wifi)
- [Problemas de Bateria](#problemas-de-bateria)
- [Erros Comuns](#erros-comuns)
- [Diagnóstico Geral](#diagnostico-geral)
- [Suporte](#suporte)

---

## Problemas de Instalação

### ❌ "Este instalador requer Alpine Linux ou postmarketOS"

**Causa:** O script `install.sh` foi executado em um sistema não compatível.

**Solução:**
```bash
# Verificar o sistema operacional
cat /etc/os-release

# O instalador requer Alpine Linux ou postmarketOS
# Use pmbootstrap para instalar o sistema base
```

---

### ❌ Backup não encontrado durante instalação

**Causa:** Os arquivos `.tar.gz` não estão na pasta `backups/`.

**Solução:**
```bash
# Clone o repositório completo antes de instalar
git clone https://github.com/lalberto1985/lasc-os.git
cd lasc-os
bash scripts/install.sh
```

---

### ❌ Erro de permissão ao extrair arquivos de sistema

**Causa:** Tentativa de extrair arquivos em `/` sem privilégios de root.

**Solução:**
```bash
sudo tar -xzf backups/lasc_scripts_*.tar.gz -C /
```

---

## Comandos Não Encontrados

### ❌ "lasc-dashboard: command not found"

**Causa:** O `.profile` não foi recarregado após a instalação.

**Solução:**
```bash
# Recarregar configurações do shell
source ~/.profile

# Se o erro persistir, verificar se o arquivo existe
ls /usr/local/bin/lasc-*

# Executar diagnóstico completo
lasc-doctor
```

---

### ❌ Aliases não funcionam após reinício

**Causa:** O `.profile` não está sendo carregado automaticamente.

**Solução:**
```bash
# Adicionar ao .bashrc se necessário
echo "source ~/.profile" >> ~/.bashrc
source ~/.bashrc
```

---

## Problemas de Interface (Phosh)

### ❌ Phosh não inicia após o boot

**Solução:**
```bash
# Verificar status do serviço
systemctl status phosh

# Reiniciar o serviço
systemctl restart phosh

# Ver logs de erro
journalctl -u phosh -n 50
```

---

### ❌ Tela preta após login

**Solução:**
```bash
# Verificar compositor Wayland
systemctl status weston

# Forçar reinício da interface
pkill -HUP phosh
```

---

## Problemas de Rede e WiFi

### ❌ `lasc-wifi` não lista redes disponíveis

**Causa:** Interface WiFi inativa ou serviço NetworkManager parado.

**Solução:**
```bash
# Verificar interfaces de rede
ip link show

# Ativar interface WiFi
sudo ip link set wlan0 up

# Verificar NetworkManager
systemctl status NetworkManager
systemctl start NetworkManager
```

---

### ❌ Conectado ao WiFi mas sem acesso à internet

**Solução:**
```bash
# Verificar DNS
cat /etc/resolv.conf

# Testar conectividade
ping -c 3 8.8.8.8

# Usar lasc-network para diagnóstico
lasc-network
```

---

## Problemas de Bateria

### ❌ `lasc-battery` mostra "N/A" ou erro

**Causa:** Arquivo de bateria não encontrado (normal em VMs).

**Solução:**
```bash
# Verificar se o dispositivo tem bateria detectada
ls /sys/class/power_supply/

# Em VMs, este comportamento é esperado
# O comando funciona corretamente em hardware real
```

---

## Erros Comuns

### ❌ "Permission denied" ao executar scripts

```bash
# Dar permissão de execução
chmod +x scripts/install.sh

# Para scripts em /usr/local/bin
sudo chmod +x /usr/local/bin/lasc-*
```

---

### ❌ Caracteres especiais não aparecem corretamente no terminal

**Causa:** Terminal sem suporte a UTF-8.

**Solução:**
```bash
# Configurar locale
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8

# Adicionar permanentemente ao .profile
echo 'export LANG=pt_BR.UTF-8' >> ~/.profile
```

---

### ❌ Espaço em disco insuficiente

```bash
# Verificar espaço disponível
df -h

# Limpar sistema com o comando LASC
lasc-clean

# Limpar cache do APK
sudo apk cache clean

# Limpar logs antigos
sudo journalctl --vacuum-time=7d
```

---

## Diagnóstico Geral

O primeiro passo para qualquer problema é executar o diagnóstico integrado:

```bash
lasc-doctor
```

Este comando verifica:
- Todos os 23 comandos LASC
- Conectividade de rede
- Espaço em disco
- Status dos serviços principais
- Versão do sistema

---

## Suporte

Se o problema não foi resolvido por este guia:

1. **Abra uma Issue**: [github.com/lalberto1985/lasc-os/issues](https://github.com/lalberto1985/lasc-os/issues)
2. **Inclua na issue**:
   - Saída do comando `lasc-doctor`
   - Mensagem de erro completa
   - Versão do sistema (`lasc-version`)
   - Dispositivo/ambiente (VM, PinePhone, etc.)

---

**LASC OS** — *Privacidade, Liberdade, Controle*
