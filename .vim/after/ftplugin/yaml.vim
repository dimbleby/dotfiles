setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal textwidth=80

if executable('prettier')
    setlocal formatprg=prettier\ --parser=yaml\ --prose-wrap=always

    " prettier strips the document begin -
    " https://github.com/prettier/prettier/issues/5013.  So reinstate it when
    " done.
    nnoremap <buffer> <LocalLeader>q gg:keepjumps normal! gqG<CR>:keepjumps 0put='---'<CR>``k
endif
