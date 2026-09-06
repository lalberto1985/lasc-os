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

lasc_kernel() {
    uname -r 2>/dev/null || printf '%s\n' "unknown"
}

lasc_format_kib() {
    awk -v kib="${1:-0}" '
        BEGIN {
            if (kib >= 1048576)
                printf "%.1f GiB\n", kib / 1048576
            else if (kib >= 1024)
                printf "%.0f MiB\n", kib / 1024
            else
                printf "%.0f KiB\n", kib
        }
    '
}

lasc_uptime() (
    if [ -r /proc/uptime ]; then
        seconds=$(awk '{print int($1)}' /proc/uptime)

        days=$((seconds / 86400))
        hours=$(((seconds % 86400) / 3600))
        minutes=$(((seconds % 3600) / 60))

        if [ "$days" -gt 0 ]; then
            printf '%sd %sh %sm\n' "$days" "$hours" "$minutes"
        elif [ "$hours" -gt 0 ]; then
            printf '%sh %sm\n' "$hours" "$minutes"
        else
            printf '%sm\n' "$minutes"
        fi

        exit 0
    fi

    uptime 2>/dev/null || printf '%s\n' "unknown"
)

lasc_memory() (
    if [ ! -r /proc/meminfo ]; then
        printf '%s\n' "unknown"
        exit 0
    fi

    total_kib=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    available_kib=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

    if [ -z "$total_kib" ]; then
        printf '%s\n' "unknown"
        exit 0
    fi

    if [ -z "$available_kib" ]; then
        available_kib=$(awk '
            /^MemFree:/  {free=$2}
            /^Buffers:/  {buffers=$2}
            /^Cached:/   {cached=$2}
            END {print free + buffers + cached}
        ' /proc/meminfo)
    fi

    used_kib=$((total_kib - available_kib))

    used=$(lasc_format_kib "$used_kib")
    total=$(lasc_format_kib "$total_kib")

    printf '%s / %s\n' "$used" "$total"
)

lasc_disk() (
    disk_data=$(df -Pk / 2>/dev/null | awk 'NR==2 {print $3, $2, $5}')

    if [ -z "$disk_data" ]; then
        printf '%s\n' "unknown"
        exit 0
    fi

    set -- $disk_data

    used=$(lasc_format_kib "$1")
    total=$(lasc_format_kib "$2")
    percent=$3

    printf '%s / %s (%s)\n' "$used" "$total" "$percent"
)

lasc_process_count() (
    if ps -e >/dev/null 2>&1; then
        ps -e | awk 'NR > 1 {count++} END {print count + 0}'
    else
        ps | awk 'NR > 1 {count++} END {print count + 0}'
    fi
)
