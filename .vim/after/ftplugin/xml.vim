if executable('xmllint')
    setlocal formatexpr=
    setlocal formatprg=xmllint\ --format\ -
endif
