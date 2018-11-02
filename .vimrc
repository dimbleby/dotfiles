" Prelude {{{1
" vim: foldmethod=marker
scriptencoding utf-8

" Python environment {{{1
if has('nvim')
    let g:loaded_python_provider = 1
    let g:black_virtualenv = $HOME.'/.virtualenvs/neovim-py-EP0-X3ss'
    let g:python3_host_prog = g:black_virtualenv.'/bin/python3'
endif

" Preferences {{{1
" Defaults {{{2
set diffopt=vertical
set incsearch
if exists('&inccommand')
    set inccommand=nosplit
endif
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set scrolloff=1
set sidescrolloff=5
set splitbelow
set splitright

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround

" ripgrep {{{2
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Filetype-specific variations {{{2
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufReadPost *.h set filetype=c
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.cli set filetype=xml
    autocmd FileType make setlocal noexpandtab
    autocmd FileType ruby,sh,typescript setlocal shiftwidth=2 softtabstop=2 tabstop=2
    if has('nvim')
        autocmd TermOpen * startinsert
    endif
augroup END
let c_space_errors = 1
let g:pyindent_open_paren = '&sw'

" Backups {{{2
" Consider a crontab entry like this:
" 0 0 * * *   find ~/.local/share/vim/backup -not -newerat "1 month ago" -type f -delete
set backup
if has('nvim')
    set backupdir=~/.local/share/nvim/backup
else
    set backupdir=~/.local/share/vim/backup
endif

" Colours {{{2
set background=dark
if !has('nvim')
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
endif
if exists('&termguicolors')
    set termguicolors
endif
highlight ColorColumn guibg=DimGray ctermbg=LightGray
highlight TermCursorNC guibg=DimGray ctermbg=LightGray

" Save cursor position {{{2
augroup memory
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
augroup END

" Plugins {{{1
if has('user_commands')
    " Load plug.vim automatically {{{2
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " vint: next-line -ProhibitAutocmdWithNoGroup
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " Install plugins {{{2
    call plug#begin('~/.vim/plugged')

    " Language-specific highlighting and suchlike {{{3
    Plug 'pearofducks/ansible-vim'
    Plug 'ElmCast/elm-vim'
    Plug 'dimbleby/vim-p4-syntax'
    Plug 'vim-perl/vim-perl'
    if has('python3')
        Plug 'dimbleby/black.vim'
    endif
    Plug 'rust-lang/rust.vim'
    Plug 'derekwyatt/vim-scala'
    Plug 'nathanalderson/yang.vim'

    " Linting {{{3
    Plug 'w0rp/ale'

    " Language-client {{{3
    if has('job') || has('nvim')
        Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
    endif

    " Snippets {{{3
    if has('python') || has('python3')
        Plug 'SirVer/ultisnips'
        Plug 'ssh://git@gitlab.datcon.co.uk/dch/snippets.git'
    endif

    " Completions {{{3
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'

    " Block formatting, IPS trace navigation {{{3
    if has('python') || has('python3')
        Plug 'ssh://git@gitlab.datcon.co.uk/dch/BlockFormat.git'
        Plug 'ssh://git@gitlab.datcon.co.uk/dch/vimips.git'
    endif

    " Status line {{{3
    Plug 'itchyny/lightline.vim'

    " Fuzzy finder {{{3
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Miscellany {{{3
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-vinegar'
    call plug#end()
endif

" Ale {{{2
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_linters = {
    \ 'c': [],
    \ 'cpp': [],
    \ 'rust': [],
    \ 'scala': [],
    \ 'yang': [],
    \}

" LanguageClient {{{2
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_selectionUI = 'Quickfix'
let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--init={"cacheDirectory": "'.$HOME.'/.cache/cquery"}'],
    \ 'cpp': ['cquery', '--init={"cacheDirectory": "'.$HOME.'/.cache/cquery"}'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ 'scala': ['scalameta_lsp'],
    \ 'yang': ['/opt/yang-language-server/bin/yang-language-server'],
    \ }
let g:LanguageClient_settingsPath = $HOME.'/.vim/lsp-settings.json'
let g:LanguageClient_rootMarkers = {
    \ 'yang': ['yang.settings'],
    \ }

" Lightline {{{2
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" NCM2 {{{2
augroup ncm2
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
    autocmd User Ncm2PopupClose set completeopt=menu,preview
augroup END

" UltiSnips {{{2
" This section is mostly about expanding snippets as provided by language
" servers - if it weren't for that we'd simply set the ExpandTrigger and
" JumpForwardTrigger and be done.
"
" As it is, we're going to do some extra work to make C-j smart - and so we
" dummy out those settings.
let g:UltiSnipsExpandTrigger       = '<Plug>(ultisnips_dummy)'
let g:UltiSnipsJumpForwardTrigger  = '<Plug>(ultisnips_dummy)'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" First try expanding with ncm2_ultisnips. This is what handles language
" server snippets.
"
" Only after that try UltiSnips, as if we had set the ExpandTrigger and
" JumpForwardTrigger.
inoremap <silent> <expr> <C-j> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)")
inoremap <silent> <Plug>(ultisnips_expand) <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>
snoremap <silent> <C-j> <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
xnoremap <silent> <C-j> :call UltiSnips#SaveLastVisualSelection()<CR>gvs

" Mappings {{{1
" Leader {{{2
let mapleader = "\<Space>"

" Logical Y {{{2
noremap Y y$

" Avoid Ex mode {{{2
nnoremap Q <nop>

" Improved <C-l> {{{2
nnoremap <C-l> :nohlsearch<Bar>diffupdate<CR><C-l>

" Tab for cycling through completions {{{2
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Terminal mode {{{2
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-w> <C-\><C-n><C-w>
endif

" Sudo write {{{2
" NB broken in neovim - https://github.com/neovim/neovim/issues/1716
if !has('nvim')
    cnoremap w!! w !sudo tee % > /dev/null
endif

" FZF helpers {{{2
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>

" Language server {{{2
augroup lsp_mappings
    autocmd!
    let s:langs = join(keys(g:LanguageClient_serverCommands), ',')
    execute 'autocmd FileType ' . s:langs . ' nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>'
    execute 'autocmd FileType ' . s:langs . ' nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>'
    execute 'autocmd FileType ' . s:langs . ' nnoremap <buffer> <silent> <LocalLeader>r :call LanguageClient#textDocument_references() <bar> copen<CR>'
    execute 'autocmd FileType ' . s:langs . ' nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>'
    unlet s:langs
augroup END
