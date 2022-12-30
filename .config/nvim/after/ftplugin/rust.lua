if vim.fn.executable('rustfmt') then
  vim.opt_local.formatprg = 'rustfmt --edition 2018 --color never --emit stdout'
end
