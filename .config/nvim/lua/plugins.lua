return require('packer').startup({
  function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim'

    -- Colours
    use 'lifepillar/vim-gruvbox8'

    -- Language-specific highlighting and suchlike
    -- use 'pearofducks/ansible-vim'
    -- use 'ElmCast/elm-vim'
    -- use 'dimbleby/vim-minizinc'
    -- use 'dimbleby/vim-p4-syntax'
    use 'rust-lang/rust.vim'
    use 'hashivim/vim-terraform'
    use { 'nathanalderson/yang.vim', branch = 'main' }

    -- Linting
    use {
      'mfussenegger/nvim-lint',
      config = function()
        require('lint').linters_by_ft = {
          sh = {'shellcheck'},
          dockerfile = {'hadolint'},
          python = {'flake8', 'mypy'},
          vim = {'vint'},
          yaml = {'yamllint'},
        }
      end
    }

    -- Language Server
    use {
      'neovim/nvim-lspconfig',
      after = 'cmp-nvim-lsp',
      ft = {'c', 'cpp', 'go', 'python', 'rust', 'terraform', 'yang'},
      config = [[require('lsp')]]
    }

    -- Treesitter
    use {
      {
        'nvim-treesitter/nvim-treesitter',
        config = [[require('treesitter-config')]],
        run = ':TSUpdate'
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects'
      }
    }

    -- Completions and snippets
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/vim-vsnip',
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-vsnip', after = { 'nvim-cmp', 'vim-vsnip' } }
      },
      config = [[require('completion')]],
    }

    -- Block formatting, IPS trace navigation
    -- use 'https://git.datcon.co.uk/dch/BlockFormat.git'
    -- use 'https://git.datcon.co.uk/dch/vimips.git'

    -- Status line
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = false,
            theme = 'gruvbox'
          }
        }
      end
    }

    -- Fuzzy finder
    use {
      {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
          'telescope-fzf-native.nvim',
        },
        config = function()
          local telescope = require('telescope')
          telescope.setup {}
          telescope.load_extension('fzf')
        end
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      }
    }

    -- Markdown preview
    use {
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
      run = 'cd app && yarn install'
    }

    -- Miscellany
    use 'justinmk/vim-dirvish'
    use 'machakann/vim-sandwich'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
  end,
  config = {
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
})
