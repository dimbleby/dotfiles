return {
  -- Colours
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        transparent_mode = true,
      })
      vim.cmd.colorscheme('gruvbox')
    end,
  },

  -- Language-specific highlighting and suchlike
  -- { 'pearofducks/ansible-vim' },
  { 'dimbleby/vim-minizinc', ft = 'minizinc' },
  { 'dimbleby/vim-p4-syntax', ft = 'p4' },
  { 'mustache/vim-mustache-handlebars', ft = 'handlebars' },
  { 'carlsmedstad/vim-bicep', ft = 'bicep' },
  { 'glench/vim-jinja2-syntax', ft = 'jinja' },
  { 'rust-lang/rust.vim', ft = 'rust' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'nathanalderson/yang.vim', ft = 'yang' },
  { 'towolf/vim-helm', ft = 'helm' },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint' },
        python = { 'ruff', 'mypy' },
        sh = { 'shellcheck' },
        vim = { 'vint' },
        yaml = { 'yamllint' },
      }
    end,
  },

  -- Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true,
          accept = '<C-g>',
        },
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {},
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
      'CopilotChatTests',
    },
  },

  -- Language Server
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('config.treesitter')
    end,
  },

  -- Completions and snippets
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    },
    config = function()
      require('config.completion')
    end,
  },

  -- Block formatting, IPS trace navigation
  -- { 'https://git.datcon.co.uk/dch/BlockFormat.git' },
  -- { 'https://git.datcon.co.uk/dch/vimips.git' },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          theme = 'gruvbox',
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    'ibhagwan/fzf-lua',
    lazy = true,
    config = function()
      require('fzf-lua').setup({
        keymap = {
          fzf = {
            ['CTRL-Q'] = 'select-all+accept',
          },
        },
      })
    end,
  },

  -- Markdown preview
  {
    'toppair/peek.nvim',
    ft = 'markdown',
    build = 'deno task --quiet build:fast',
    config = function()
      local app = 'browser'
      if vim.fn.executable('wslview') == 1 then
        app = 'wslview'
      end
      require('peek').setup({
        app = app,
      })
    end,
  },

  -- Miscellany
  { 'elihunter173/dirbuf.nvim' },
  { 'machakann/vim-sandwich' },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
}
