vim.lsp.set_log_level('OFF')

local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<C-]>', function()
    require('fzf-lua').lsp_definitions({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', '<LocalLeader>t', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<LocalLeader>i', function()
    require('fzf-lua').lsp_implementations({ jump1 = true })
  end, bufopts)
  vim.keymap.set('n', '<LocalLeader>n', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LocalLeader>r', function()
    require('fzf-lua').lsp_references({ jump1 = true })
  end, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<LocalLeader>s', function()
    require('fzf-lua').lsp_live_workspace_symbols()
  end, bufopts)
end

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = on_attach,
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
