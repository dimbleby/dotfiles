let b:ale_linters = []
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

nmap <buffer> <silent> <localleader>= :BlockFormat<CR>
