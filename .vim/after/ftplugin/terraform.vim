if executable('terraform')
    setlocal formatprg=terraform\ fmt\ -
endif
set foldmethod=syntax
