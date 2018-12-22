setlocal spell
setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal formatprg=prettier\ --parser=markdown
endif
nnoremap <buffer> <LocalLeader>m :ComposerStart<CR>

" A bad approximation to 'ventilated prose' - insert a line break after each
" sentence, and then wrap each line individually to deal with long sentences.
function! s:Ventilate(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif

    " Format the selection with a massive textwidth to get long lines.
    let l:oldtw=&l:textwidth
    let &l:textwidth=999999
    execute 'normal! ''[gw'']'
    let &l:textwidth=l:oldtw

    " Split on .!?
    execute '''[,'']substitute/\v[.!?]\zs +/\r/ge'

    " Format each line.
    execute '''[,'']g/^/normal! gww'
endfunction

nnoremap <expr> <buffer> <silent> <LocalLeader>w <SID>Ventilate()
xnoremap <expr> <buffer> <silent> <LocalLeader>w <SID>Ventilate()
nnoremap <expr> <buffer> <silent> <LocalLeader>ww <SID>Ventilate() . '_'
