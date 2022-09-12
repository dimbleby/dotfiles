vim.lsp.set_log_level("OFF")

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  local telescope_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<C-]>', telescope_builtin.lsp_definitions, opts)
  vim.keymap.set('n', '<LocalLeader>t', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<LocalLeader>i', telescope_builtin.lsp_implementations, opts)
  vim.keymap.set('n', '<LocalLeader>n', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<LocalLeader>r', telescope_builtin.lsp_references, opts)
  vim.keymap.set({'n', 'v'}, '<LocalLeader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<LocalLeader>s', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
end

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities,
    flags = {
      exit_timeout = false,
    },
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
