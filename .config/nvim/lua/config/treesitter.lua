-- Auto-install parsers on demand and enable treesitter features
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    if ft == '' then
      return
    end

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
      return
    end

    -- Install parser if not already available
    if not vim.treesitter.language.add(lang) then
      local ok, ts = pcall(require, 'nvim-treesitter')
      if ok then
        local available = vim.g.ts_available or ts.get_available()
        if not vim.g.ts_available then
          vim.g.ts_available = available
        end
        if vim.tbl_contains(available, lang) then
          ts.install(lang)
        end
      end
    end

    -- Enable treesitter features if parser is available
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(buf, lang)
      if vim.treesitter.query.get(lang, 'folds') then
        local win = vim.api.nvim_get_current_win()
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[win].foldmethod = 'expr'
          end
        end)
      end

      -- Only set treesitter indent when an indent query exists for the language;
      -- otherwise leave Vim's built-in indent in place.
      if vim.treesitter.query.get(lang, 'indents') then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      -- Incremental selection: <CR> to init/expand, <BS> to shrink
      local bufopts = { buffer = buf, remap = true }
      vim.keymap.set('n', '<CR>', 'van', vim.tbl_extend('force', bufopts, { desc = 'Start incremental selection' }))
      vim.keymap.set('x', '<CR>', 'an', vim.tbl_extend('force', bufopts, { desc = 'Expand to parent node' }))
      vim.keymap.set('x', '<BS>', 'in', vim.tbl_extend('force', bufopts, { desc = 'Shrink to child node' }))
    end
  end,
})
