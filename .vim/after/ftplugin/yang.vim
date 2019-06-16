setlocal textwidth=100
setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <buffer> <silent> <Leader>q :call LanguageClient#textDocument_formatting()<CR>
setlocal foldmethod=syntax
