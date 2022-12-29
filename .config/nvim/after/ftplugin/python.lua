vim.bo.textwidth = 88
vim.wo.foldmethod = 'indent'

local formatprgs = {}
if vim.fn.executable('isort') then
  table.insert(formatprgs, 'isort --quiet -')
end
if vim.fn.executable('black') then
  table.insert(formatprgs, 'black --quiet -')
end
vim.bo.formatprg = table.concat(formatprgs, '|')
