# ==============================================================================
# 🚀 SPACE RACE MISSION CONTROL // ZSH ENVIRONMENT (.zshenv)
# ==============================================================================
# Sourced for ALL zsh invocations. Keep lightweight and secure.

# Ensure secure umask (no world-writable creation)
umask 022

# Safe Path deduplication
typeset -U path PATH fpath FPATH

# Environment & Binary Paths
path=(
    "$HOME/.local/bin"
    "$HOME/.gemini/antigravity-cli/bin"
    "$HOME/.local/share/mise/shims"
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    $path
)
export PATH

# Local Shared Library Path (for user-installed binaries)
if [[ -d "$HOME/.local/lib" ]]; then
    export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

# XDG Base Directory Standard
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Default Terminal Utilities
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-nano}"
export PAGER="less -R"
export LESS="-R -F -X -i"
