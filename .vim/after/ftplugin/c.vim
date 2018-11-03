" Weird textwidth to make room for boxed comments per coding standards
setlocal colorcolumn=80
setlocal textwidth=76
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

nnoremap <buffer> <silent> <localleader>q :BlockFormat<CR>

" ccls specials.
nnoremap <silent> <localleader>h :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
nnoremap <silent> <localleader>j :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
nnoremap <silent> <localleader>k :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
nnoremap <silent> <localleader>l :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>
nnoremap <silent> <localleader>c :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
nnoremap <silent> <localleader>v :call LanguageClient#findLocations({'method':'$ccls/vars'})<cr>
