if executable('docker')
    set formatprg=docker\ run\ -i\ --rm\ mvdan/shfmt\ -i\ 2\ -sr\ -ci
endif
