vim.opt_local.textwidth = 88
vim.opt_local.foldmethod = 'indent'

local formatprgs = {}
if vim.fn.executable('isort') then
  table.insert(formatprgs, 'isort --quiet -')
end
if vim.fn.executable('black') then
  table.insert(formatprgs, 'black --quiet -')
end
vim.opt_local.formatprg = table.concat(formatprgs, '|')

require('utils.linting').set_up_linting()
