local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap('n', '<C-]>', '<Cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>t', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>i', '<Cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>n', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>r', '<Cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<LocalLeader>a', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>s', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>e', '<Cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>', opts)
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
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
      }
      ),
    },
    on_attach = on_attach
  }
)

lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = vim.env.HOME .. '/.cache/ccls'
    },
    completion = {
      filterAndSort = false
    }
  }
}

lspconfig.gopls.setup {
  settings = {
    ["gopls"] = {
      usePlaceholders = true
    }
  }
}

lspconfig.jedi_language_server.setup{}

lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      }
    }
  }
}

lspconfig.terraformls.setup {
  root_dir = lspconfig.util.root_pattern(".terraform", "main.tf", ".git");
}

local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
if not configs.yang_language_server then
  configs.yang_language_server = {
    default_config = {
      cmd = {'yang-language-server'},
      filetypes = {'yang'},
      root_dir = util.root_pattern("yang.settings", ".git"),
      settings = {},
    };
  }
end
lspconfig.yang_language_server.setup{}
