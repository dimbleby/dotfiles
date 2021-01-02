if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.krew/bin:$PATH

if [[ "$(< /proc/sys/kernel/osrelease)" == *microsoft* ]]; then
  if ! grep -q datcon.co.uk /etc/resolv.conf; then
    echo "search ad.datcon.co.uk datcon.co.uk" | sudo tee -a /etc/resolv.conf > /dev/null
  fi
  export WSL_HOST=$(awk '/nameserver/{print $2}' /etc/resolv.conf)
  export DISPLAY=$WSL_HOST:0
  eval $(ssh-agent -s) > /dev/null
fi
