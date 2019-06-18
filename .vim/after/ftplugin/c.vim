" Weird textwidth to make room for boxed comments.
setlocal textwidth=76 colorcolumn=80

if executable('clang-format')
    setlocal formatprg=clang-format\ -assume-filename=%
endif

" Align function parameters, in idiosyncratic style.
nnoremap <expr> <buffer> <silent> <LocalLeader>=  alignParams#AlignParams()
xnoremap <expr> <buffer> <silent> <LocalLeader>=  alignParams#AlignParams()
nnoremap <expr> <buffer> <silent> <LocalLeader>== alignParams#AlignParams() . '_'

" Boxed comments.
nnoremap <buffer> <silent> <LocalLeader>w :BlockFormat<CR>

" ccls specials.
nnoremap <buffer> <silent> <LocalLeader>h :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<CR>
nnoremap <buffer> <silent> <LocalLeader>j :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<CR>
nnoremap <buffer> <silent> <LocalLeader>k :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<CR>
nnoremap <buffer> <silent> <LocalLeader>l :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<CR>
nnoremap <buffer> <silent> <LocalLeader>c :call LanguageClient#findLocations({'method':'$ccls/call'})<CR>
nnoremap <buffer> <silent> <LocalLeader>v :call LanguageClient#findLocations({'method':'$ccls/vars'})<CR>
