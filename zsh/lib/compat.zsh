# Compatibility layer: reimplements the oh-my-zsh internals that the copied
# lib/ and plugins/ files depend on, so the config is self-contained.

# Cache directory used by lib/completion.zsh and lib/grep.zsh
[[ -n "$ZSH_CACHE_DIR" ]] || ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR"

# ---------------------------------------------------------------------------
# Async prompt machinery (ported from oh-my-zsh lib/async_prompt.zsh)
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/src/async.zsh
# ---------------------------------------------------------------------------

zmodload zsh/system
autoload -Uz is-at-least

function _omz_register_handler {
  setopt localoptions noksharrays unset
  typeset -ga _omz_async_functions
  if [[ -z "$1" ]] || (( ! ${+functions[$1]} )) \
    || (( ${_omz_async_functions[(Ie)$1]} )); then
    return
  fi
  _omz_async_functions+=("$1")
  if (( ! ${precmd_functions[(Ie)_omz_async_request]} )) \
    && (( ${+functions[_omz_async_request]})); then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _omz_async_request
  fi
}

function _omz_async_request {
  setopt localoptions noksharrays unset
  local -i ret=$?
  typeset -gA _OMZ_ASYNC_FDS _OMZ_ASYNC_PIDS _OMZ_ASYNC_OUTPUT

  local handler
  for handler in ${_omz_async_functions}; do
    (( ${+functions[$handler]} )) || continue

    local fd=${_OMZ_ASYNC_FDS[$handler]:--1}
    local pid=${_OMZ_ASYNC_PIDS[$handler]:--1}

    if (( fd != -1 && pid != -1 )) && { true <&$fd } 2>/dev/null; then
      exec {fd}<&-
      zle -F $fd

      if [[ -o MONITOR ]]; then
        kill -TERM -$pid 2>/dev/null
      else
        kill -TERM $pid 2>/dev/null
      fi
    fi

    _OMZ_ASYNC_FDS[$handler]=-1
    _OMZ_ASYNC_PIDS[$handler]=-1

    exec {fd}< <(
      builtin echo ${sysparams[pid]}
      () { return $ret }
      $handler
    )

    _OMZ_ASYNC_FDS[$handler]=$fd

    is-at-least 5.8 || command true

    read -u $fd "_OMZ_ASYNC_PIDS[$handler]"

    zle -F "$fd" _omz_async_callback
  done
}

function _omz_async_callback() {
  emulate -L zsh

  local fd=$1
  local err=$2

  if [[ -z "$err" || "$err" == "hup" ]]; then
    local handler="${(k)_OMZ_ASYNC_FDS[(r)$fd]}"

    local old_output="${_OMZ_ASYNC_OUTPUT[$handler]}"

    IFS= read -r -u $fd -d '' "_OMZ_ASYNC_OUTPUT[$handler]"

    if [[ "$old_output" != "${_OMZ_ASYNC_OUTPUT[$handler]}" ]]; then
      zle .reset-prompt
      zle -R
    fi

    exec {fd}<&-
  fi

  zle -F "$fd"

  _OMZ_ASYNC_FDS[$handler]=-1
  _OMZ_ASYNC_PIDS[$handler]=-1
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _omz_async_request
