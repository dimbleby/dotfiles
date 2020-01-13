setlocal textwidth=100
if executable('pyang')
    let s:path = expand('%:p:h')
    let &l:formatprg = 'pyang --path '.s:path.' --format yang --yang-canonical --keep-comments --'
    unlet s:path
endif
setlocal foldmethod=syntax
