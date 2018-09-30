if executable('xmllint')
    nnoremap <buffer> <localleader>= :%!xmllint --format --recover -<CR>
endif
