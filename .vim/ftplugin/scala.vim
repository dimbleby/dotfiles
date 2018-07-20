" Improved EnsimeDeclaration
function! EnsimeDeclarationMaybeSplit()
    if &modified
       :EnDeclarationSplit
    else
       :EnDeclaration
    endif
endfunction

nnoremap <buffer> <silent> gd :call EnsimeDeclarationMaybeSplit()<CR>
