vim.opt_local.expandtab = false
if vim.fn.executable('gofumpt') == 1 then
  vim.opt_local.formatprg = 'gofumpt'
elseif vim.fn.executable('gofmt') == 1 then
  vim.opt_local.formatprg = 'gofmt'
end
