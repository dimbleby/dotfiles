setlocal spell
setlocal linebreak
setlocal textwidth=80
if executable('prettier')
    setlocal formatprg=prettier\ --parser=markdown
endif
nnoremap <buffer> <LocalLeader>m :ComposerStart<CR>

" Formatting, with each new sentence on a new line.
nnoremap <expr> <buffer> <silent> <LocalLeader>w ventilate#Ventilate()
xnoremap <expr> <buffer> <silent> <LocalLeader>w ventilate#Ventilate()
nnoremap <expr> <buffer> <silent> <LocalLeader>ww ventilate#Ventilate() . '_'
