vim.bo.textwidth = 100

if vim.fn.executable('prettier') then
  vim.bo.formatprg = 'prettier --parser=yaml --prose-wrap=always --print-width=100'
end
