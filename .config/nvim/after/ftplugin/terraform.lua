vim.bo.textwidth = 100

if vim.fn.executable('terraform') then
  vim.bo.formatprg = 'terraform fmt -no-color -'
end
