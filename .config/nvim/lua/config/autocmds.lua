-- Open terminal in insert mode {{{2
vim.api.nvim_create_augroup('OpenTerminal', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, {
  group = 'OpenTerminal',
  pattern = 'term://*',
  command = 'startinsert',
})

vim.api.nvim_create_augroup('Whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Whitespace',
  pattern = '*',
  command = 'if !&binary | call format#TrimWhitespace() | endif',
})
