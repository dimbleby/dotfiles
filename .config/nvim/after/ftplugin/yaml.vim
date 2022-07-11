setlocal textwidth=100

if !exists('*nvim_treesitter#foldexpr()')
    setlocal foldmethod=indent
endif

if executable('prettier')
    setlocal formatprg=prettier\ --parser=yaml\ --prose-wrap=always\ --print-width=100
endif
