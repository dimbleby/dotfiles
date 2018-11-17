if executable('prettier')
    setlocal formatprg=prettier\ --parser=json-stringify
else
    setlocal formatprg=python\ -m\ json.tool
endif
nnoremap <buffer> <LocalLeader>q gg:keepjumps normal! gqG<CR>``
