set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --rust-completer
  endif
endfunction

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
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
if has('python') || has('python3')
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif
Plug 'vim-perl/vim-perl'
Plug 'w0rp/ale'
call plug#end()

set scrolloff=1
set sidescrolloff=5
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" Backups
" NB consider a crontab entry like this:
" 0 0 * * *   find ~/.local/share/vim/backup -not -newerat "1 month ago" -type f -delete
set backup
if has('nvim')
    set backupdir=~/.local/share/nvim/backup
else
    set backupdir=~/.local/share/vim/backup
endif

" Leader
let mapleader = "\<Space>"

" Logical Y
:map Y y$

" More natural split opening
set splitbelow
set splitright

" Avoid Ex mode
nnoremap Q <nop>

set expandtab
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufReadPost *.h set filetype=c
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.cli set filetype=xml
    autocmd FileType make set noexpandtab
    autocmd FileType json,perl,python setlocal shiftwidth=4
    autocmd FileType c,cpp,ruby,sh,typescript,xml,yaml setlocal shiftwidth=2
augroup END
let c_space_errors = 1
let python_space_error_highlight = 1

set background=dark
set termguicolors

let g:ale_linters = {
    \ 'c': [],
    \ 'cpp': [],
    \ 'rust': ['rls'],
    \ }
let g:ale_python_flake8_options = "--ignore=E203,W503 --max-line-length=88"
let g:ale_rust_rls_toolchain = 'stable'

let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.elm = ['.']

let g:elm_format_autosave = 1

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" FZF helpers
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>h :History<CR>

" Navigating errors
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)

" More convenient navigation between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Reformat Python code
nmap <A-b> :Black<CR>

" N-BASE comment block formatting.
noremap <silent> <A-f> :BlockFormat<CR>

" Terminal mode shortcuts
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif

" using GTAGS
set csprg=gtags-cscope
set cscopetag
set csto=0
set cst
if filereadable("GTAGS")
    silent cs add GTAGS
endif

" Go to definition, find callers.
nnoremap <silent> gc :cs find c <C-r><C-w><CR>
nnoremap <silent> gd :YcmCompleter GoTo<CR>

" For when we forget to sudo.
cmap w!! w !sudo tee > /dev/null %
