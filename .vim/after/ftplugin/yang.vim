setlocal textwidth=100
if executable('pyang')
    setlocal formatprg=pyang\ --format\ yang\ --yang-canonical\ --keep-comments\ --\ 2>/dev/null
endif
setlocal foldmethod=syntax
