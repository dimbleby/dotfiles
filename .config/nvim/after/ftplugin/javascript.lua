if vim.fn.executable('prettier') == 1 then
  vim.opt_local.formatprg = 'prettier --parser=babel'
end
