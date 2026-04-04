local M = {}

-- Format the whole file using the formatprg.
-- Improves on gggqG by preserving the view and being undo-friendly.
function M.format_file()
  local view = vim.fn.winsaveview()
  -- Create an undo point.
  vim.cmd.normal({ 'ix', bang = true })
  vim.cmd.normal({ '"_x', bang = true })
  local tmpfile = vim.fn.tempname()
  local shellredir_save = vim.o.shellredir
  vim.o.shellredir = '>%s 2>' .. tmpfile
  vim.cmd('silent execute "%!" . &l:formatprg')
  vim.o.shellredir = shellredir_save
  if vim.v.shell_error ~= 0 then
    vim.cmd('silent undo')
    local output = vim.fn.readfile(tmpfile)
    vim.api.nvim_echo({ { table.concat(output, '\n') } }, false, {})
  end
  vim.fn.delete(tmpfile)
  vim.fn.winrestview(view)
end

-- Trim trailing whitespace, and trailing blank lines.
function M.trim_whitespace()
  local view = vim.fn.winsaveview()
  vim.cmd([[keepjumps keeppatterns %s/\s\+$//e]])
  vim.cmd([[keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d]])
  vim.fn.winrestview(view)
end

return M
