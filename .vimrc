set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'ssh://git@gitlab.datcon.co.uk/RyanNorris/vimips.git'
if has('python3')
    Plugin 'ambv/black'
endif
Plugin 'derekwyatt/vim-scala'
Plugin 'ElmCast/elm-vim'
Plugin 'nathanalderson/yang.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rust-lang/rust.vim'
if has('python') || has('python3')
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'vim-perl/vim-perl'
Plugin 'w0rp/ale'

call vundle#end()

filetype plugin indent on
syntax on

" Backups
" NB consider a crontab entry like this:
" 0 0 * * *   find ~/.local/share/vim/backup -not -newerat "1 month ago" -type f -delete
set backup
if has('nvim')
    set backupdir=~/.local/share/nvim/backup
else
    set backupdir=~/.local/share/vim/backup
endif

" More natural split opening
set splitbelow
set splitright

" Avoid Ex mode
nnoremap Q <nop>

set expandtab
filetype plugin indent on
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.cli set filetype=xml
    autocmd FileType make set noexpandtab
    autocmd FileType json,perl,python setlocal shiftwidth=4
    autocmd FileType c,cpp,ruby,sh,typescript,xml,yaml setlocal shiftwidth=2
augroup END
let c_space_errors = 1

set bg=dark

let g:ale_linters = {}
let g:ale_linters.c = []
let g:ale_linters.cpp = []
let g:ale_python_flake8_options = "--ignore=E203,W503 --max-line-length=99"

let g:elm_format_autosave = 1

let g:ycm_confirm_extra_conf = 0
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.elm = ['.']

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
nmap <C-b> :Black<CR>

" Learn to stop using arrow keys!
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

" using GTAGS
set csprg=gtags-cscope
set cscopetag
set csto=0
set cst
cs add GTAGS
nmap <C-\>g :cs f g <C-r><C-w><CR>
nmap <C-\>s :cs f s <C-r><C-w><CR>
nmap <C-\>c :cs f c <C-r><C-w><CR>
