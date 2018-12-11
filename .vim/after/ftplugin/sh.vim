if executable('docker')
    setlocal formatprg=docker\ run\ -i\ --rm\ mvdan/shfmt\ -i\ 2\ -sr\ -ci
endif
