# shellcheck shell=bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac

if [[ "$color_prompt" = yes ]]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
else
  PS1='\u@\h:\w\$ '
fi
unset color_prompt

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b ~/.dircolors)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

GPG_TTY=$(tty)
export GPG_TTY

# Completions.
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
  fi
fi

# shellcheck source=/dev/null
if [[ -f ~/.local/fzf/shell/key-bindings.bash ]]; then
  . ~/.local/fzf/shell/key-bindings.bash
fi

stty -ixon
stty werase undef

alias vi='nvim'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Many servers don't have terminfo for tmux.
function ssh() {
  local LOCAL_TERM=${TERM/tmux/xterm}
  env TERM="$LOCAL_TERM" /usr/bin/ssh "$@"
}

# Automatically activate virtual environments when changing directories.
function cd() {
  builtin cd "$@" || return

  if [[ -d ./.venv ]]; then
    # shellcheck source=/dev/null
    source ./.venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]]; then
      deactivate
    fi
  fi
}
