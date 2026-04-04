vim.opt_local.textwidth = 100
if vim.fn.executable('xmllint') == 1 then
  vim.opt_local.formatexpr = nil
  vim.opt_local.formatprg = 'xmllint --format -'
end
