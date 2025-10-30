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

-- Open the URL under the cursor in a browser
vim.keymap.set('n', 'gx', "<Cmd>call jobstart(['xdg-open', expand('<cfile>')])<CR>")

-- Mappings for vim-sandwich
vim.keymap.set({ 'n', 'x' }, 's', '<nop>')
vim.keymap.set({ 'o', 'x' }, 'iq', '<Plug>(textobj-sandwich-query-i)')
vim.keymap.set({ 'o', 'x' }, 'aq', '<Plug>(textobj-sandwich-query-a)')

function M.lsp_mappings(bufnr)
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<C-]>', function()
    require('fzf-lua').lsp_definitions({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', '<LocalLeader>t', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<LocalLeader>i', function()
    require('fzf-lua').lsp_implementations({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', '<LocalLeader>n', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LocalLeader>r', function()
    require('fzf-lua').lsp_references({ jump1 = true })
  end, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<LocalLeader>s', function()
    require('fzf-lua').lsp_live_workspace_symbols()
  end, bufopts)
end

return M
