" Left-align function parameters so that the longest line touches the
" right-hand margin.
function! alignParams#AlignParams(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif

    " This style is only used by a particular codebase, so the hardcoding of
    " the right-hand margin isn't a big deal.
    let [lnum1, lnum2] = [line("'["), line("']")]
    execute lnum1 . ',' . lnum2 . 'right 79'
    let lines = getline(lnum1, lnum2)
    let lefts = map(lines, {key, val -> match(val, '\S')})
    let leftmost = min(lefts)
    execute lnum1 . ',' . lnum2 . 'left ' . leftmost
endfunction
