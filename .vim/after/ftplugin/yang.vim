setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <buffer> <silent> <LocalLeader>q :call LanguageClient#textDocument_formatting()<CR>
