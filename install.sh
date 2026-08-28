#!/usr/bin/env bash
# ==============================================================================
# 🛸 SPACE RACE THEME: AUTOMATED INSTALLER & WORKSPACE SYMLINKER
# ==============================================================================
# Usage:
#   ./install.sh          # Full copy installation into home directory
#   ./install.sh --link   # Live development mode (symlinks files to workspace)
#   ./install.sh --build  # Recompile C daemons (hyprland-ipc-bridge, space-idle-daemon)
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="install"

if [[ "$1" == "--link" || "$1" == "-l" ]]; then
    MODE="link"
elif [[ "$1" == "--build" || "$1" == "-b" ]]; then
    MODE="build"
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Space Race Theme Installer"
    echo "Usage: ./install.sh [options]"
    echo "  --install, -i  (default) Copy files to ~/.local/bin, ~/.config, etc."
    echo "  --link, -l     Symlink files to this repository for live development"
    echo "  --build, -b    Only compile C daemons"
    exit 0
fi

echo "=================================================================="
echo " 🚀 SPACE RACE THEME // MISSION CONTROL INSTALLER"
echo " Target Mode: [ $MODE ]"
echo " Source Path: $SCRIPT_DIR"
echo "=================================================================="

# 1. Build C Daemons
echo "==> Compiling native C daemons..."
make -C "$SCRIPT_DIR" all

if [[ "$MODE" == "build" ]]; then
    echo "==> Build complete!"
    exit 0
fi

# Target Directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/waybar"
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/.config/themes"
mkdir -p "$HOME/.config/space-screensaver"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/Pictures/Wallpapers/historical"

if [[ "$MODE" == "link" ]]; then
    echo "==> Linking binaries to ~/.local/bin..."
    for f in "$SCRIPT_DIR/bin/"*; do
        bname=$(basename "$f")
        ln -sf "$f" "$HOME/.local/bin/$bname"
    done

    echo "==> Linking application launchers to ~/.local/share/applications..."
    for f in "$SCRIPT_DIR/applications/"*.desktop; do
        bname=$(basename "$f")
        ln -sf "$f" "$HOME/.local/share/applications/$bname"
    done

    echo "==> Linking theme palettes to ~/.config/themes..."
    for d in "$SCRIPT_DIR/config/themes/"*; do
        bname=$(basename "$d")
        ln -sfn "$d" "$HOME/.config/themes/$bname"
    done

    echo "==> Linking Hyprland, Waybar, Kitty, Dunst, Fastfetch, Zsh configs..."
    ln -sf "$SCRIPT_DIR/config/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
    ln -sf "$SCRIPT_DIR/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
    ln -sf "$SCRIPT_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
    ln -sf "$SCRIPT_DIR/config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
    ln -sf "$SCRIPT_DIR/config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
    ln -sf "$SCRIPT_DIR/config/waybar/style.css" "$HOME/.config/waybar/style.css"
    ln -sf "$SCRIPT_DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    ln -sf "$SCRIPT_DIR/config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
    ln -sf "$SCRIPT_DIR/config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    ln -sf "$SCRIPT_DIR/config/space-screensaver/config.json" "$HOME/.config/space-screensaver/config.json"
    ln -sf "$SCRIPT_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
    ln -sf "$SCRIPT_DIR/config/zsh/.zshenv" "$HOME/.zshenv"
    ln -sf "$SCRIPT_DIR/config/zsh/.zprofile" "$HOME/.zprofile"
    ln -sf "$SCRIPT_DIR/config/themes/nasa/starship.toml" "$HOME/.config/starship.toml"

    echo "==> Linking wallpapers..."
    for f in "$SCRIPT_DIR/wallpapers/"*.*; do
        bname=$(basename "$f")
        ln -sf "$f" "$HOME/Pictures/Wallpapers/$bname"
    done
    for f in "$SCRIPT_DIR/wallpapers/historical/"*.*; do
        bname=$(basename "$f")
        ln -sf "$f" "$HOME/Pictures/Wallpapers/historical/$bname"
    done

else
    echo "==> Installing binaries to ~/.local/bin..."
    cp -r "$SCRIPT_DIR/bin/"* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*

    echo "==> Installing application launchers..."
    cp -r "$SCRIPT_DIR/applications/"*.desktop "$HOME/.local/share/applications/"

    echo "==> Installing theme palettes to ~/.config/themes..."
    cp -r "$SCRIPT_DIR/config/themes/"* "$HOME/.config/themes/"

    echo "==> Installing Hyprland, Waybar, Kitty, Dunst, Fastfetch, Zsh configs..."
    cp -r "$SCRIPT_DIR/config/hypr/"* "$HOME/.config/hypr/"
    cp -r "$SCRIPT_DIR/config/waybar/"* "$HOME/.config/waybar/"
    cp -r "$SCRIPT_DIR/config/kitty/"* "$HOME/.config/kitty/"
    cp -r "$SCRIPT_DIR/config/dunst/"* "$HOME/.config/dunst/"
    cp -r "$SCRIPT_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"
    cp -r "$SCRIPT_DIR/config/space-screensaver/"* "$HOME/.config/space-screensaver/"
    cp "$SCRIPT_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
    cp "$SCRIPT_DIR/config/zsh/.zshenv" "$HOME/.zshenv"
    cp "$SCRIPT_DIR/config/zsh/.zprofile" "$HOME/.zprofile"
    cp "$SCRIPT_DIR/config/themes/nasa/starship.toml" "$HOME/.config/starship.toml"

    echo "==> Installing wallpapers..."
    cp "$SCRIPT_DIR/wallpapers/"*.* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true
    cp -r "$SCRIPT_DIR/wallpapers/historical/"* "$HOME/Pictures/Wallpapers/historical/" 2>/dev/null || true
fi

# Update desktop database
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo "=================================================================="
echo " ✅ MISSION COMPLETE: SPACE RACE THEME INSTALLED!"
echo " Switch theme: space-theme-switch"
echo " Open DSKY:    SUPER + Space (or dsky-launcher)"
echo " Screensaver:  SUPER + SHIFT + O (or space-screensaver)"
echo "=================================================================="
