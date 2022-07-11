" This live here because <https://github.com/neovim/neovim/issues/15536>.
augroup RestoreCursor
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END
