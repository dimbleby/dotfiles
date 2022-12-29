vim.bo.textwidth = 100
vim.wo.foldmethod = 'indent'
if vim.fn.executable('xmllint') then
  vim.bo.formatexpr = nil
  vim.bo.formatprg = 'xmllint --format -'
end
