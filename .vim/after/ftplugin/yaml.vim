setlocal foldmethod=indent
setlocal textwidth=100

if executable('prettier')
    setlocal formatprg=prettier\ --parser=yaml\ --prose-wrap=always
endif
