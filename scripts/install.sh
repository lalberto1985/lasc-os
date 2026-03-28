#!/bin/bash
# =============================================================================
# LASC OS - Instalador Automático v1.4.0
# Sistema Operacional Mobile Linux - Open Source
# =============================================================================
# Repositório : https://github.com/lalberto1985/lasc-os
# Licença     : MIT + GPL v3
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

clear
echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║      LASC OS - Instalador Automático      ║"
echo "║      v1.4.0 - Visual Premium Edition      ║"
echo "║   Privacidade · Liberdade · Controle      ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

echo "[1/4] Verificando ambiente..."

if ! command -v apk &> /dev/null; then
    echo "✗ Este instalador requer Alpine Linux ou postmarketOS."
    echo "  Documentação: docs/INSTALLATION.md"
    exit 1
fi

echo "✓ Sistema compatível detectado"

echo "[2/4] Verificando privilégios..."
if [ "$(id -u)" -ne 0 ]; then
    echo "⚠ Recomendado executar com sudo para instalar componentes de sistema."
fi
echo "✓ Permissões verificadas"

echo "[3/4] Iniciando instalação..."
REPO_URL="https://github.com/lalberto1985/lasc-os"
BACKUP_DIR="./backups"

if [ -d "$BACKUP_DIR" ] && ls "$BACKUP_DIR"/lasc_scripts_*.tar.gz 1> /dev/null 2>&1; then
    echo "Backups encontrados localmente. Extraindo..."
    LATEST_SCRIPTS=$(ls -t "$BACKUP_DIR"/lasc_scripts_*.tar.gz | head -1)
    LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/lasc_backup_*.tar.gz | head -1)
    sudo tar -xzf "$LATEST_SCRIPTS" -C /
    tar -xzf "$LATEST_BACKUP" -C ~/
    echo "✓ Arquivos extraídos com sucesso"
else
    echo "⚠ Backups locais não encontrados. Siga as instruções abaixo."
fi

echo ""
echo "[4/4] Próximos passos:"
echo ""
echo "  1. Clone o repositório:"
echo "     git clone $REPO_URL"
echo "     cd lasc-os"
echo ""
echo "  2. Extraia os componentes:"
echo "     sudo tar -xzf backups/lasc_scripts_*.tar.gz -C /"
echo "     tar -xzf backups/lasc_backup_*.tar.gz -C ~/"
echo ""
echo "  3. Recarregue o ambiente:"
echo "     source ~/.profile"
echo ""
echo "  4. Valide a instalação:"
echo "     lasc-doctor"
echo ""
echo "Documentação: docs/INSTALLATION.md"
echo "GitHub: $REPO_URL"
