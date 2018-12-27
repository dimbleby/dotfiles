" Left-align function parameters so that the longest line touches the
" right-hand margin.
function! alignParams#AlignParams(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    else
        let [l:lnum1, l:lnum2] = [line("'["), line("']")]
    endif

    " This style is only used by a particular codebase, so the hardcoding of
    " the right-hand margin isn't a big deal.
    execute l:lnum1 . ',' . l:lnum2 . 'right 79'
    let l:lines = getline(l:lnum1, l:lnum2)
    let l:lefts = map(l:lines, {key, val -> match(val, '\S')})
    let l:leftmost = min(l:lefts)
    execute l:lnum1 . ',' . l:lnum2 . 'left ' . l:leftmost
endfunction
