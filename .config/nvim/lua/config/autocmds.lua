vim.api.nvim_create_augroup('OpenTerminal', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, {
  group = 'OpenTerminal',
  pattern = 'term://*',
  command = 'startinsert',
})

vim.api.nvim_create_augroup('Whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Whitespace',
  command = 'if !&binary | call format#TrimWhitespace() | endif',
})

vim.api.nvim_create_augroup('Lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'Lsp',
  callback = function(args)
    require('config.mappings').lsp_mappings(args.buf)
  end,
})
