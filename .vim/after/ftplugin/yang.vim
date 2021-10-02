setlocal textwidth=100

if !exists('*nvim_treesitter#foldexpr()')
    setlocal foldmethod=syntax
endif

if executable('pyang')
    let s:path = expand('%:p:h')
    let &l:formatprg = 'pyang --path '.s:path.' --format yang --yang-canonical --keep-comments --'
    unlet s:path
endif
