" Reformat Python code
nmap <buffer> <localleader>= :Black<CR>

let b:ale_linters = ['flake8', 'pyls']
let b:ale_linters_ignore = ['pyls']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
