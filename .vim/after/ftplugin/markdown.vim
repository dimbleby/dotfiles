setlocal linebreak
if executable('prettier')
    setlocal equalprg=prettier\ --parser=markdown\ --prose-wrap=always
    nnoremap <buffer> <localleader>= gg=G``
endif
