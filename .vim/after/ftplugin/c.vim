" Weird textwidth to make room for boxed comments.
setlocal textwidth=76 colorcolumn=80
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Don't indent C++ scope declarations, align on (.
setlocal cinoptions=g0,(0

setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <buffer> <silent> <Leader>q :call LanguageClient#textDocument_formatting()<CR>

" Don't wrap the closing brace in parameter lists.
let b:argwrap_wrap_closing_brace = 0

" Left-align function parameters so that the longest line touches the
" right-hand margin.
function! s:AlignParams(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [l:lnum1, l:lnum2] = [a:1, a:2]
    else
        let [l:lnum1, l:lnum2] = [line("'["), line("']")]
    endif

    execute l:lnum1 . ',' . l:lnum2 . 'right 79'
    let l:lines = getline(l:lnum1, l:lnum2)
    let l:lefts = map(l:lines, {key, val -> match(val, '\S')})
    let l:leftmost = min(l:lefts)
    execute l:lnum1 . ',' . l:lnum2 . 'left ' . l:leftmost
endfunction

command! -range -bar -buffer AlignParams call s:AlignParams(<line1>, <line2>)
nnoremap <expr> <buffer> <silent> <LocalLeader>=  <SID>AlignParams()
xnoremap <expr> <buffer> <silent> <LocalLeader>=  <SID>AlignParams()
nnoremap <expr> <buffer> <silent> <LocalLeader>== <SID>AlignParams() . '_'

" Boxed comments.
nnoremap <buffer> <silent> <LocalLeader>w :BlockFormat<CR>

" ccls specials.
nnoremap <buffer> <silent> <LocalLeader>h :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<CR>
nnoremap <buffer> <silent> <LocalLeader>j :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<CR>
nnoremap <buffer> <silent> <LocalLeader>k :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<CR>
nnoremap <buffer> <silent> <LocalLeader>l :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<CR>
nnoremap <buffer> <silent> <LocalLeader>c :call LanguageClient#findLocations({'method':'$ccls/call'})<CR>
nnoremap <buffer> <silent> <LocalLeader>v :call LanguageClient#findLocations({'method':'$ccls/vars'})<CR>
