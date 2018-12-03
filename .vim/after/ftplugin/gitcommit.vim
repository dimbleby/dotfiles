augroup UndoRestoredCursor
    autocmd!
    autocmd BufWinEnter <buffer> execute 'normal! gg0'
augroup END
