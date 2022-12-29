-- Weird textwidth to make room for boxed comments.
vim.bo.textwidth = 76
vim.wo.colorcolumn = '80'

if vim.fn.executable('clang-format') then
  vim.bo.formatprg = 'clang-format -assume-filename=%'
end

-- Align function parameters, in idiosyncratic style.
vim.keymap.set({ 'n', 'x' }, '<LocalLeader>=', function()
  return vim.api.nvim_eval('alignParams#AlignParams()')
end, { noremap = true, silent = true, buffer = true, expr = true })

vim.keymap.set('n', '<LocalLeader>==', function()
  return vim.api.nvim_eval('alignParams#AlignParams()') .. '_'
end, { noremap = true, silent = true, buffer = true, expr = true })

-- Boxed comments.
vim.keymap.set(
  'n',
  '<LocalLeader>w',
  '<Cmd>BlockFormat<CR>',
  { noremap = true, silent = true, buffer = true }
)
