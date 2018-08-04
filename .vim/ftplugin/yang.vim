" let b:ale_yang_lsp_executable = '/opt/yang-language-server/bin/yang-language-server'
" let b:ale_linters = ['yang_lsp']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
let b:ale_linters = []

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <LocalLeader>r :call LanguageClient#textDocument_references() <bar> copen<CR>
nnoremap <silent> <LocalLeader>t :call LanguageClient#textDocument_hover()<CR>
