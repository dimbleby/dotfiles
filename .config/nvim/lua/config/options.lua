vim.opt.completeopt = 'menuone,noselect'
vim.opt.dictionary = '/usr/share/dict/words'
vim.opt.diffopt:append({ 'algorithm:histogram,vertical' })
vim.opt.foldlevelstart = 99
vim.opt.hidden = false
vim.opt.jumpoptions = 'stack'
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars:append({ extends = '>', precedes = '<' })
vim.opt.mouse = ''
vim.opt.modeline = false
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.sidescroll = 1
vim.opt.shortmess:append('c')
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.shiftround = true
vim.opt.formatlistpat = '^\\s*[-*+]\\s\\+'
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:append('ronl')

vim.g.c_space_errors = 1
vim.g.c_syntax_for_h = 1

vim.g.pyindent_open_paren = '&sw'

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

-- Consider a crontab entry like this:
-- 0 0 * * *   find ~/.local/share/nvim/backup -not -newerat "1 month ago" -type f -delete
vim.opt.backup = true
vim.opt.backupdir = vim.env.HOME .. '/.local/share/nvim/backup'

vim.g.mapleader = ' '
vim.diagnostic.config({ virtual_text = false })

vim.g.textobj_sandwich_no_default_key_mappings = 1
vim.g.vsnip_snippet_dir = vim.env.HOME .. '/.config/nvim/vsnip'
