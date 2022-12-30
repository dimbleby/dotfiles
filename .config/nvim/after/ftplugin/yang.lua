vim.opt_local.textwidth = 100

if vim.fn.executable('pyang') then
  local path = vim.fn.expand('%:p:h')
  vim.opt_local.formatprg = 'pyang --path '
    .. path
    .. ' --format yang --yang-canonical --keep-comments --'
end
