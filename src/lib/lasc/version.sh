#!/bin/sh

# LASC OS - version metadata
# Shared by LASC command-line tools.

LASC_PRODUCT_NAME="LASC OS"

lasc_detect_version() {
    # Installed package location
    if [ -r /usr/share/lasc-os/VERSION ]; then
        cat /usr/share/lasc-os/VERSION
        return 0
    fi

    # Development/source tree
    script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)

    if [ -n "$script_dir" ] && [ -r "$script_dir/../../VERSION" ]; then
        cat "$script_dir/../../VERSION"
        return 0
    fi

    printf '%s\n' "unknown"
}

lasc_version_codename() {
    version=$1

    case "$version" in
        1.0.0)
            printf '%s\n' "Genesis"
            ;;
        *)
            printf '%s\n' "não definido"
            ;;
    esac
}

lasc_version_status() {
    version=$1

    case "$version" in
        *-dev)
            printf '%s\n' "desenvolvimento"
            ;;
        unknown)
            printf '%s\n' "desconhecido"
            ;;
        *)
            printf '%s\n' "estável"
            ;;
    esac
}
