setlocal textwidth=100

if !exists('*nvim_treesitter#foldexpr()')
    setlocal foldmethod=syntax
endif

if executable('terraform')
    setlocal formatprg=terraform\ fmt\ -no-color\ -
endif
