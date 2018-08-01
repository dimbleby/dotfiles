" Prelude {{{1
" vim: foldmethod=marker
set nocompatible

" Python environment {{{1
if has('nvim')
    let g:loaded_python_provider = 1
    let g:python3_host_prog = $HOME.'/.local/share/virtualenvs/neovim-py-SOCio1D1/bin/python3'
endif

" Plugins {{{1
" Load plug.vim automatically {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins {{{2
call plug#begin('~/.vim/plugged')
if has('python') || has('python3')
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/BlockFormat.git'
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/snippets.git'
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/vimips.git'
endif
if has('python3')
    Plug 'dimbleby/black.vim'
endif
Plug 'derekwyatt/vim-scala'
Plug 'ElmCast/elm-vim'
if has('python') || has('python3')
    Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'nathanalderson/yang.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
endif
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-perl/vim-perl'
Plug 'w0rp/ale'
call plug#end()

" Ale {{{2
let g:ale_completion_enabled = 1
let g:ale_linters = {
  \   'c': ['cquery'],
  \   'cpp': ['cquery'],
  \   'python': ['flake8', 'pyls'],
  \   'rust': ['rls'],
  \ }
let g:ale_linters_ignore = ['pyls']
let g:ale_rust_rls_toolchain = 'stable'

" Deoplete {{{2
let g:deoplete#enable_at_startup = 1

" Elm {{{2
let g:elm_format_autosave = 1

" UltiSnips {{{2
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

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

" Filetype-specific variations {{{2
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufReadPost *.h set filetype=c
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.cli set filetype=xml
    autocmd FileType make setlocal noexpandtab
    autocmd FileType c,cpp,ruby,sh,typescript,xml,yaml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType c,cpp setlocal colorcolumn=80
    autocmd FileType markdown setlocal linebreak
    if has('nvim')
        autocmd TermOpen * startinsert
    endif
augroup END
let c_space_errors = 1
let python_space_error_highlight = 1

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
set termguicolors
highlight ColorColumn guibg=DimGray
highlight TermCursorNC guibg=DimGray

" Save cursor position {{{2
augroup memory
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Mappings {{{1
" Leader {{{2
let mapleader = "\<Space>"

" Logical Y {{{2
noremap Y y$

" Avoid Ex mode {{{2
nnoremap Q <nop>

" FZF helpers {{{2
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>h :History<CR>

" Navigating splits {{{2
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Language servers {{{2
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <LocalLeader>r :ALEFindReferences <bar> copen<CR>
nnoremap <silent> <LocalLeader>t :ALEHover<CR>

" Tab for completion {{{2
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Terminal mode {{{2
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif

" Sudo write {{{2
" NB broken in neovim - https://github.com/neovim/neovim/issues/1716
if !has('nvim')
    cmap w!! w !sudo tee % > /dev/null
endif
