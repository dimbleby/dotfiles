setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

if executable('xmllint')
    setlocal formatexpr=
    setlocal formatprg=xmllint\ --format\ -
    nnoremap <buffer> <LocalLeader>q gg:keepjumps normal! gqG<CR>``
endif
