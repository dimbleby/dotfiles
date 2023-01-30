-- Weird textwidth to make room for boxed comments.
vim.opt_local.textwidth = 76
vim.opt_local.colorcolumn = '80'

if vim.fn.executable('clang-format') == 1 then
  vim.opt_local.formatprg = 'clang-format -assume-filename=%'
end

-- Align function parameters, in idiosyncratic style.
vim.keymap.set({ 'n', 'x' }, '<LocalLeader>=', function()
  return vim.api.nvim_eval('alignParams#AlignParams()')
end, { silent = true, buffer = true, expr = true })

vim.keymap.set('n', '<LocalLeader>==', function()
  return vim.api.nvim_eval('alignParams#AlignParams()') .. '_'
end, { silent = true, buffer = true, expr = true })

-- Boxed comments.
vim.keymap.set('n', '<LocalLeader>w', '<Cmd>BlockFormat<CR>', { silent = true, buffer = true })
