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
if exists('&inccommand')
    set inccommand=nosplit
endif
set incsearch
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set scrolloff=1 sidescrolloff=5
set showcmd
set splitbelow splitright

set expandtab
set shiftwidth=4 softtabstop=4 tabstop=4
set shiftround

" Folding {{{2
set nofoldenable foldlevel=99
let g:markdown_folding = 1
let g:rust_fold = 1
let g:sh_fold_enabled = 7
let g:xml_syntax_folding = 1

" Filetype-specific variations {{{2
let c_space_errors = 1
let c_syntax_for_h = 1
let g:pyindent_open_paren = '&sw'

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
highlight ColorColumn guibg=DimGrey ctermbg=DarkGrey
highlight Folded guibg=DimGrey ctermbg=DarkGrey
highlight TermCursorNC guibg=DimGrey ctermbg=DarkGrey
highlight Visual guibg=DimGrey ctermbg=DarkGrey

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
if has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'
endif

" Block formatting, IPS trace navigation {{{3
if has('python') || has('python3')
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/BlockFormat.git'
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/vimips.git'
endif

" Wrapping and unwrapping arguments {{{3
Plug 'FooSoft/vim-argwrap'

" Status line {{{3
Plug 'itchyny/lightline.vim'

" Fuzzy finder {{{3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Markdown preview {{{3
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

" Miscellany {{{3
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
call plug#end()

" Ale {{{2
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_linters = {
    \   'c': [],
    \   'cpp': [],
    \   'rust': [],
    \   'scala': [],
    \   'yang': [],
    \ }

" Black {{{2
let g:black_skip_numeric_underscore_normalization = 1

" LanguageClient {{{2
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_selectionUI = 'Quickfix'
let g:LanguageClient_serverCommands = {
    \   'c': ['ccls', '--init={"cacheDirectory": "'.$HOME.'/.cache/ccls"}'],
    \   'cpp': ['ccls', '--init={"cacheDirectory": "'.$HOME.'/.cache/ccls"}'],
    \   'python': ['pyls'],
    \   'rust': ['rls'],
    \   'scala': ['scalameta_lsp'],
    \   'yang': ['/opt/yang-language-server/bin/yang-language-server'],
    \ }
let g:LanguageClient_settingsPath = $HOME.'/.vim/lsp-settings.json'
let g:LanguageClient_rootMarkers = {
    \   'yang': ['yang.settings']
    \ }

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

" Markdown-composer.
let g:markdown_composer_autostart = 0

" NCM2 {{{2
if has('nvim')
    augroup NCM2
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
        autocmd User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
        autocmd User Ncm2PopupClose set completeopt=menu,preview
    augroup END
endif

" UltiSnips {{{2
if has('nvim')
    " This section is all about expanding snippets as provided by language
    " servers - we need to make <C-j> smarter.
    "
    " We use that key first to try expanding with ncm2-ultisnips - which will
    " handle language server snippets - and only after that fall back to
    " regular UltiSnips function.
    let g:UltiSnipsExpandTrigger       = '<Plug>(ultisnips_dummy)'
    let g:UltiSnipsJumpForwardTrigger  = '<Plug>(ultisnips_dummy)'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
    inoremap <silent> <expr> <C-j> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)")
    inoremap <silent> <Plug>(ultisnips_expand) <C-r>=UltiSnips#ExpandSnippetOrJump()<CR>
    snoremap <silent> <C-j> <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
    xnoremap <silent> <C-j> :call UltiSnips#SaveLastVisualSelection()<CR>gvs
else
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

" ArgWrap {{{2
nnoremap <Leader>a :ArgWrap<CR>

" FZF helpers {{{2
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>

" Formatting the whole file {{{2
nnoremap <Leader>q gg:keepjumps normal! gqG<CR>``

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
        unlet s:lsp_map
        unlet s:lsp_fts
    augroup END
endif
