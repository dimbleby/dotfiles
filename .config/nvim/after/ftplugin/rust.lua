if vim.fn.executable('rustfmt') == 1 then
  vim.opt_local.formatprg = 'rustfmt --edition 2024 --color never --emit stdout'
end
