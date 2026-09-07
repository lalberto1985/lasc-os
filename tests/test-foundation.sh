#!/bin/sh

# LASC OS - Foundation validation
# Static checks and safe smoke tests for the source tree.

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." 2>/dev/null && pwd)
BIN_DIR="$ROOT/src/bin"
LIB_DIR="$ROOT/src/lib/lasc"
VERSION_FILE="$ROOT/VERSION"
INSTALLER="$ROOT/scripts/install.sh"

FAILURES=0

pass() {
    printf '  ✓ %s\n' "$1"
}

fail() {
    printf '  ✗ %s\n' "$1" >&2
    FAILURES=$((FAILURES + 1))
}

TMP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/lasc-tests.XXXXXX") || {
    printf '%s\n' "Erro: não foi possível criar diretório temporário." >&2
    exit 1
}

cleanup() {
    rm -rf -- "$TMP_DIR"
}

trap cleanup 0 1 2 15

EXPECTED_COMMANDS="
lasc-about
lasc-android
lasc-apps
lasc-backup
lasc-clean
lasc-dashboard
lasc-doctor
lasc-fetch
lasc-help
lasc-info
lasc-list
lasc-log
lasc-network
lasc-process
lasc-store
lasc-update
lasc-version
"

printf 'LASC OS - Foundation Tests\n'
printf '==========================\n\n'

printf '[1/8] Estrutura do projeto\n'

if [ -r "$VERSION_FILE" ]; then
    pass "VERSION existe"
else
    fail "VERSION não encontrado"
fi

set -- "$BIN_DIR"/lasc-*

if [ "$#" -eq 17 ]; then
    pass "17 comandos LASC encontrados"
else
    fail "esperados 17 comandos, encontrados $#"
fi

for cmd in $EXPECTED_COMMANDS; do
    if [ -f "$BIN_DIR/$cmd" ] && [ -x "$BIN_DIR/$cmd" ]; then
        :
    else
        fail "$cmd ausente ou sem permissão de execução"
    fi
done

if [ "$FAILURES" -eq 0 ]; then
    pass "todos os comandos esperados estão executáveis"
fi

printf '\n[2/8] Bibliotecas compartilhadas\n'

for lib in version.sh system.sh privilege.sh; do
    if [ -r "$LIB_DIR/$lib" ]; then
        pass "$lib disponível"
    else
        fail "$lib não encontrada"
    fi
done

printf '\n[3/8] Sintaxe POSIX shell\n'

SYNTAX_FAILURE=0

