setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal textwidth=80

if executable('prettier')
    setlocal formatprg=prettier\ --parser=yaml\ --prose-wrap=always
    nnoremap <buffer> <LocalLeader>q gg:keepjumps normal! gqG<CR>``
endif
