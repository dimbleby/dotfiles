vim.bo.textwidth = 100

if vim.fn.executable('pyang') then
  local path = vim.fn.expand('%:p:h')
  vim.bo.formatprg = 'pyang --path ' .. path .. ' --format yang --yang-canonical --keep-comments --'
end
