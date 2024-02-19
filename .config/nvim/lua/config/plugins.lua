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
  { 'nathanalderson/yang.vim', branch = 'main', ft = 'yang' },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint' },
        python = { 'flake8', 'mypy', 'ruff' },
        sh = { 'shellcheck' },
        vim = { 'vint' },
        yaml = { 'yamllint' },
      }
    end,
  },

  -- Copilot
  { 'github/copilot.vim' },

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
      require('peek').setup({
        app = 'browser',
      })
    end,
  },

  -- Miscellany
  { 'elihunter173/dirbuf.nvim' },
  { 'machakann/vim-sandwich' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
}
