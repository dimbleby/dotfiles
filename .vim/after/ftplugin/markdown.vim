setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal equalprg=prettier\ --parser=markdown\ --prose-wrap=always
    nnoremap <buffer> <LocalLeader>= gg=G``
endif
