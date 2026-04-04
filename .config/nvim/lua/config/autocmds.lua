vim.api.nvim_create_augroup('OpenTerminal', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, {
  group = 'OpenTerminal',
  pattern = 'term://*',
  command = 'startinsert',
})

vim.api.nvim_create_augroup('Whitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Whitespace',
  callback = function()
    if not vim.bo.binary then
      require('utils.format').trim_whitespace()
    end
  end,
})

vim.api.nvim_create_augroup('Lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'Lsp',
  callback = function(args)
    require('config.mappings').lsp_mappings(args.buf)
  end,
})
