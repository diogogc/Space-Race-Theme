# ==============================================================================
# 🚀 SPACE RACE MISSION CONTROL // ZSH LOGIN PROFILE (.zprofile)
# ==============================================================================
# Sourced on login shells.

# Set Wayland / Hyprland session variables if launching from TTY
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    # Optional auto-start Hyprland if desired on tty1
    # exec Hyprland
    :
fi
