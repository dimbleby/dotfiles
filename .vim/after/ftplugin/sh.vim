if executable('docker')
    set formatprg=docker\ run\ -i\ --rm\ peterdavehello/shfmt\ shfmt\ -i\ 2\ -sr\ -ci
endif
