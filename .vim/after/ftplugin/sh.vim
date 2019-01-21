if executable('docker')
    setlocal formatprg=docker\ run\ -i\ --rm\ mvdan/shfmt:v2.6.3\ -i\ 2\ -sr\ -ci
endif

" Via tpope/vim-apathy
setlocal include=^\\s*\\%(\\.\\\|source\\)\\s
setlocal define=\\<\\%(\\i\\+\\s*()\\)\\@=
