if vim.fn.executable('taplo') == 1 then
  local path = vim.fn.expand('%:p:h')
  vim.opt_local.formatprg = 'taplo format --stdin-filepath '
    .. path
    .. ' --option array_auto_collapse=false --colors never -'
end