for file in "$BIN_DIR"/lasc-* "$LIB_DIR"/*.sh "$INSTALLER"; do
    if ! sh -n "$file"; then
        fail "erro de sintaxe em $file"
        SYNTAX_FAILURE=1
    fi
done

if [ "$SYNTAX_FAILURE" -eq 0 ]; then
    pass "comandos, bibliotecas e instalador passam em sh -n"
fi

printf '\n[4/8] Padrões legados/perigosos\n'

LEGACY_PATTERN='echo -e|read -p|/usr/local/bin/lasc-|postmarketOS v25\.12|ifconfig|ps aux|rm -rf /tmp/\*|sudo[[:space:]]+(apk|rm|tar|journalctl)|doas[[:space:]]+(apk|rm|tar|journalctl)'

if grep -nE \
    "$LEGACY_PATTERN" \
    "$BIN_DIR"/lasc-* \
    "$LIB_DIR"/*.sh \
    "$INSTALLER" \
    >"$TMP_DIR/legacy.txt" 2>/dev/null
then
    fail "padrões legados/perigosos encontrados"
    cat "$TMP_DIR/legacy.txt"
else
    pass "nenhum padrão legado/perigoso encontrado"
fi

printf '\n[5/8] Metadados e ajuda\n'

VERSION_VALUE=$(cat "$VERSION_FILE")

if "$BIN_DIR/lasc-version" >"$TMP_DIR/version.out" 2>&1 &&
   grep -F "$VERSION_VALUE" "$TMP_DIR/version.out" >/dev/null
then
    pass "lasc-version usa VERSION ($VERSION_VALUE)"
else
    fail "lasc-version não retornou a versão esperada"
fi

if "$BIN_DIR/lasc-help" >"$TMP_DIR/help.out" 2>&1; then
    HELP_OK=1

    for cmd in $EXPECTED_COMMANDS; do
        if ! grep -F "$cmd" "$TMP_DIR/help.out" >/dev/null; then
            fail "lasc-help não documenta $cmd"
            HELP_OK=0
        fi
    done

    if [ "$HELP_OK" -eq 1 ]; then
        pass "lasc-help lista os 17 comandos"
    fi
else
    fail "lasc-help falhou"
fi

printf '\n[6/8] Operações seguras\n'

if "$BIN_DIR/lasc-clean" --dry-run >"$TMP_DIR/clean.out" 2>&1 &&
   grep -F "Simulação concluída" "$TMP_DIR/clean.out" >/dev/null
then
    pass "lasc-clean --dry-run"
else
    fail "lasc-clean --dry-run falhou"
fi

TEST_HOME="$TMP_DIR/home"
mkdir -p "$TEST_HOME"

if HOME="$TEST_HOME" \
   "$BIN_DIR/lasc-backup" --dry-run >"$TMP_DIR/backup.out" 2>&1 &&
   [ ! -e "$TEST_HOME/lasc-backups" ]
then
    pass "lasc-backup --dry-run não cria backup"
else
    fail "lasc-backup --dry-run alterou o ambiente ou falhou"
fi

printf '\n[7/8] Instalador de desenvolvimento\n'

INSTALL_ROOT="$TMP_DIR/install-root"

if [ -x "$INSTALLER" ]; then
    pass "scripts/install.sh está executável"
else
    fail "scripts/install.sh não está executável"
fi

if DESTDIR="$INSTALL_ROOT" \
   "$INSTALLER" >"$TMP_DIR/install.out" 2>&1
then
    INSTALL_OK=1

    set -- "$INSTALL_ROOT"/usr/bin/lasc-*

    if [ "$#" -eq 17 ] && [ -f "$1" ]; then
        pass "instalador entrega 17 comandos"
    else
        fail "instalador não entregou exatamente 17 comandos"
        INSTALL_OK=0
    fi

    for cmd in $EXPECTED_COMMANDS; do
        if [ ! -x "$INSTALL_ROOT/usr/bin/$cmd" ]; then
            fail "comando instalado ausente ou sem execução: $cmd"
            INSTALL_OK=0
        fi
    done

    set -- "$INSTALL_ROOT"/usr/lib/lasc-os/*.sh

    if [ "$#" -eq 3 ] && [ -f "$1" ]; then
        pass "instalador entrega 3 bibliotecas"
    else
        fail "instalador não entregou exatamente 3 bibliotecas"
        INSTALL_OK=0
    fi

    for lib in version.sh system.sh privilege.sh; do
        if [ ! -r "$INSTALL_ROOT/usr/lib/lasc-os/$lib" ] ||
           [ -x "$INSTALL_ROOT/usr/lib/lasc-os/$lib" ]
        then
            fail "biblioteca instalada inválida: $lib"
            INSTALL_OK=0
        fi
    done

    for metadata in \
        usr/share/lasc-os/VERSION \
        usr/share/lasc-os/CHANGELOG.md \
        usr/share/doc/lasc-os/README.md \
        usr/share/licenses/lasc-os/LICENSE
    do
        if [ ! -r "$INSTALL_ROOT/$metadata" ]; then
            fail "arquivo instalado ausente: $metadata"
            INSTALL_OK=0
        fi
    done

    if [ ! -e "$INSTALL_ROOT/usr/local" ]; then
        pass "instalador usa o mesmo layout do APK"
    else
        fail "instalador criou conteúdo legado em /usr/local"
        INSTALL_OK=0
    fi

    if [ "$INSTALL_OK" -eq 1 ]; then
        pass "instalação em DESTDIR validada"
    fi
else
    fail "scripts/install.sh falhou com DESTDIR"
    cat "$TMP_DIR/install.out" >&2
fi

INSTALL_LEGACY_PATTERN='backups/|lasc_scripts_|lasc_backup_|tar[[:space:]]+-x|/usr/local/bin'

if grep -nE \
    "$INSTALL_LEGACY_PATTERN" \
    "$INSTALLER" \
    >"$TMP_DIR/install-legacy.txt" 2>/dev/null
then
    fail "instalador ainda contém fluxo legado"
    cat "$TMP_DIR/install-legacy.txt"
else
    pass "instalador não depende de backups ou tarballs legados"
fi

printf '\n[8/8] Menus e cancelamento\n'

if printf '0\n' |
   "$BIN_DIR/lasc-apps" >"$TMP_DIR/apps.out" 2>&1
then
    pass "lasc-apps cancela com segurança"
else
    fail "lasc-apps falhou ao cancelar"
fi

if printf '0\n' |
   "$BIN_DIR/lasc-android" >"$TMP_DIR/android.out" 2>&1
then
    pass "lasc-android encerra com segurança"
else
    fail "lasc-android falhou ao encerrar"
fi

if printf '0\n' |
   "$BIN_DIR/lasc-store" >"$TMP_DIR/store.out" 2>&1
then
    pass "lasc-store encerra com segurança"
else
    fail "lasc-store falhou ao encerrar"
fi

printf '\n==========================\n'

if [ "$FAILURES" -eq 0 ]; then
    printf '✓ Foundation tests: OK\n'
    exit 0
fi

printf '✗ Foundation tests: %s falha(s)\n' "$FAILURES" >&2
exit 1
