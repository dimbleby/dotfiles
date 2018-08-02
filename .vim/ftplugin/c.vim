" Reformat N-BASE comment
nmap <buffer> <silent> <localleader>= :BlockFormat<CR>

let b:ale_linters = ['cquery']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
