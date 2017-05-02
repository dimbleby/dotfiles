set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'ssh://git@gitlab.datcon.co.uk/RyanNorris/vimips.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'ElmCast/elm-vim'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rust-lang/rust.vim'
if (v:version == 704 && has('patch143') || v:version > 704) && (has('python') || has('python3'))
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'scrooloose/syntastic'
Plugin 'vim-perl/vim-perl'

call vundle#end()

filetype plugin indent on
syntax on

" More natural split opening
set splitbelow
set splitright

" Avoid Ex mode
nnoremap Q <nop>

set expandtab
filetype plugin indent on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType make set noexpandtab
autocmd FileType perl,python setlocal shiftwidth=4
autocmd FileType c,cpp,sh,yaml setlocal shiftwidth=2
let c_space_errors = 1

set bg=dark

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_flake8_args = "--max-line-length=99"

let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1

let g:ycm_confirm_extra_conf = 0
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.elm = ['.']

" More convenient navigation between splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Learn to stop using arrow keys!
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
