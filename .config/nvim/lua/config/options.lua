vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.complete:remove("i")
vim.opt.completeopt = "menuone,noselect"
vim.opt.dictionary = "/usr/share/dict/words"
vim.opt.display:append { "lastline" }
vim.opt.diffopt:append { "algorithm:histogram,indent-heuristic,linematch:60,vertical" }
vim.opt.foldlevelstart = 99
vim.opt.hidden = false
vim.opt.history = 10000
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.jumpoptions = "stack"
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "> ",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "+"
}
vim.opt.mouse = ""
vim.opt.modeline = false
vim.opt.nrformats:remove("octal")
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.sidescroll = 1
vim.opt.sessionoptions:remove("options")
vim.opt.shortmess:append("c")
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabpagemax = 50
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.shiftround = true
vim.opt.formatlistpat = "^\\s*[-*+]\\s\\+"
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("croqnlj")

vim.api.nvim_set_var("c_space_errors", 1)
vim.api.nvim_set_var("c_syntax_for_h", 1)

vim.g.pyindent_open_paren = '&sw'

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- Consider a crontab entry like this:
-- 0 0 * * *   find ~/.local/share/nvim/backup -not -newerat "1 month ago" -type f -delete
vim.opt.backup = true
vim.opt.backupdir = "~/.local/share/nvim/backup"

-- Treesitter folding by default
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.mapleader = " "
