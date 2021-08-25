local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
cmp.setup {
  completion = {
    keyword_length = 2
  },

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t('<C-n>'), 'n')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'))
        else
          fallback()
        end
      end,
      { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t('<C-p>'), 'n')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)'))
        else
          fallback()
        end
      end,
      { 'i', 's' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  sources = {
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },

  sorting = {
    priority_weight = 10
  },
}
