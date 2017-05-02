Dotfiles, managed by a bare git repository, as recommended [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

To set up on a new machine:

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare git@github.com:/dimbleby/dotfiles $HOME/.cfg
config checkout
config config --local status.showUntrackedFiles no
```

