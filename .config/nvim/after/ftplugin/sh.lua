vim.bo.textwidth = 100
if vim.fn.executable('shfmt') then
  vim.bo.formatprg = 'shfmt -i 2 -sr -ci'
end

-- Via tpope/vim-apathy
vim.bo.include = '^\\s*\\%(\\.\\|source\\)\\s'
vim.bo.define = '\\<\\%(\\i\\+\\s*()\\)\\@='

require('utils.linting').set_up_linting()
