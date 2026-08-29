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
mkdir -p "$HOME/.config/tmux"
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

    echo "==> Linking Hyprland, Waybar, Kitty, Dunst, Fastfetch, Tmux, Zsh configs..."
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
    ln -sf "$SCRIPT_DIR/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    ln -sf "$SCRIPT_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"
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

    echo "==> Installing Hyprland, Waybar, Kitty, Dunst, Fastfetch, Tmux, Zsh configs..."
    cp -r "$SCRIPT_DIR/config/hypr/"* "$HOME/.config/hypr/"
    cp -r "$SCRIPT_DIR/config/waybar/"* "$HOME/.config/waybar/"
    cp -r "$SCRIPT_DIR/config/kitty/"* "$HOME/.config/kitty/"
    cp -r "$SCRIPT_DIR/config/dunst/"* "$HOME/.config/dunst/"
    cp -r "$SCRIPT_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"
    cp -r "$SCRIPT_DIR/config/space-screensaver/"* "$HOME/.config/space-screensaver/"
    cp -r "$SCRIPT_DIR/config/tmux/"* "$HOME/.config/tmux/"
    cp "$SCRIPT_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"
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

# Color definitions for summary banner
AMBER="\033[38;2;255;176;0m"
BRIGHT_AMBER="\033[38;2;255;209;102m"
GREEN="\033[38;2;46;247;136m"
CYAN="\033[38;2;0;210;255m"
MUTED="\033[38;2;118;134;150m"
WHITE="\033[38;2;226;232;240m"
BOLD="\033[1m"
RESET="\033[0m"

echo -e "\n${AMBER}${BOLD}==============================================================================${RESET}"
echo -e " ${GREEN}${BOLD}✅ MISSION COMPLETE: SPACE RACE THEME SUCCESSFULLY INSTALLED!${RESET}"
echo -e "${AMBER}${BOLD}==============================================================================${RESET}"
echo -e " ${BRIGHT_AMBER}${BOLD}🧭 ESSENTIAL FLIGHT KEYBINDINGS (RANKED BY OPERATIONAL PRIORITY)${RESET}"
echo -e " ${MUTED}──────────────────────────────────────────────────────────────────────────────${RESET}"

echo -e "  ${CYAN}${BOLD}● CORE APPLICATIONS & LAUNCHERS${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SPACE / R       ${RESET}${MUTED}⫸${RESET} ${WHITE}Open Apollo AGC DSKY Application Launcher${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + T       ${RESET}${MUTED}⫸${RESET} ${WHITE}Cycle Mission Theme (NASA / CRT / Kosmos-VFD)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + T               ${RESET}${MUTED}⫸${RESET} ${WHITE}Launch Mission Terminal (Ghostty / Kitty)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + E               ${RESET}${MUTED}⫸${RESET} ${WHITE}Open File Manager (Dolphin / Thunar)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + Q               ${RESET}${MUTED}⫸${RESET} ${WHITE}Close / Terminate Active Window${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + M / ESC ${RESET}${MUTED}⫸${RESET} ${WHITE}Emergency Flight Abort / Power Menu${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + L               ${RESET}${MUTED}⫸${RESET} ${WHITE}Lock Screen (Apollo DSKY Security Lock)${RESET}"
echo ""
echo -e "  ${CYAN}${BOLD}● MISSION TELEMETRY & FLIGHT CONSOLES${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + P       ${RESET}${MUTED}⫸${RESET} ${WHITE}Mission Capture & Recording Studio (or PrtScn)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + C       ${RESET}${MUTED}⫸${RESET} ${WHITE}System Hardware Telemetry & Task Abort Console${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + N       ${RESET}${MUTED}⫸${RESET} ${WHITE}Communications, Wi-Fi Radar & S-Band S-Meter${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + E       ${RESET}${MUTED}⫸${RESET} ${WHITE}MDC-02 Power Telemetry & Energy Profiles${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + V       ${RESET}${MUTED}⫸${RESET} ${WHITE}CAPCOM Audio Intercom & Dual VU Meters${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + K       ${RESET}${MUTED}⫸${RESET} ${WHITE}Keybinding Flight Guide & Cheatsheet Modal${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + O       ${RESET}${MUTED}⫸${RESET} ${WHITE}8-Bit Orbital Screensaver (Instant Play)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + D       ${RESET}${MUTED}⫸${RESET} ${WHITE}Default Applications Manager${RESET}"
echo ""
echo -e "  ${CYAN}${BOLD}● WORKSPACE & WINDOW MANAGEMENT${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + [1 - 9]         ${RESET}${MUTED}⫸${RESET} ${WHITE}Switch directly to Workspace 1 through 9${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + [1-9]   ${RESET}${MUTED}⫸${RESET} ${WHITE}Move active window to Workspace 1..9${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + F               ${RESET}${MUTED}⫸${RESET} ${WHITE}Toggle Fullscreen Window${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + V               ${RESET}${MUTED}⫸${RESET} ${WHITE}Toggle Floating Window Mode${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + S               ${RESET}${MUTED}⫸${RESET} ${WHITE}Toggle Special Scratchpad Workspace${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + S       ${RESET}${MUTED}⫸${RESET} ${WHITE}Send active window to Scratchpad Workspace${RESET}"
echo ""
echo -e "  ${CYAN}${BOLD}● QUICK TERMINAL COMMANDS${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}theme [name]            ${RESET}${MUTED}⫸${RESET} ${WHITE}Switch theme (nasa, crt-amber, crt-green, kosmos-vfd)${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}cheatsheet (or keys)    ${RESET}${MUTED}⫸${RESET} ${WHITE}Display full interactive CLI cheatsheet${RESET}"
echo -e "    ${BRIGHT_AMBER}${BOLD}fetch                   ${RESET}${MUTED}⫸${RESET} ${WHITE}Display Fastfetch avionics telemetry banner${RESET}"
echo -e " ${MUTED}──────────────────────────────────────────────────────────────────────────────${RESET}"
echo -e "  ${GREEN}💡 TIP:${RESET} ${WHITE}Press ${BRIGHT_AMBER}${BOLD}SUPER + SHIFT + K${RESET}${WHITE} anytime to open the graphical Keybinding Guide.${RESET}"
echo -e "${AMBER}${BOLD}==============================================================================${RESET}\n"
