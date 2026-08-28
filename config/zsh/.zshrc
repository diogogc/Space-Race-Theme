# ==============================================================================
# 🚀 SPACE RACE MISSION CONTROL // INTERACTIVE ZSH CONFIGURATION (.zshrc)
# ==============================================================================

# If not running interactively, exit immediately
[[ $- != *i* ]] && return

# ------------------------------------------------------------------------------
# 1. HARDENED HISTORY & SECURITY
# ------------------------------------------------------------------------------
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=10000

# Enforce secure permissions on history file (owner read/write only)
[[ -f "$HISTFILE" ]] && chmod 600 "$HISTFILE" 2>/dev/null || true

# History execution and retention policies
setopt EXTENDED_HISTORY          # Write timestamps (epoch:elapsed command)
setopt HIST_EXPIRE_DUPS_FIRST    # Remove duplicate entries first when trimming
setopt HIST_IGNORE_DUPS          # Don't record duplicate entry if same as previous
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entries across history
setopt HIST_FIND_NO_DUPS         # Do not display duplicates when searching
setopt HIST_IGNORE_SPACE         # CRITICAL: Commands starting with space are NOT logged (secrets/passwords)
setopt HIST_SAVE_NO_DUPS         # Do not save duplicate entries to disk
setopt HIST_VERIFY               # Review history expansions before execution
setopt HIST_REDUCE_BLANKS        # Remove unnecessary blanks from history
setopt SHARE_HISTORY             # Safely append and share history between concurrent terminals

# Directory navigation safety and convenience
setopt AUTO_CD                   # Type directory name directly to cd
setopt AUTO_PUSHD                # Track directory history stack
setopt PUSHD_IGNORE_DUPS         # No duplicates in dir stack
setopt PUSHD_SILENT              # Silent pushd/popd
setopt INTERACTIVE_COMMENTS      # Enable # comments in interactive shell
unsetopt BEEP                    # Disable terminal beeps / audio alerts

# ------------------------------------------------------------------------------
# 2. ZSH COMPLETION ENGINE (compinit)
# ------------------------------------------------------------------------------
# Ensure cache directory exists
mkdir -p "$HOME/.cache/zsh"

# Add local and system completions to fpath
fpath=(
    "$HOME/.local/share/zsh/site-functions"
    "$HOME/.local/share/zsh/$ZSH_VERSION/functions"
    "/usr/share/zsh/site-functions"
    "/usr/share/zsh/$ZSH_VERSION/functions"
    $fpath
)

# Load completion system safely with cached dump
autoload -Uz compinit
# Only regenerate compdump once per day to optimize startup time
if [[ -n "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"(#qN.m+1) ]]; then
    compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
else
    compinit -C -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
fi

# Completion Styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{red}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format '%F{cyan}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# ------------------------------------------------------------------------------
# 3. LINE EDITOR & KEYBINDINGS
# ------------------------------------------------------------------------------
bindkey -e # Standard emacs keybindings

# Up / Down arrow partial command history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search     # Up Arrow
bindkey '^[[B' down-line-or-beginning-search   # Down Arrow
bindkey '^[[H' beginning-of-line              # Home
bindkey '^[[F' end-of-line                    # End
bindkey '^[[3~' delete-char                   # Delete
bindkey '^[[1;5C' forward-word                # Ctrl + Right
bindkey '^[[1;5D' backward-word               # Ctrl + Left

# ------------------------------------------------------------------------------
# 4. ENVIRONMENT MANAGERS (mise / dev tools)
# ------------------------------------------------------------------------------
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
    eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# ------------------------------------------------------------------------------
# 5. ECOSYSTEM PLUGINS (Auto-Discovery)
# ------------------------------------------------------------------------------
# zsh-autosuggestions
AUTOSUGGEST_PATHS=(
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
)
for p in "${AUTOSUGGEST_PATHS[@]}"; do
    if [[ -f "$p" ]]; then
        source "$p"
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#475569"
        bindkey '^ ' autosuggest-accept # Ctrl+Space to accept suggestion
        break
    fi
done

# zsh-syntax-highlighting (MUST be loaded AFTER custom widgets)
HIGHLIGHT_PATHS=(
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)
for p in "${HIGHLIGHT_PATHS[@]}"; do
    if [[ -f "$p" ]]; then
        source "$p"
        # Match Space-Race syntax highlight styles
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[command]='fg=#2ef788,bold'
        ZSH_HIGHLIGHT_STYLES[alias]='fg=#2ef788'
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00d2ff,bold'
        ZSH_HIGHLIGHT_STYLES[function]='fg=#ffb000'
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ffd166'
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ffd166'
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#64b5f6'
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#ffd166'
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#ffd166'
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#ffd166'
        break
    fi
done

# ------------------------------------------------------------------------------
# 6. STARSHIP MISSION PROMPT & THEME INTEGRATION
# ------------------------------------------------------------------------------
# Export Starship config pointing to active theme
export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$HOME/.config/starship.toml}"

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
elif [[ -x "$HOME/.local/share/mise/shims/starship" ]]; then
    eval "$("$HOME/.local/share/mise/shims/starship" init zsh)"
else
    # Fallback Space Telemetry Prompt
    PROMPT='%F{yellow}[🚀 APOLLO-MCC]%f %F{blue}%~%f %(?.%F{green}⫸%f.%F{red}⫸%f) '
    RPROMPT='%F{240}%*%f'
fi

# ------------------------------------------------------------------------------
# 7. SPACE RACE ALIASES & TELEMETRY SHORTCUTS
# ------------------------------------------------------------------------------
# Theme & Desktop controls
alias theme="space-theme-switch"
alias telemetry="space-telemetry"
alias dsky="dsky-launcher"
alias quindar="space-quindar"
alias capcom="space-capcom-dialog"
alias iss="space-iss-dialog"
alias network="space-network-dialog"
alias power="space-power-menu"
alias cheatsheet="space-cheatsheet"
alias cheat="space-cheatsheet"
alias keys="space-cheatsheet"
alias guide="space-cheatsheet"

# Terminal & Navigation
if command -v eza &>/dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -lh --icons --group-directories-first --git"
    alias la="eza -lah --icons --group-directories-first --git"
    alias tree="eza --tree --icons --group-directories-first"
    alias ltree="eza --tree --level=2 --icons --group-directories-first"
    alias ltree3="eza --tree --level=3 --icons --group-directories-first"
else
    alias ls="ls --color=auto --group-directories-first"
    alias ll="ls -lh --color=auto --group-directories-first"
    alias la="ls -lah --color=auto --group-directories-first"
    alias tree="tree -C"
    alias ltree="tree -C -L 2"
    alias ltree3="tree -C -L 3"
fi
alias grep="grep --color=auto"
alias df="df -h"
alias free="free -h"

# Fastfetch Mission Control banner
alias fetch="fastfetch -c \"$HOME/.config/fastfetch/config.jsonc\""

# Arch Linux Sysadmin shortcuts
alias pacup="sudo pacman -Syu"
alias orphans="pacman -Qdtq"
alias pacclean="sudo pacman -Rns \$(pacman -Qdtq)"
alias mirrorup="sudo reflector --country Brazil,US --protocol https --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"
alias syscheck="systemd-analyze && systemd-analyze blame | head -n 10"

# ------------------------------------------------------------------------------
# 8. WELCOME BANNER (Interactive Login)
# ------------------------------------------------------------------------------
if [[ -o interactive ]] && command -v fastfetch &>/dev/null; then
    fastfetch -c "$HOME/.config/fastfetch/config.jsonc"
fi
