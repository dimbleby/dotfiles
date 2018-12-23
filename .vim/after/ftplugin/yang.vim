setlocal include=^\\s*import
setlocal suffixesadd=.yang
setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <buffer> <silent> <Leader>q :call LanguageClient#textDocument_formatting()<CR>
