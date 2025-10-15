
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	colored-man-pages
	fzf
)
# eval "$(zoxide init zsh)"
# eval "$(oh-my-posh init zsh --config $HOME/.zen.toml)"
ZSH_THEME=robbyrussell

export PATH="$HOME/.local/share/nvim/mason/bin/:$HOME/.local/share/AppImage:$PATH"

export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/home/pigeon/.local/bin:$PATH"

export LSFG_DLL_PATH="/home/pigeon/HDD/Games/LosslessScaling/Lossless.dll"

#for d in /home/pigeon/.local/bin/*/; do
#    PATH+=":$d"
#done

# bun completions
[ -s "/home/pigeon/.bun/_bun" ] && source "/home/pigeon/.bun/_bun"

export PKG_CONFIG_PATH=/home/pigeon/HDD/code/C/pkg-config

source "$ZSH/oh-my-zsh.sh"
alias cls="clear"
alias antimicrox="flatpak run io.github.antimicrox.antimicrox"
alias upd="yay -Syu --noconfirm && flatpak update -y"
alias pupd="sudo pacman -Syu --noconfirm && flatpak update -y"
alias reshade="$HOME/Applications/reshade-linux.sh"
alias beepinx-hardpatch="curl -sSL https://tobey.me/mods/bepinex/hardpatcher/patch.fsx --output .tobey.patch.fsx && dotnet fsi .tobey.patch.fsx ; rm .tobey.patch.fsx"
alias audiosource="/home/pigeon/nvme/github/audiosource/audiosource run"
alias chaotic="yes | sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && yes | sudo pacman-key --lsign-key 3056513887B78AEB && sudo pacman --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && sudo pacman --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'"
alias nvbun="__NV_PRIME_RENDER_OFFLOAD=1 __NV_DISABLE_EXPLICIT_SYNC=1 bun"
alias c="codium --ozone-platform=wayland"
alias lvim="~/.local/bin/lvim"
alias neolvim="/bin/sh -c '$HOME/.local/bin/neovide-lunarvim' & "
alias llvim="alacritty -e ~/.local/bin/lvim "
alias cpl="find . -name '*pp' | xargs wc -l"
# alias gt="eval '$(ssh-agent)' && ssh-add ~/.ssh/default"
alias clean="rm -rf ~/.cache/yay && sudo pacman -Scc --noconfirm && sudo journalctl --vacuum-size=500M && sudo rm -r /var/cache/pacman/pkg/* && flatpak uninstall --unused && sudo rm -rfv /var/tmp/flatpak-cache-*"
alias sch="baloosearch6"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/pigeon/.lmstudio/bin"

alias snvm="[ -z \"$NVM_DIR\" ] && export NVM_DIR=\"$HOME/.nvm\" && source /usr/share/nvm/nvm.sh && source /usr/share/nvm/bash_completion && source /usr/share/nvm/install-nvm-exec"
# alias hx="helix"
alias ghx="alacritty -e helix"
alias gap="git add --patch"
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias l="eza -la --group-directories-first"
alias ll="eza -l --group-directories-first"

alias cpr="rsync -Pr"
eval $(ssh-agent) > /dev/null && ssh-add ~/.ssh/github 2> /dev/null

alias umm="mono /home/pigeon/HDD/Games/UnityModManagerInstaller/UnityModManager.exe"
alias nvim="~/.local/share/bob/nvim-bin/nvim"

alias mirrors="curl -s 'https://archlinux.org/mirrorlist/all/' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -"

export SUDO_EDITOR=hx
export QT_QPA_PLATFORMTHEME="qt6ct"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/pigeon/.opam/opam-init/init.zsh' ]] || source '/home/pigeon/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
