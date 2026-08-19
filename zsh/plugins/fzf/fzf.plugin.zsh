# fzf plugin: sources the fzf shell integration files bundled in this config
# (fzf/completion.zsh and fzf/key-bindings.zsh) instead of relying on
# oh-my-zsh's fzf plugin or a system-wide install path.

if (( $+commands[fzf] )); then
  local _fzf_shell="$(dirname "${(%):-%x}")/../../fzf"

  if [[ -o interactive ]]; then
    source "$_fzf_shell/completion.zsh" 2> /dev/null
  fi
  source "$_fzf_shell/key-bindings.zsh" 2> /dev/null

  if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
    if (( $+commands[fd] )); then
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    elif (( $+commands[rg] )); then
      export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    elif (( $+commands[ag] )); then
      export FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore .git'
    fi
  fi

  unset _fzf_shell
fi