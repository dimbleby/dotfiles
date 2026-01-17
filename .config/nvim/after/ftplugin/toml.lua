if vim.fn.executable('tombi') == 1 then
  local path = vim.fn.expand('%:p:h')
  vim.opt_local.formatprg = 'tombi format --quiet --stdin-filename ' .. path .. ' -'
end
