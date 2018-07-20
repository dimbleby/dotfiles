" Improved EnsimeDeclaration
function! EnsimeDeclarationMaybeSplit()
    if &modified
       :EnDeclarationSplit
    else
       :EnDeclaration
    endif
endfunction

nnoremap <buffer> <silent> gd :call EnsimeDeclarationMaybeSplit()<CR>
nnoremap <buffer> <silent> <localleader>t :EnType<CR>
xnoremap <buffer> <silent> <localleader>t :EnType selection<CR>
