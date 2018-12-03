setlocal spell
setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal formatprg=prettier\ --parser=markdown\ --prose-wrap=always
endif
nnoremap <buffer> <LocalLeader>m :ComposerStart<CR>
