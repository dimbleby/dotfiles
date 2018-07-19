" Prelude {{{1
" vim: foldmethod=marker
set nocompatible

" Plugins {{{1
" Load plug.vim automatically {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Compile YCM completers {{{2
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer --rust-completer
    endif
endfunction

" Install plugins {{{2
call plug#begin('~/.vim/plugged')
if has('python') || has('python3')
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/BlockFormat.git', { 'for': ['c', 'cpp'] }
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/snippets.git'
    Plug 'ssh://git@gitlab.datcon.co.uk/dch/vimips.git'
endif
if has('python3')
    Plug 'ambv/black', { 'for': 'python' }
endif
Plug 'derekwyatt/vim-scala'
Plug 'ElmCast/elm-vim'
Plug 'nathanalderson/yang.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
endif
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
if has('python') || has('python3')
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif
Plug 'vim-perl/vim-perl'
Plug 'w0rp/ale'
call plug#end()

" Ale {{{2
let g:ale_linters = {
  \   'c': [],
  \   'cpp': [],
  \   'rust': ['rls'],
  \ }
let g:ale_python_flake8_options = "--ignore=E203,W503 --max-line-length=88"
let g:ale_rust_rls_toolchain = 'stable'

" YCM {{{2
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.elm = ['.']

" Elm {{{2
let g:elm_format_autosave = 1

" UltiSnips {{{2
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" Preferences {{{1
" Defaults {{{2
set diffopt=vertical
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set scrolloff=1
set sidescrolloff=5
set shiftround
set splitbelow
set splitright

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

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

" Tags {{{2
set cscopeprg=gtags-cscope
set cscopetag
set cscopetagorder=0
if filereadable("GTAGS")
    set nocscopeverbose
    silent cscope add GTAGS
    set cscopeverbose
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
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" Mappings {{{1
" Leader {{{2
let mapleader = "\<Space>"

" Logical Y {{{2
:map Y y$

" Avoid Ex mode {{{2
nnoremap Q <nop>

" FZF helpers {{{2
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>h :History<CR>

" Navigating splits {{{2
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Reformat Python code {{{2
nmap <M-b> :Black<CR>

" Reformat N-BASE comment {{{2
nmap <silent> <M-f> :BlockFormat<CR>

" Tags {{{2
nnoremap <silent> gc :cscope find c <C-r><C-w><CR>
nnoremap <silent> gd :YcmCompleter GoTo<CR>

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
if !has("nvim")
    cmap w!! w !sudo tee % > /dev/null
endif
