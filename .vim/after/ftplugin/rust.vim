if executable('rustfmt')
    setlocal formatprg=rustfmt\ --edition\ 2018\ --color\ never\ --emit\ stdout
endif
