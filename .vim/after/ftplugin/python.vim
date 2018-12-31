let s:formatprgs = []
if executable('isort')
    call add(s:formatprgs, 'isort -')
endif
if executable('black')
    call add(s:formatprgs, 'black -q -N -')
endif
let &l:formatprg = join(s:formatprgs, '|')
unlet s:formatprgs

setlocal foldmethod=indent
setlocal formatoptions-=t formatoptions+=jcroqnl
setlocal textwidth=88
let b:argwrap_tail_comma = 1
nnoremap <buffer> ]l :ALENext<CR>
nnoremap <buffer> [l :ALEPrevious<CR>
nnoremap <buffer> [L :ALEFirst<CR>
nnoremap <buffer> ]L :ALELast<CR>
