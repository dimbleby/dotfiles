local M = {}

-- fzf-lua is lazy-loaded (see config.plugins); ensure it's added before use.
local function fzf_lua()
  require('config.plugins').load_fzf_lua()
  return require('fzf-lua')
end

-- Avoid Ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })

-- Searching
vim.keymap.set('n', '<Leader>b', function()
  fzf_lua().buffers()
end)
vim.keymap.set('n', '<Leader>f', function()
  fzf_lua().files()
end)
vim.keymap.set('n', '<Leader>h', function()
  fzf_lua().oldfiles()
end)
vim.keymap.set('n', '<Leader>r', function()
  fzf_lua().live_grep_native()
end)
vim.keymap.set('n', '<Leader>g', function()
  fzf_lua().grep_cword()
end)

-- Formatting the whole file
vim.keymap.set('n', '<Leader>q', function()
  require('utils.format').format_file()
end)

-- Mappings for vim-sandwich
vim.keymap.set({ 'n', 'x' }, 's', '<nop>')
vim.keymap.set({ 'o', 'x' }, 'iq', '<Plug>(textobj-sandwich-query-i)')
vim.keymap.set({ 'o', 'x' }, 'aq', '<Plug>(textobj-sandwich-query-a)')

function M.lsp_mappings(bufnr)
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<C-]>', function()
    fzf_lua().lsp_definitions({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', 'grr', function()
    fzf_lua().lsp_references({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', 'gri', function()
    fzf_lua().lsp_implementations({ jump1 = true })
  end, bufopts)
end

return M
