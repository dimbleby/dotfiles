vim.opt_local.spell = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 80
if vim.fn.executable('prettier') == 1 then
  vim.opt_local.formatprg = 'prettier --parser=markdown'
end
vim.keymap.set('n', '<LocalLeader>m', '<Cmd>MarkdownPreview<CR>', { buffer = true })

-- Formatting, with each new sentence on a new line.
vim.keymap.set({ 'n', 'x' }, '<LocalLeader>w', function()
  return vim.api.nvim_eval('ventilate#Ventilate()')
end, { silent = true, buffer = true, expr = true })

vim.keymap.set('n', '<LocalLeader>ww', function()
  return vim.api.nvim_eval('ventilate#Ventilate()') .. '_'
end, { silent = true, buffer = true, expr = true })
