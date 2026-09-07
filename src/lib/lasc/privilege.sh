#!/bin/sh

# LASC OS - privilege helpers
# Runs commands as root using the available privilege mechanism.

lasc_is_root() {
    [ "$(id -u 2>/dev/null)" = "0" ]
}

lasc_privilege_command() {
    if lasc_is_root; then
        printf '%s\n' "root"
        return 0
    fi

    if command -v doas >/dev/null 2>&1; then
        printf '%s\n' "doas"
        return 0
    fi

    if command -v sudo >/dev/null 2>&1; then
        printf '%s\n' "sudo"
        return 0
    fi

    return 1
}

lasc_run_as_root() {
    if lasc_is_root; then
        "$@"
        return $?
    fi

    if command -v doas >/dev/null 2>&1; then
        doas "$@"
        return $?
    fi

    if command -v sudo >/dev/null 2>&1; then
        sudo "$@"
        return $?
    fi

    printf '%s\n' \
        "Erro: privilégios administrativos são necessários, mas sudo/doas não estão disponíveis." >&2
    return 1
}
