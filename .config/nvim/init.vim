" Prelude {{{1
scriptencoding utf-8

" Preferences {{{1
" Defaults {{{2
set autoread
set background=dark
set complete-=i
set completeopt=menuone,noselect
set dictionary=/usr/share/dict/words
set display+=lastline
set diffopt+=vertical
set diffopt+=algorithm:histogram,indent-heuristic
set foldlevelstart=99
set nohidden
set history=10000
set inccommand=nosplit
set incsearch
set jumpoptions=stack
set laststatus=2
set lazyredraw
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set mouse=
set nomodeline
set nrformats-=octal
set scrolloff=1 sidescrolloff=5 sidescroll=1
set sessionoptions-=options
set shortmess+=c
set showcmd noshowmode
set splitbelow splitright
set tabpagemax=50
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

" Recognise various archives {{{2
augroup ArchiveFiles
    autocmd!
    autocmd BufReadCmd *.whl call zip#Browse(expand("<amatch>"))
    autocmd BufReadCmd *.ova call tar#Browse(expand("<amatch>"))
augroup END

" Open terminal in insert mode {{{2
augroup OpenTerminal
    autocmd!
    autocmd TermOpen,WinEnter term://* startinsert
augroup END

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

" Configuration for lua plugins {{{2
lua require('impatient')
lua require('packer_compiled')
lua require('plugins')

" Treesitter folding by default {{{2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Colours {{{2
set termguicolors
augroup ColorOverrides
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
augroup end
let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8

" Diagnostics {{{2
lua vim.diagnostic.config({virtual_text = false})

augroup Linting
    autocmd!
    autocmd BufWritePost * lua require('lint').try_lint()
    autocmd FileType * lua require('lint').try_lint()
augroup END

" Whitespace {{{2
augroup Whitespace
    autocmd!
    autocmd BufWritePre * if !&binary | call format#TrimWhitespace() | endif
augroup END

" Snippets {{{2
let g:vsnip_snippet_dir = $HOME.'/.config/nvim/vsnip'

" Mappings {{{1
" Leader {{{2
let mapleader = "\<Space>"

" Avoid Ex mode {{{2
nnoremap Q <nop>

" Terminal mode {{{2
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>

" Searching {{{2
nnoremap <Leader>b <Cmd>Telescope buffers<CR>
nnoremap <Leader>f <Cmd>Telescope find_files<CR>
nnoremap <Leader>h <Cmd>Telescope oldfiles<CR>
nnoremap <Leader>r <Cmd>Telescope live_grep<CR>
nnoremap <Leader>g <Cmd>Telescope grep_string<CR>

" Formatting the whole file {{{2
nnoremap <silent> <Leader>q :call format#FormatFile()<CR>

" Navigating diagnostics {{{2
nnoremap <Leader>e <Cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>
nnoremap [d <Cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d <Cmd>lua vim.diagnostic.goto_next()<CR>

" Open the URL under the cursor in a browser {{{2
nnoremap gx <Cmd>call jobstart(['xdg-open', expand('<cfile>')])<CR>

" Mappings for vim-sandwich {{{2
let g:textobj_sandwich_no_default_key_mappings = 1
nmap s <Nop>
xmap s <Nop>
xmap iq <Plug>(textobj-sandwich-query-i)
omap iq <Plug>(textobj-sandwich-query-i)
xmap aq <Plug>(textobj-sandwich-query-a)
omap aq <Plug>(textobj-sandwich-query-a)
