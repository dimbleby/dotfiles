local M = {}

-- Avoid Ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })

-- Searching
vim.keymap.set('n', '<Leader>b', function()
  require('fzf-lua').buffers()
end)
vim.keymap.set('n', '<Leader>f', function()
  require('fzf-lua').files()
end)
vim.keymap.set('n', '<Leader>h', function()
  require('fzf-lua').oldfiles()
end)
vim.keymap.set('n', '<Leader>r', function()
  require('fzf-lua').live_grep_native()
end)
vim.keymap.set('n', '<Leader>g', function()
  require('fzf-lua').grep_cword()
end)

-- Formatting the whole file
vim.keymap.set('n', '<Leader>q', '<Cmd>call format#FormatFile()<CR>')

-- Mappings for vim-sandwich
vim.keymap.set({ 'n', 'x' }, 's', '<nop>')
vim.keymap.set({ 'o', 'x' }, 'iq', '<Plug>(textobj-sandwich-query-i)')
vim.keymap.set({ 'o', 'x' }, 'aq', '<Plug>(textobj-sandwich-query-a)')

function M.lsp_mappings(bufnr)
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<C-]>', function()
    require('fzf-lua').lsp_definitions({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', 'grr', function()
    require('fzf-lua').lsp_references({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', 'gri', function()
    require('fzf-lua').lsp_implementations({ jump1 = true })
  end, bufopts)
end

return M
