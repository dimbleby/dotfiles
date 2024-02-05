# shellcheck shell=bash
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export HISTFILESIZE=200000
export HISTSIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

export VISUAL=~/.local/bin/nvim
export EDITOR=~/.local/bin/nvim

export FZF_DEFAULT_COMMAND='fd --type file --ignore-file ~/.ignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export KUBECTX_IGNORE_FZF=1

export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv

export NIPAP_SERVER=10.231.137.79

export GOFUMPT_SPLIT_LONG_LINES=on

export PATH=$HOME/.local/bin:$HOME/.msrustup/bin:$HOME/.cargo/bin:$PATH

if command -v bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v keychain > /dev/null; then
  eval "$(keychain --quiet --eval --agents gpg,ssh)"
fi

# shellcheck source=/dev/null
if [[ -f ~/.set-secrets.sh ]]; then . ~/.set-secrets.sh; fi

# shellcheck source=/dev/null
if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi
