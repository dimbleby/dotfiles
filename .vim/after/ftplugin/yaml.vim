setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal textwidth=80

if executable('prettier')
    setlocal equalprg=prettier\ --parser=yaml\ --prose-wrap=always

    " prettier strips the document begin -
    " https://github.com/prettier/prettier/issues/5013.  So reinstate it when
    " done.
    nnoremap <buffer> <LocalLeader>= gg=G:0put='---'<CR>``
endif
