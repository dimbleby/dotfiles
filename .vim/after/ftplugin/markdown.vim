setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal equalprg=prettier\ --parser=markdown\ --prose-wrap=always
    nnoremap <buffer> <localleader>= gg=G``
endif
