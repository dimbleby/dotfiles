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
      -- Only set treesitter indent when an indent query exists for the language;
      -- otherwise leave Vim's built-in indent in place.
      if vim.treesitter.query.get(lang, 'indents') then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

-- Incremental selection: <CR> to init/expand, <BS> to shrink
vim.keymap.set('n', '<CR>', 'van', { remap = true, desc = 'Start incremental selection' })
vim.keymap.set('x', '<CR>', 'an', { remap = true, desc = 'Expand to parent node' })
vim.keymap.set('x', '<BS>', 'in', { remap = true, desc = 'Shrink to child node' })
