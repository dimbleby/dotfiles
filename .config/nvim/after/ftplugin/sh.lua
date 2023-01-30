vim.opt_local.textwidth = 100
if vim.fn.executable('shfmt') == 1 then
  vim.opt_local.formatprg = 'shfmt -i 2 -sr -ci'
end

-- Via tpope/vim-apathy
vim.opt_local.include = '^\\s*\\%(\\.\\|source\\)\\s'
vim.opt_local.define = '\\<\\%(\\i\\+\\s*()\\)\\@='

require('utils.linting').set_up_linting()
