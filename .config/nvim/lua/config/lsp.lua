vim.lsp.set_log_level("OFF")

local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set(
    'n',
    '<C-]>',
    function()
      require('fzf-lua').lsp_definitions({jump_to_single_result = true})
    end,
    opts
  )
  vim.keymap.set('n', '<LocalLeader>t', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set(
    'n',
    '<LocalLeader>i',
    function()
      require('fzf-lua').lsp_implementations({jump_to_single_result = true})
    end,
    opts
  )
  vim.keymap.set('n', '<LocalLeader>n', vim.lsp.buf.rename, opts)
  vim.keymap.set(
    'n',
    '<LocalLeader>r',
    function()
      require('fzf-lua').lsp_references({jump_to_single_result = true})
    end,
    opts
  )
  vim.keymap.set({'n', 'v'}, '<LocalLeader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set(
    'n',
    '<LocalLeader>s',
    require('fzf-lua').lsp_live_workspace_symbols,
    opts
  )
end

local lspconfig = require('lspconfig')
capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.util.default_config = vim.tbl_deep_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities,
    on_attach = on_attach
  }
)

lspconfig.clangd.setup{}

lspconfig.gopls.setup {
  settings = {
    ["gopls"] = {
      usePlaceholders = true
    }
  }
}

lspconfig.jedi_language_server.setup{}

lspconfig.rust_analyzer.setup{}

lspconfig.terraformls.setup {
  root_dir = lspconfig.util.root_pattern(".terraform", "terraform.tfvars", ".git");
}

local configs = require('lspconfig.configs')
if not configs.yang_language_server then
  configs.yang_language_server = {
    default_config = {
      cmd = {'yang-language-server'},
      filetypes = {'yang'},
      root_dir = lspconfig.util.root_pattern("yang.settings", ".git"),
      settings = {},
    };
  }
end
lspconfig.yang_language_server.setup{}
