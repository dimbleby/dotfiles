setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal formatprg=prettier\ --parser=markdown\ --prose-wrap=always
    nnoremap <buffer> <LocalLeader>q gg:keepjumps normal! gqG<CR>``
endif
