setlocal textwidth=100
if executable('terraform')
    setlocal formatprg=terraform\ fmt\ -
endif
setlocal foldmethod=syntax
