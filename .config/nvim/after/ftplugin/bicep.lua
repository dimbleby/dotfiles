vim.keymap.set('n', '<Leader>q', function()
  return vim.lsp.buf.format()
end, { silent = true, buffer = true })
