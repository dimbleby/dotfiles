" pyls linting can't be be made to respect `# noqa` - see
" https://github.com/palantir/python-language-server/issues/281.
"
" LanguageClient can only be configured to ignore diagnostics globally.
"
" So we access pyls via ALE, ignore its linting, and switch in flake8.
let b:ale_completion_enabled = 1
let b:ale_linters = ['flake8', 'pyls']
let b:ale_linters_ignore = ['pyls']

nnoremap <buffer> <localleader>= :Black<CR>
nnoremap <buffer> <silent> gd :ALEGoToDefinition<CR>
nnoremap <buffer> <silent> <LocalLeader>r :ALEFindReferences <bar> copen<CR>
nnoremap <buffer> <silent> <LocalLeader>t :ALEHover<CR>
