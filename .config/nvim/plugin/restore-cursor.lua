local ignore_buftype = { 'quickfix', 'nofile', 'help' }
local ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }

local function set_cursor()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    return
  end

  local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
  local line_count = vim.api.nvim_buf_line_count(0)

  if row > 0 and row <= line_count then
    vim.api.nvim_win_set_cursor(0, { row, column })
  end
end

vim.api.nvim_create_augroup('RestoreCursor', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = 'RestoreCursor',
  callback = set_cursor,
})
