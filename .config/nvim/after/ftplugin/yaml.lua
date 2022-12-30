vim.opt_local.textwidth = 100

if vim.fn.executable('prettier') then
  vim.opt_local.formatprg = 'prettier --parser=yaml --prose-wrap=always --print-width=100'
end

require('utils.linting').set_up_linting()
