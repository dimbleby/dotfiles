let s:formatprgs = []
if executable('isort')
    call add(s:formatprgs, 'isort --quiet -')
endif
if executable('black')
    call add(s:formatprgs, 'black --quiet -')
endif
let &l:formatprg = join(s:formatprgs, '|')
unlet s:formatprgs

setlocal foldmethod=indent
setlocal textwidth=88
