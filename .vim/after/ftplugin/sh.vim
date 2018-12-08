if executable('docker')
    set formatprg=docker\ run\ -i\ --rm\ mvdan/shfmt:v2.6.1\ shfmt\ -i\ 2\ -sr\ -ci
endif
