" Weird textwidth to make room for boxed comments per coding standards
setlocal colorcolumn=80
setlocal textwidth=76
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

nnoremap <buffer> <silent> <localleader>= :BlockFormat<CR>
nnoremap <buffer> <silent> <localleader>c :call LanguageClient#cquery_callers() <bar> copen<CR>
nnoremap <buffer> <silent> <localleader>v :call LanguageClient#cquery_vars() <bar> copen<CR>
nnoremap <buffer> <silent> <localleader>i :call LanguageClient#textDocument_implementation() <bar> copen<CR>
