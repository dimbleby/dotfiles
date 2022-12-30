local ignore_buftype = { 'quickfix', 'nofile', 'help' }
local ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    vim.cmd([[normal! gg]])
    return
  end

  -- nvim file +num
  if vim.fn.line('.') > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line('$')

  if last_line > 0 and last_line <= buff_last_line then
    vim.cmd([[normal! g`"]])
  end
end

vim.api.nvim_create_augroup('RestoreCursor', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = 'RestoreCursor',
  callback = run,
})
