if vim.fn.executable('stylua') then
  vim.opt_local.formatprg = 'stylua --stdin-filepath % --search-parent-directories -'
end
