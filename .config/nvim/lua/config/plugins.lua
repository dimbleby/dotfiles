-- Plugin management via Nvim's built-in vim.pack (see :h vim.pack).
--
-- Layout:
--   1. Install/update hooks (must be registered before the add() calls they
--      apply to, so they also fire on a fresh machine bootstrapping from the
--      lockfile).
--   2. Eager plugins: installed and configured immediately at startup.
--   3. Lazy plugins: added+configured only once actually needed, to keep
--      startup fast. vim.pack has no built-in event/ft/cmd triggers (unlike
--      lazy.nvim), so these are hand-rolled with autocmds/vim.schedule().

local M = {}

local add = vim.pack.add

local function once(event, pattern, callback)
  vim.api.nvim_create_autocmd(event, { pattern = pattern, once = true, callback = callback })
end

-- Install/update hooks -------------------------------------------------

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    elseif name == 'peek.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'deno', 'task', '--quiet', 'build:fast' }, { cwd = ev.data.path }):wait()
    end
  end,
})

-- Eager plugins ----------------------------------------------------------

-- Colours - needed before first draw.
add({ 'https://github.com/ellisonleao/gruvbox.nvim' })
require('gruvbox').setup({ transparent_mode = true })
vim.cmd.colorscheme('gruvbox')

-- Language-specific highlighting and suchlike.
add({
  'https://github.com/dimbleby/vim-minizinc',
  'https://github.com/dimbleby/vim-p4-syntax',
  'https://github.com/mustache/vim-mustache-handlebars',
  'https://github.com/carlsmedstad/vim-bicep',
  'https://github.com/glench/vim-jinja2-syntax',
  'https://github.com/rust-lang/rust.vim',
  'https://github.com/nathanalderson/yang.vim',
  'https://github.com/towolf/vim-helm',
})

-- Linting
add({ 'https://github.com/mfussenegger/nvim-lint' })
require('lint').linters_by_ft = {
  dockerfile = { 'hadolint' },
  python = { 'ruff' },
  sh = { 'shellcheck' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
}

-- Language Server. cmp-nvim-lsp is needed immediately for capabilities(),
-- so it's added here eagerly rather than with the rest of nvim-cmp below.
add({
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/neovim/nvim-lspconfig',
})
require('config.lsp')

-- Treesitter
add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })
require('config.treesitter')

-- Miscellany
add({ 'https://github.com/machakann/vim-sandwich' })

-- Lazy plugins -------------------------------------------------------------

-- Completions, snippets and Copilot: defer until first insert.
once('InsertEnter', nil, function()
  add({
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/vim-vsnip',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-vsnip',
    'https://github.com/zbirenbaum/copilot.lua',
  })
  require('copilot').setup({
    suggestion = {
      auto_trigger = true,
      keymap = { accept = false },
    },
  })
  require('config.completion')
end)

-- Treesitter textobjects: defer until a real file buffer is read.
once('BufReadPost', nil, function()
  add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } })
  require('config.textobjects')
end)

-- Status line: defer past startup/first draw.
vim.schedule(function()
  add({ 'https://github.com/nvim-lualine/lualine.nvim' })
  require('lualine').setup({
    options = {
      icons_enabled = false,
      theme = 'gruvbox',
    },
  })
end)

-- Git integration: defer past startup/first draw.
vim.schedule(function()
  add({ 'https://github.com/tpope/vim-fugitive' })
end)

-- Markdown preview: only needed for markdown buffers.
once('FileType', 'markdown', function()
  add({ 'https://github.com/toppair/peek.nvim' })
  local app = 'browser'
  if vim.fn.executable('wslview') == 1 then
    app = 'wslview'
  end
  require('peek').setup({ app = app })
end)

-- Fuzzy finder: defer until first actually invoked from a keymap (see
-- mappings.lua), since it costs ~10ms to load and isn't needed for every
-- session/buffer.
local fzf_lua_loaded = false
function M.load_fzf_lua()
  if fzf_lua_loaded then
    return
  end
  fzf_lua_loaded = true
  add({ 'https://github.com/ibhagwan/fzf-lua' })
  require('fzf-lua').setup({
    keymap = {
      fzf = {
        ['CTRL-Q'] = 'select-all+accept',
      },
    },
  })
end

return M
