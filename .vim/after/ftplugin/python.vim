setlocal formatoptions-=t formatoptions+=jcroqnl
setlocal textwidth=88
let b:argwrap_tail_comma = 1
nnoremap <buffer> ]l :ALENext<CR>
nnoremap <buffer> [l :ALEPrevious<CR>
nnoremap <buffer> [L :ALEFirst<CR>
nnoremap <buffer> ]L :ALELast<CR>
nnoremap <buffer> <LocalLeader>q :Black<CR>
