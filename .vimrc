" Prelude {{{1
scriptencoding utf-8

" Python environment {{{1
" Prefer python3 {{{2
if has('nvim')
    let g:loaded_python_provider = 1
endif
if has('pythonx')
    set pyxversion=3
elseif has('python3')
    " Forces python3 when we have both python/dyn and python3/dyn
endif

" Prefer the neovim virtualenv {{{2
"
" g:python3_host_prog is a neovim-only thing, but it's used unconditionally by
" nvim-yarp - so set it always.
let g:python3_host_prog = $HOME.'/.virtualenvs/neovim/bin/python3'
if exists('&pythonthreehome')
    set pythonthreehome=~/.virtualenvs/neovim
endif

" Preferences {{{1
" Defaults {{{2
set autoread
set complete-=i
set dictionary=/usr/share/dict/words
set display+=lastline
set diffopt+=vertical
if has('nvim') || has('patch-8.1.0360')
    set diffopt+=algorithm:histogram,indent-heuristic
endif
set foldlevelstart=99
set history=10000
if exists('&inccommand')
    set inccommand=nosplit
endif
set incsearch
if exists('&jumpoptions')
    set jumpoptions=stack
endif
set laststatus=2
set lazyredraw
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nomodeline
set nrformats-=octal
set scrolloff=1 sidescrolloff=5 sidescroll=1
set sessionoptions-=options
set showcmd noshowmode
set splitbelow splitright
set tabpagemax=50
if !has('nvim')
    set ttyfast
endif
set wildmenu

" Indenting and formatting {{{2
set expandtab smarttab
set tabstop=4 shiftwidth=0 softtabstop=-1
set shiftround
set formatlistpat=^\\s*[-*+]\\s\\+
set formatoptions-=t formatoptions+=croqnlj

" Filetype-specific variations {{{2
let c_space_errors = 1
let c_syntax_for_h = 1
let g:pyindent_open_paren = '&sw'

" Enable Cfilter {{{2
if has('nvim') || has('patch-8.1.311')
    packadd cfilter
endif

" Open terminal in insert mode {{{2
if has('nvim')
    augroup OpenTerminal
        autocmd!
        autocmd TermOpen,WinEnter term://* startinsert
    augroup END
endif

