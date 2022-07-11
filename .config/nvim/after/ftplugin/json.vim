if executable('prettier')
    setlocal formatprg=prettier\ --parser=json-stringify
endif
