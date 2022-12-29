vim.g.textobj_sandwich_no_default_key_mappings = 1
require('config.options')
require('config.lazy')
require('config.autocmds')
require('filetypes')

vim.diagnostic.config({ virtual_text = false })
vim.g.vsnip_snippet_dir = vim.env.HOME .. '/.config/nvim/vsnip'

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('config.mappings')
  end,
})
