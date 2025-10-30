vim.lsp.log.set_level('OFF')

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.enable({
  'bicep',
  'clangd',
  'gopls',
  'jedi_language_server',
  'jsonls',
  'rust_analyzer',
  'taplo',
  'terraformls',
  'yamlls',
  'yang_language_server',
})
