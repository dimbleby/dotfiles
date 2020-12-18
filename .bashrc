# Source global definitions
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi

stty -ixon

export HISTFILESIZE=200000
export HISTSIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

alias vi='nvim'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export VISUAL=~/.local/bin/nvim
export EDITOR=~/.local/bin/nvim
export LS_COLORS='ow=0:di=0;94:'

if [ -f ~/.fzf.bash ]; then . ~/.fzf.bash; fi
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export KUBECTX_IGNORE_FZF=1

# add virtualenv and virtualenvwrapper paths
export WORKON_HOME=$HOME/.virtualenvs
. /usr/bin/virtualenvwrapper.sh

# The terminal supports 256-bit colour.
if [ "$TERM" = "xterm" ]
then
  export TERM="xterm-256color"
fi

# Most servers don't have terminfo for tmux.
function ssh()
{
    local LOCAL_TERM=${TERM/tmux/xterm}
    env TERM="$LOCAL_TERM" command ssh "$@"
}

export NIPAP_SERVER=10.231.137.79
