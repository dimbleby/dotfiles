if executable('xmllint')
    setlocal formatexpr=
    setlocal formatprg=xmllint\ --format\ -
endif
setlocal foldmethod=indent
setlocal textwidth=100
