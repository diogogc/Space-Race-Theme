#!/usr/bin/env bash
# ==============================================================================
# 🛸 SPACE RACE THEME: COMPANION UNINSTALLER
# ==============================================================================
# Usage:
#   ./uninstall.sh         # Interactive uninstallation
#   ./uninstall.sh --yes   # Non-interactive removal without confirmation prompt
#   ./uninstall.sh --clean # Remove installed files and purge runtime caches
# ==============================================================================

set -e

AUTO_CONFIRM=false
PURGE_CACHES=false

for arg in "$@"; do
    case "$arg" in
        --yes|-y)
            AUTO_CONFIRM=true
            ;;
        --clean|-c)
            AUTO_CONFIRM=true
            PURGE_CACHES=true
            ;;
        --help|-h)
            echo "Space Race Theme Uninstaller"
            echo "Usage: ./uninstall.sh [options]"
            echo "  --yes, -y    Perform uninstallation without confirmation prompt"
            echo "  --clean, -c  Uninstall and purge runtime telemetry caches/sockets"
            echo "  --help, -h   Show this help message"
            exit 0
            ;;
    esac
done

echo "=================================================================="
echo " 🛸 SPACE RACE THEME // MISSION CONTROL UNINSTALLER"
echo " Target Home: $HOME"
echo "=================================================================="

if [[ "$AUTO_CONFIRM" != "true" ]]; then
    read -rp "Are you sure you want to remove Space Race Theme binaries, launchers, and theme configs? [y/N]: " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "==> Aborted. No files were removed."
        exit 0
    fi
fi

echo "==> Terminating any running Space Race background daemons..."
pkill -f space-idle-daemon 2>/dev/null || true
pkill -f space-screensaver 2>/dev/null || true
pkill -f space-flight-poll 2>/dev/null || true
pkill -f hyprland-ipc-bridge 2>/dev/null || true

echo "==> Removing mission control binaries from ~/.local/bin..."
BINARIES=(
    "dsky-launcher"
    "hyprland-ipc-bridge"
    "space-boot-install"
    "space-capcom-dialog"
    "space-cheatsheet"
    "space-default-apps"
    "space-energy-dialog"
    "space-flight-poll"
    "space-idle-daemon"
    "space-iss-dialog"
    "space-iss-telemetry"
    "space-keybinds"
    "space-met"
    "space-network-dialog"
    "space-network-telemetry"
    "space-power-menu"
    "space-power-telemetry"
    "space-quindar"
    "space-screensaver"
    "space-screensaver-config"
    "space-sddm-install"
    "space-telemetry"
    "space-telemetry-dialog"
    "space-theme-status"
    "space-theme-switch"
    "space-vox-dialog"
)

for b in "${BINARIES[@]}"; do
    target="$HOME/.local/bin/$b"
    if [[ -e "$target" || -L "$target" ]]; then
        rm -f "$target"
        echo "    - Removed: $target"
    fi
done

echo "==> Removing desktop launchers from ~/.local/share/applications..."
DESKTOPS=(
    "space-capcom.desktop"
    "space-default-apps.desktop"
    "space-energy.desktop"
    "space-flight-poll.desktop"
    "space-flight-reboot.desktop"
    "space-flight-shutdown.desktop"
    "space-iss-dialog.desktop"
    "space-keybinds.desktop"
    "space-network.desktop"
    "space-power-menu.desktop"
    "space-screensaver-config.desktop"
    "space-screensaver.desktop"
    "space-telemetry.desktop"
    "space-theme-switch.desktop"
)

for d in "${DESKTOPS[@]}"; do
    target="$HOME/.local/share/applications/$d"
    if [[ -e "$target" || -L "$target" ]]; then
        rm -f "$target"
        echo "    - Removed: $target"
    fi
done

echo "==> Removing theme palettes and screensaver configs..."
THEME_DIRS=("nasa" "crt-amber" "crt-green" "kosmos-vfd" "sddm-space-race")
for td in "${THEME_DIRS[@]}"; do
    target="$HOME/.config/themes/$td"
    if [[ -e "$target" || -L "$target" ]]; then
        rm -rf "$target"
        echo "    - Removed: $target"
    fi
done

if [[ -e "$HOME/.config/themes/current_theme" || -L "$HOME/.config/themes/current_theme" ]]; then
    rm -f "$HOME/.config/themes/current_theme"
fi

if [[ -d "$HOME/.config/space-screensaver" || -L "$HOME/.config/space-screensaver" ]]; then
    rm -rf "$HOME/.config/space-screensaver"
    echo "    - Removed: $HOME/.config/space-screensaver"
fi

if [[ "$PURGE_CACHES" == "true" ]]; then
    echo "==> Purging runtime telemetry caches and lock sockets..."
    rm -rf /tmp/space-* /tmp/iss_* /tmp/hyprland-ipc* 2>/dev/null || true
    rm -rf "$HOME/.cache/space-"* 2>/dev/null || true
fi

echo "==> Updating desktop application database..."
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo "=================================================================="
echo " ✅ UNINSTALLATION COMPLETE: SPACE RACE THEME HAS BEEN REMOVED."
echo " Note: Your workspace repository remains intact at:"
echo "       $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo " To reinstall at any time, run: ./install.sh (or ./install.sh --link)"
echo "=================================================================="