" Use ripgrep {{{2
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Backups {{{2
" Consider a crontab entry like this:
" 0 0 * * *   find ~/.local/share/nvim/backup -not -newerat "1 month ago" -type f -delete
set backup
set backupdir=~/.local/share/nvim/backup

" Restore cursor position {{{2
augroup RestoreCursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Plugins {{{1
" Load plug.vim automatically {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " vint: next-line -ProhibitAutocmdWithNoGroup
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins {{{2
call plug#begin('~/.vim/plugged')

" Color scheme {{{3
Plug 'gruvbox-community/gruvbox'

" Language-specific highlighting and suchlike {{{3
Plug 'pearofducks/ansible-vim'
Plug 'ElmCast/elm-vim'
Plug 'dimbleby/vim-p4-syntax'
Plug 'rust-lang/rust.vim'
Plug 'derekwyatt/vim-scala'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'nathanalderson/yang.vim'

" Linting {{{3
Plug 'dense-analysis/ale'

" Language-client {{{3
if has('job') || has('nvim')
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
endif

" Snippets {{{3
if has('python3') || has('python')
    Plug 'SirVer/ultisnips'
endif

" Completions {{{3
if has('nvim') || (has('python3') && has('job'))
    if !has('nvim')
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'
endif

" Block formatting, IPS trace navigation {{{3
if has('python3') || has('python')
    Plug 'https://gitlab.datcon.co.uk/dch/BlockFormat.git'
    Plug 'https://gitlab.datcon.co.uk/dch/vimips.git'
endif

" Status line {{{3
Plug 'itchyny/lightline.vim'

" Fuzzy finder {{{3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Markdown preview {{{3
if has('nvim') || has('job')
    function! BuildComposer(info)
    if a:info.status !=# 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
    endfunction
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
endif

" Miscellany {{{3
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()

" Colours {{{2
set background=dark
if !has('nvim')
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
endif
if exists('&termguicolors')
    set termguicolors
endif
let g:gruvbox_italic = 1
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

" LanguageClient {{{2
let g:LanguageClient_completionPreferTextEdit = 1
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_selectionUI = 'Quickfix'
let s:ccls_options = '--init=
    \{
    \  "cache": {"directory": "'.$HOME.'/.cache/ccls"},
    \  "completion": {"filterAndSort": false}
    \}'
let g:LanguageClient_serverCommands = {
    \   'c': ['ccls', s:ccls_options],
    \   'cpp': ['ccls', s:ccls_options],
    \   'python': ['pyls'],
    \   'rust': ['rls'],
    \   'scala': ['metals-vim'],
    \   'yang': ['yang-language-server'],
    \ }
unlet s:ccls_options
let g:LanguageClient_settingsPath = $HOME.'/.vim/lsp-settings.json'
let g:LanguageClient_rootMarkers = {
    \   'yang': ['yang.settings']
    \ }
let g:LanguageClient_useVirtualText = 'CodeLens'

" Ale {{{2
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_linters = map(copy(g:LanguageClient_serverCommands), '[]')

" Lightline {{{2
let g:lightline = {
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \     ]
    \   },
    \   'component_function': {
    \     'gitbranch': 'fugitive#head'
    \   },
    \ }

" Markdown preview {{{2
let g:markdown_composer_autostart = 0

" Elm {{{2
let g:elm_format_autosave = 0

" Completion and snippets {{{2
if has('nvim') || (has('python3') && has('job'))
    " NCM2 {{{3
    augroup NCM2
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
        autocmd User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
        autocmd User Ncm2PopupClose set completeopt=menu,preview
    augroup END

    " UltiSnips with NCM2 {{{3
    "
    " This section is all about expanding snippets as provided by language
    " servers - we need to make <C-j> smarter.
    "
    " We use that key first to try expanding with ncm2-ultisnips - which will
    " handle language server snippets - and only after that fall back to
    " regular UltiSnips function.
    let g:UltiSnipsExpandTrigger       = '<Plug>(ultisnips_dummy)'
    let g:UltiSnipsJumpForwardTrigger  = '<Plug>(ultisnips_dummy)'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
    inoremap <silent> <expr> <C-j> ncm2_ultisnips#expand_or('<Plug>(ultisnips_dummy)')
    snoremap <silent> <C-j> <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
    xnoremap <silent> <C-j> :call UltiSnips#SaveLastVisualSelection()<CR>gvs

    " Enable LanguageClient snippet support {{{3
    let g:LanguageClient_hasSnippetSupport = 1
else
    " UltiSnips without NCM2 {{{3
    let g:UltiSnipsExpandTrigger       = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif

" Mappings {{{1
" Leader {{{2
let mapleader = "\<Space>"

" Logical Y {{{2
noremap Y y$

" Avoid Ex mode {{{2
nnoremap Q <nop>

" Improved <C-l> {{{2
nnoremap <C-l> :nohlsearch<Bar>diffupdate<CR><C-l>

" Insert undo point before deleting a line or word {{{2
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Tab for cycling through completions {{{2
inoremap <silent> <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <silent> <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

" Terminal mode {{{2
if has('nvim') || has('terminal')
    tnoremap <Esc> <C-\><C-n>
endif
if has('nvim')
    tnoremap <C-w> <C-\><C-n><C-w>
endif

" Sudo write {{{2
" NB broken in neovim - https://github.com/neovim/neovim/issues/1716
if !has('nvim')
    cnoremap w!! w !sudo tee % > /dev/null
endif

" Searching {{{2
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <expr> <Leader>g exists(':Ggrep') ? ':Ggrep!<Space>' : ':Rg<CR>'
nnoremap <Leader>h :History<CR>
nnoremap <Leader>r :Rg<CR>

" Formatting the whole file {{{2
nnoremap <silent> <Leader>q :call format#FormatFile()<CR>

" Language server {{{2
if has('nvim') || has('job')
    augroup LanguageServerMappings
        autocmd!
        let s:lsp_fts = join(keys(g:LanguageClient_serverCommands), ',')
        let s:lsp_map = 'autocmd FileType ' . s:lsp_fts . ' nnoremap <buffer> <silent> '
        execute s:lsp_map . '<F5> :call LanguageClient_contextMenu()<CR>'
        execute s:lsp_map . 'gd :call LanguageClient#textDocument_definition()<CR>'
        execute s:lsp_map . '<LocalLeader>r :call LanguageClient#textDocument_references()<CR>'
        execute s:lsp_map . 'K :call LanguageClient#textDocument_hover()<CR>'
        execute s:lsp_map . '<LocalLeader>i :call LanguageClient#textDocument_implementation()<CR>'
        execute s:lsp_map . '<LocalLeader>a :call LanguageClient#textDocument_codeAction()<CR>'
        unlet s:lsp_map
        unlet s:lsp_fts
    augroup END
endif
