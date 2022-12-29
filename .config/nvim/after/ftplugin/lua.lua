if vim.fn.executable('stylua') then
  vim.bo.formatprg = 'stylua --stdin-filepath % --search-parent-directories -'
end
