setlocal shiftwidth=2 softtabstop=2 tabstop=2
if executable('docker')
    set formatprg=docker\ run\ -i\ --rm\ peterdavehello/shfmt\ shfmt\ -i\ 2\ -sr\ -ci
endif
