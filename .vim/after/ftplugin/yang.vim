setlocal textwidth=100
nnoremap <buffer> <silent> <Leader>q :call LanguageClient#textDocument_formatting()<CR>
setlocal foldmethod=syntax
