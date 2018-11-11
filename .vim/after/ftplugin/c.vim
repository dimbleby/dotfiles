" Weird textwidth to make room for boxed comments.
setlocal textwidth=76
setlocal colorcolumn=80
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Don't indent C++ scope declarations, align on (.
setlocal cinoptions=g0(0

" Align function parameters against the right-hand margin.
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
nnoremap <expr> <buffer> <silent> <localleader>=  <SID>AlignParams()
xnoremap <expr> <buffer> <silent> <localleader>=  <SID>AlignParams()
nnoremap <expr> <buffer> <silent> <localleader>== <SID>AlignParams() . '_'

" Boxed comments.
nnoremap <buffer> <silent> <localleader>q :BlockFormat<CR>

" ccls specials.
nnoremap <buffer> <silent> <localleader>h :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
nnoremap <buffer> <silent> <localleader>j :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
nnoremap <buffer> <silent> <localleader>k :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
nnoremap <buffer> <silent> <localleader>l :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>
nnoremap <buffer> <silent> <localleader>c :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
nnoremap <buffer> <silent> <localleader>v :call LanguageClient#findLocations({'method':'$ccls/vars'})<cr>
