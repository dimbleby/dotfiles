if executable('shfmt')
    setlocal formatprg=shfmt\ -i\ 2\ -sr\ -ci
endif

" Via tpope/vim-apathy
setlocal include=^\\s*\\%(\\.\\\|source\\)\\s
setlocal define=\\<\\%(\\i\\+\\s*()\\)\\@=
