vim.opt_local.textwidth = 88
vim.opt_local.foldmethod = 'indent'

local formatprgs = {}
if vim.fn.executable('ruff') == 1 then
  table.insert(formatprgs, 'ruff check --quiet --fix --stdin-filename % -')
elseif vim.fn.executable('isort') == 1 then
  table.insert(formatprgs, 'isort --quiet -')
end
if vim.fn.executable('black') == 1 then
  table.insert(formatprgs, 'black --quiet -')
elseif vim.fn.executable('ruff') == 1 then
  table.insert(formatprgs, 'ruff format --quiet --stdin-filename % -')
end
if next(formatprgs) ~= nil then
  vim.opt_local.formatprg = table.concat(formatprgs, '|')
end

require('utils.linting').set_up_linting()
