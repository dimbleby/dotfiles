if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.krew/bin:$PATH

if [[ "$(< /proc/sys/kernel/osrelease)" == *microsoft* ]]; then
  export WSL_HOST=$(ip -4 route show default dev eth0 | awk '{ print $3 }')
  export DISPLAY=$WSL_HOST:0
  eval $(ssh-agent -s) > /dev/null
fi
