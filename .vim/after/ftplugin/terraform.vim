setlocal textwidth=100
nnoremap <buffer> <Leader>q :TerraformFmt<CR>
if !exists('*nvim_treesitter#foldexpr()')
    setlocal foldmethod=syntax
endif
