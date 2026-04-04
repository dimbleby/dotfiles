vim.lsp.log.set_level('OFF')

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.enable({
  'bicep',
  'clangd',
  'gopls',
  'jsonls',
  'rust_analyzer',
  'tombi',
  'terraformls',
  'tsp_server',
  'ty',
  'yamlls',
  'yang_lsp',
})
