let b:ale_linters = []
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

nnoremap <buffer> <localleader>= :RustFmt<CR>
