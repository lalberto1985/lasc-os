#!/bin/sh
# =============================================================================
# LASC OS - Instalador a partir do código-fonte
# Licença: MIT para os componentes LASC OS
# Repositório: https://github.com/lalberto1985/lasc-os
# =============================================================================

set -eu

die() {
    printf 'Erro: %s\n' "$*" >&2
    exit 1
}

SCRIPT_DIR=$(
    CDPATH= cd -P "$(dirname "$0")" &&
    pwd -P
)

SOURCE_ROOT=$(
    CDPATH= cd -P "$SCRIPT_DIR/.." &&
    pwd -P
)

DESTDIR=${DESTDIR:-}

case "$DESTDIR" in
    "")
        ROOT=
        ;;
    /*)
        ROOT=${DESTDIR%/}
        ;;
    *)
        die "DESTDIR deve ser um caminho absoluto."
        ;;
esac

# DESTDIR=/ também representa instalação no sistema real.
if [ "$ROOT" = "/" ]; then
    ROOT=
fi

for required in \
    VERSION \
    README.md \
    LICENSE \
    docs/CHANGELOG.md
do
    [ -f "$SOURCE_ROOT/$required" ] ||
        die "Arquivo obrigatório não encontrado: $required"
done

[ -d "$SOURCE_ROOT/src/bin" ] ||
    die "Diretório src/bin não encontrado."

[ -d "$SOURCE_ROOT/src/lib/lasc" ] ||
    die "Diretório src/lib/lasc não encontrado."

# Instalação real requer Alpine/postmarketOS e privilégios administrativos.
# Quando DESTDIR é utilizado, essas verificações são dispensadas para
# permitir testes seguros em um diretório temporário.
if [ -z "$ROOT" ]; then
    command -v apk >/dev/null 2>&1 ||
        die "A instalação de sistema requer Alpine Linux ou postmarketOS."

    [ "$(id -u)" -eq 0 ] ||
        die "Execute como root, por exemplo: sudo sh scripts/install.sh"
fi

printf 'LASC OS - instalação a partir do código-fonte\n'
printf 'Versão: %s\n' "$(cat "$SOURCE_ROOT/VERSION")"

if [ -n "$ROOT" ]; then
    printf 'Destino de teste: %s\n' "$ROOT"
else
    printf 'Destino: /\n'
fi

mkdir -p \
    "$ROOT/usr/bin" \
    "$ROOT/usr/lib/lasc-os" \
    "$ROOT/usr/share/lasc-os" \
    "$ROOT/usr/share/doc/lasc-os" \
    "$ROOT/usr/share/licenses/lasc-os"

command_count=0

for command in "$SOURCE_ROOT"/src/bin/lasc-*; do
    [ -f "$command" ] || continue

    destination="$ROOT/usr/bin/${command##*/}"

    cp -f "$command" "$destination"
    chmod 755 "$destination"

    command_count=$((command_count + 1))
done

[ "$command_count" -gt 0 ] ||
    die "Nenhum comando LASC foi encontrado para instalação."

library_count=0

for library in "$SOURCE_ROOT"/src/lib/lasc/*.sh; do
    [ -f "$library" ] || continue

    destination="$ROOT/usr/lib/lasc-os/${library##*/}"

    cp -f "$library" "$destination"
    chmod 644 "$destination"

    library_count=$((library_count + 1))
done

[ "$library_count" -gt 0 ] ||
    die "Nenhuma biblioteca LASC foi encontrada para instalação."

cp -f \
    "$SOURCE_ROOT/VERSION" \
    "$ROOT/usr/share/lasc-os/VERSION"

cp -f \
    "$SOURCE_ROOT/docs/CHANGELOG.md" \
    "$ROOT/usr/share/lasc-os/CHANGELOG.md"

cp -f \
    "$SOURCE_ROOT/README.md" \
    "$ROOT/usr/share/doc/lasc-os/README.md"

cp -f \
    "$SOURCE_ROOT/LICENSE" \
    "$ROOT/usr/share/licenses/lasc-os/LICENSE"

chmod 644 \
    "$ROOT/usr/share/lasc-os/VERSION" \
    "$ROOT/usr/share/lasc-os/CHANGELOG.md" \
    "$ROOT/usr/share/doc/lasc-os/README.md" \
    "$ROOT/usr/share/licenses/lasc-os/LICENSE"

printf '\nInstalação concluída.\n'
printf 'Comandos instalados: %s\n' "$command_count"
printf 'Bibliotecas instaladas: %s\n' "$library_count"

if [ -z "$ROOT" ]; then
    printf 'Validação recomendada: lasc-doctor\n'
fi
