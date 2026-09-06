#!/bin/sh

# LASC OS - system information helpers
# Portable functions for Linux environments.

lasc_detect_base() (
    if [ -r /etc/os-release ]; then
        NAME=
        VERSION_ID=
        PRETTY_NAME=

        . /etc/os-release

        if [ -n "${PRETTY_NAME:-}" ]; then
            printf '%s\n' "$PRETTY_NAME"
            exit 0
        fi

        if [ -n "${NAME:-}" ] && [ -n "${VERSION_ID:-}" ]; then
            printf '%s %s\n' "$NAME" "$VERSION_ID"
            exit 0
        fi

        if [ -n "${NAME:-}" ]; then
            printf '%s\n' "$NAME"
            exit 0
        fi
    fi

    uname -s 2>/dev/null || printf '%s\n' "Linux"
)
