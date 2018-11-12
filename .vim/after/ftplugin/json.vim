if executable('prettier')
    setlocal equalprg=prettier\ --parser=json-stringify
else
    setlocal equalprg=python\ -m\ json.tool
endif
nnoremap <buffer> <LocalLeader>= gg=G``
