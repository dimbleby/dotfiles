local M = {}

local lint = function()
  require('lint').try_lint(nil, { ignore_errors = true })
end

function M.set_up_linting()
  vim.api.nvim_create_augroup('Linting', { clear = false })
  vim.api.nvim_clear_autocmds({ buffer = 0, group = 'Linting' })
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'Linting',
    buffer = 0,
    callback = lint,
  })
  lint()
end

return M
