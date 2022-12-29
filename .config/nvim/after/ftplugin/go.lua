vim.bo.expandtab = false
if vim.fn.executable('gofmt') then
  vim.bo.formatprg = 'gofmt'
end
