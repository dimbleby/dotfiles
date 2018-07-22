" Improved EnsimeDeclaration
function! EnsimeDeclarationMaybeSplit()
    if &modified
       :EnDeclarationSplit
    else
       :EnDeclaration
    endif
endfunction

nmap <buffer> <silent> gd :call EnsimeDeclarationMaybeSplit()<CR>
nmap <buffer> <silent> <localleader>t :EnType<CR>
xmap <buffer> <silent> <localleader>t :EnType selection<CR>
