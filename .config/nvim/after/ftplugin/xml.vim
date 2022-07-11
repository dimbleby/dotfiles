setlocal textwidth=100
setlocal foldmethod=indent
if executable('xmllint')
    setlocal formatexpr=
    setlocal formatprg=xmllint\ --format\ -
endif
