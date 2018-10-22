setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

if executable('xmllint')
    nnoremap <buffer> <localleader>= :%!xmllint --format --recover -<CR>
endif
