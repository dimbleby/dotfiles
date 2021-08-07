" Weird textwidth to make room for boxed comments.
setlocal textwidth=76 colorcolumn=80

if executable('clang-format')
    setlocal formatprg=clang-format\ -assume-filename=%
endif

" Align function parameters, in idiosyncratic style.
nnoremap <expr> <buffer> <silent> <LocalLeader>=  alignParams#AlignParams()
xnoremap <expr> <buffer> <silent> <LocalLeader>=  alignParams#AlignParams()
nnoremap <expr> <buffer> <silent> <LocalLeader>== alignParams#AlignParams() . '_'

" Boxed comments.
nnoremap <buffer> <silent> <LocalLeader>w :BlockFormat<CR>
