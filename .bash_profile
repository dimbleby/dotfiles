# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export HISTFILESIZE=200000
export HISTSIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

export VISUAL=~/.local/bin/nvim
export EDITOR=~/.local/bin/nvim

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export KUBECTX_IGNORE_FZF=1

export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv

export NIPAP_SERVER=10.231.137.79

if [[ "$(< /proc/sys/kernel/osrelease)" == *microsoft* ]]; then
  WSL_HOST=$(ip -4 route show default dev eth0 | awk '{ print $3 }')
  export DISPLAY=$WSL_HOST:0
  export LIBGL_ALWAYS_INDIRECT=1
fi

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.krew/bin:$PATH

if type -p bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

eval "$(keychain --quiet --eval --agents gpg,ssh)"

if command -v dockerd > /dev/null; then
  if [[ "$(service docker status)" != " * Docker is running" ]]; then
    sudo service docker start
  fi
fi

# shellcheck source=/dev/null
if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi
