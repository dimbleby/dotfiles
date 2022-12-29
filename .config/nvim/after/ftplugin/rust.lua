if vim.fn.executable('rustfmt') then
  vim.bo.formatprg = 'rustfmt --edition 2018 --color never --emit stdout'
end
