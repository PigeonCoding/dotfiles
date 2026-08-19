# ============================================================================
# Self-contained zsh config (no oh-my-zsh)
#
# Everything this config needs lives in this directory:
#   lib/      - replicated oh-my-zsh lib files (with omz internals in compat.zsh)
#   plugins/  - plugin files, including copies of system-wide plugins
#   themes/   - robbyrussell theme
#   fzf/      - fzf shell integration files
#
# Point $ZDOTDIR at this directory (or symlink ~/.zshrc -> zsh/zshrc) to use it.
# ============================================================================

ZEN_HOME="${${(%):-%x}:A:h}"
ZEN_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export ZSH_CACHE_DIR="$ZEN_CACHE_DIR"
mkdir -p "$ZEN_CACHE_DIR"

# ----------------------------------------------------------------------------
# Completion (must run before plugins so `compdef` works)
# ----------------------------------------------------------------------------
fpath=("$ZEN_HOME/lib" $fpath)
autoload -Uz compaudit compinit zrecompile
compinit -i -d "$ZEN_CACHE_DIR/zcompdump"

# ----------------------------------------------------------------------------
# Lib files (port of oh-my-zsh/lib, self-contained)
# ----------------------------------------------------------------------------
source "$ZEN_HOME/lib/compat.zsh"
source "$ZEN_HOME/lib/clipboard.zsh"
source "$ZEN_HOME/lib/compfix.zsh"
source "$ZEN_HOME/lib/completion.zsh"
source "$ZEN_HOME/lib/correction.zsh"
source "$ZEN_HOME/lib/directories.zsh"
source "$ZEN_HOME/lib/functions.zsh"
source "$ZEN_HOME/lib/git.zsh"
source "$ZEN_HOME/lib/grep.zsh"
source "$ZEN_HOME/lib/history.zsh"
source "$ZEN_HOME/lib/key-bindings.zsh"
source "$ZEN_HOME/lib/misc.zsh"
source "$ZEN_HOME/lib/prompt_info_functions.zsh"
source "$ZEN_HOME/lib/spectrum.zsh"
source "$ZEN_HOME/lib/termsupport.zsh"
source "$ZEN_HOME/lib/theme-and-appearance.zsh"

# ----------------------------------------------------------------------------
# Plugins
# ----------------------------------------------------------------------------
source "$ZEN_HOME/plugins/git/git.plugin.zsh"
source "$ZEN_HOME/plugins/colored-man-pages/colored-man-pages.plugin.zsh"
source "$ZEN_HOME/plugins/fzf/fzf.plugin.zsh"
source "$ZEN_HOME/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZEN_HOME/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

# ----------------------------------------------------------------------------
# Theme (robbyrussell)
# ----------------------------------------------------------------------------
source "$ZEN_HOME/themes/robbyrussell.zsh-theme"

# set completion colors to be the same as `ls`, after theme has been loaded
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ============================================================================
# User configuration (from the previous ~/.zshrc)
# ============================================================================

export PATH="$HOME/.local/share/nvim/mason/bin/:$HOME/.local/share/AppImage:$PATH:/opt/winboat"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/home/pigeon/.local/bin:$PATH"

export LSFG_DLL_PATH="/home/pigeon/HDD/Games/LosslessScaling/Lossless.dll"

# bun completions
[ -s "/home/pigeon/.bun/_bun" ] && source "/home/pigeon/.bun/_bun"

export PKG_CONFIG_PATH=/home/pigeon/HDD/code/C/pkg-config

alias cls="clear"
alias upd="yay -Syu --noconfirm && flatpak update -y"
alias pupd="sudo pacman -Syu --noconfirm && flatpak update -y"
alias reshade="$HOME/Applications/reshade-linux.sh"
alias nvbun="__NV_PRIME_RENDER_OFFLOAD=1 __NV_DISABLE_EXPLICIT_SYNC=1 bun"
alias c="codium"
alias clean="rm -rf ~/.cache/yay && sudo pacman -Scc --noconfirm && sudo journalctl --vacuum-size=500M && sudo rm -r /var/cache/pacman/pkg/* && flatpak uninstall --unused && sudo rm -rfv /var/tmp/flatpak-cache-*"
alias z="zeditor"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/pigeon/.lmstudio/bin"

alias gap="git add --patch"
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias l="eza -la --group-directories-first"
alias ll="eza -l --group-directories-first"

alias cpr="rsync -Pr"
eval $(ssh-agent) > /dev/null && ssh-add ~/.ssh/github 2> /dev/null

alias mirrors="curl -s 'https://archlinux.org/mirrorlist/all/' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -"
alias mirrors2="curl -s 'https://archlinux.org/mirrorlist/?protocol=http&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -"

alias cld="ANTHROPIC_BASE_URL=http://localhost:1234 ANTHROPIC_AUTH_TOKEN=lmstudio CLAUDE_CODE_ATTRIBUTION_HEADER=0 claude"

export SUDO_EDITOR=hx
export QT_QPA_PLATFORMTHEME="qt6ct"

alias pp="WINEPREFIX=/home/pigeon/HDD/code/wine_prefix"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/pigeon/.opam/opam-init/init.zsh' ]] || source '/home/pigeon/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

alias mermaid="docker run --platform linux/amd64 --publish 8000:8080 ghcr.io/mermaid-js/mermaid-live-editor"
source /usr/share/nvm/init-nvm.sh
alias oneapi=". /opt/intel/oneapi/setvars.sh"
alias bonsai27B="/home/pigeon/.local/bin/lllama-server -m /home/pigeon/HDD/lm_studio/lmstudio-community/Bonsai-27B-GGUF/Bonsai-27B-Q1_0.gguf --mmproj /home/pigeon/HDD/lm_studio/lmstudio-community/Bonsai-27B-GGUF/mmproj-Bonsai-27B-BF16.gguf -c 80000 -kvu -ngl 99 --no-mmproj-offload -fa on --load-mode mmap -ctk q4_0 -ctv q4_0"
