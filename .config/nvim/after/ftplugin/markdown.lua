vim.wo.spell = true
vim.wo.linebreak = true
vim.bo.textwidth = 80
if vim.fn.executable('prettier') then
  vim.bo.formatprg = 'prettier --parser=markdown'
end
vim.keymap.set('n', '<LocalLeader>m', '<Cmd>MarkdownPreview<CR>', { noremap = true, buffer = true })

-- Formatting, with each new sentence on a new line.
vim.keymap.set({ 'n', 'x' }, '<LocalLeader>w', function()
  return vim.api.nvim_eval('ventilate#Ventilate()')
end, { noremap = true, silent = true, buffer = true, expr = true })

vim.keymap.set('n', '<LocalLeader>ww', function()
  return vim.api.nvim_eval('ventilate#Ventilate()') .. '_'
end, { noremap = true, silent = true, buffer = true, expr = true })
