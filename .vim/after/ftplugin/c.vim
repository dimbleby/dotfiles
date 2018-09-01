setlocal colorcolumn=80

nnoremap <buffer> <silent> <localleader>= :BlockFormat<CR>
nnoremap <buffer> <silent> <localleader>c :call LanguageClient#cquery_callers() <bar> copen<CR>
nnoremap <buffer> <silent> <localleader>v :call LanguageClient#cquery_vars() <bar> copen<CR>
nnoremap <buffer> <silent> <localleader>i :call LanguageClient#textDocument_implementation() <bar> copen<CR>
