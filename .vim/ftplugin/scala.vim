" Improved EnsimeDeclaration
function! EnsimeDeclarationMaybeSplit()
    if &modified
       :EnDeclarationSplit
    else
       :EnDeclaration
    endif
endfunction

nmap <buffer> <silent> gd :call EnsimeDeclarationMaybeSplit()<CR>
nmap <buffer> <silent> <LocalLeader>t :EnType<CR>
xmap <buffer> <silent> <LocalLeader>t :EnType selection<CR>
