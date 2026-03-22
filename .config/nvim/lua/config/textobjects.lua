local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

-- Textobject selection
vim.keymap.set({ 'x', 'o' }, 'af', function()
  select.select_textobject('@function.outer', 'textobjects')
end, { desc = 'outer function' })

vim.keymap.set({ 'x', 'o' }, 'if', function()
  select.select_textobject('@function.inner', 'textobjects')
end, { desc = 'inner function' })

vim.keymap.set({ 'x', 'o' }, 'ac', function()
  select.select_textobject('@comment.outer', 'textobjects')
end, { desc = 'outer comment' })

-- Textobject movement
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'next function start' })

vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  move.goto_next_start('@class.outer', 'textobjects')
end, { desc = 'next class start' })

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  move.goto_next_end('@function.outer', 'textobjects')
end, { desc = 'next function end' })

vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  move.goto_next_end('@class.outer', 'textobjects')
end, { desc = 'next class end' })

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'prev function start' })

vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  move.goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'prev class start' })

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  move.goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'prev function end' })

vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  move.goto_previous_end('@class.outer', 'textobjects')
end, { desc = 'prev class end' })
