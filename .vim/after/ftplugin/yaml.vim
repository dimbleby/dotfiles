setlocal foldmethod=indent
setlocal textwidth=80

if executable('prettier')
    setlocal formatprg=prettier\ --parser=yaml\ --prose-wrap=always
endif
