vim.opt_local.textwidth = 100

if vim.fn.executable('terraform') then
  vim.opt_local.formatprg = 'terraform fmt -no-color -'
end
