" A bad approximation to 'ventilated prose' - insert a line break after each
" sentence, and then wrap each line individually to deal with long sentences.
function! ventilate#Ventilate(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif

    " Format the selection with a massive textwidth to get long lines.
    let oldtw=&l:textwidth
    let &l:textwidth=999999
    execute 'normal! ''[gw'']'
    let &l:textwidth=oldtw

    " Split on .!?
    execute '''[,'']substitute/\v[.!?]\zs +/\r/ge'

    " Format each line.
    execute '''[,'']g/^/normal! gww'
endfunction
