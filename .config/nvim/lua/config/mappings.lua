-- Avoid Ex mode
vim.keymap.set('n', 'Q', '<nop>', { noremap = true })

-- Terminal mode {{{2
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })

-- Searching {{{2
vim.keymap.set('n', '<Leader>b', function()
  require('fzf-lua').buffers()
end, { noremap = true })
vim.keymap.set('n', '<Leader>f', function()
  require('fzf-lua').files()
end, { noremap = true })
vim.keymap.set('n', '<Leader>h', function()
  require('fzf-lua').oldfiles()
end, { noremap = true })
vim.keymap.set('n', '<Leader>r', function()
  require('fzf-lua').live_grep_native()
end, { noremap = true })
vim.keymap.set('n', '<Leader>g', function()
  require('fzf-lua').grep_cword()
end, { noremap = true })

-- Formatting the whole file {{{2
vim.keymap.set('n', '<Leader>q', '<Cmd>call format#FormatFile()<CR>', { noremap = true })

-- Navigating diagnostics {{{2
vim.keymap.set('n', '<Leader>e', function()
  vim.diagnostic.open_float(0, { scope = 'line' })
end, { noremap = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true })

-- Open the URL under the cursor in a browser {{{2
vim.keymap.set(
  'n',
  'gx',
  "<Cmd>call jobstart(['xdg-open', expand('<cfile>')])<CR>",
  { noremap = true }
)

-- Mappings for vim-sandwich {{{2
vim.keymap.set({ 'n', 'x' }, 's', '<nop>')
vim.keymap.set({ 'o', 'x' }, 'iq', '<Plug>(textobj-sandwich-query-i)')
vim.keymap.set({ 'o', 'x' }, 'aq', '<Plug>(textobj-sandwich-query-a)')
