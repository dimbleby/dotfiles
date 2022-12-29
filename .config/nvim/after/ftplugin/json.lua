if vim.fn.executable('prettier') then
  vim.bo.formatprg = 'prettier --parser=json-stringify'
end
