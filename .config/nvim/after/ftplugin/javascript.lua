if vim.fn.executable('prettier') then
  vim.opt_local.formatprg = 'prettier --parser=babel'
end
