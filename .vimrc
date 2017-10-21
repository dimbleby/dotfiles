set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'ssh://git@gitlab.datcon.co.uk/RyanNorris/vimips.git'
Plugin 'derekwyatt/vim-scala'
Plugin 'ElmCast/elm-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rust-lang/rust.vim'
if (v:version == 704 && has('patch143') || v:version > 704) && (has('python') || has('python3'))
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'vim-perl/vim-perl'
Plugin 'w0rp/ale'

call vundle#end()

filetype plugin indent on
syntax on

" Backups
" NB consider a crontab entry like this:
" 0 0 * * *   find ~/.vim/.backup -not -newerat "1 month ago" -type f -delete
set backup
set backupdir=~/.vim/.backup

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
        autocmd FileType make set noexpandtab
        autocmd FileType perl,python setlocal shiftwidth=4
        autocmd FileType c,cpp,ruby,sh,typescript,yaml setlocal shiftwidth=2
augroup END
let c_space_errors = 1

set bg=dark

let g:ale_python_flake8_args = "--max-line-length=99"

let g:elm_format_autosave = 1

let g:ycm_confirm_extra_conf = 0
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.elm = ['.']

" FZF helpers
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

" Navigating errors
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)

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
