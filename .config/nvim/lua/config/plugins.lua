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
  -- { 'dimbleby/vim-minizinc' },
  -- { 'dimbleby/vim-p4-syntax' },
  { 'rust-lang/rust.vim', ft = 'rust' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'nathanalderson/yang.vim', branch = 'main', ft = 'yang' },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    ft = { 'dockerfile', 'python', 'sh', 'vim', 'yaml' },
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint' },
        python = { 'flake8', 'mypy' },
        sh = { 'shellcheck' },
        vim = { 'vint' },
        yaml = { 'yamllint' },
      }
    end,
  },

  -- Language Server
  {
    'neovim/nvim-lspconfig',
    ft = { 'c', 'cpp', 'go', 'python', 'rust', 'terraform', 'yang' },
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
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && yarn install',
  },

  -- Miscellany
  { 'justinmk/vim-dirvish' },
  { 'machakann/vim-sandwich' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
}
