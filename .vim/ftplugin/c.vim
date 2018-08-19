setlocal colorcolumn=80

let b:ale_linters = []

nmap <buffer> <silent> <localleader>= :BlockFormat<CR>
nmap <buffer> <silent> <localleader>c :call LanguageClient#cquery_callers() <bar> copen<CR>
nmap <buffer> <silent> <localleader>v :call LanguageClient#cquery_vars() <bar> copen<CR>
nmap <buffer> <silent> <localleader>i :call LanguageClient#textDocument_implementation() <bar> copen<CR>
