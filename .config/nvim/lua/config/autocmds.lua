--- Recognise various archives
vim.api.nvim_create_augroup("ArchiveFiles", { clear = true})
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = "ArchiveFiles",
  pattern = "*.whl",
  command = "call zip#Browse(expand('<amatch>'))"
})
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = "ArchiveFiles",
  pattern = "*.ova",
  command = "call tar#Browse(expand('<amatch>'))"
})

-- Open terminal in insert mode {{{2
vim.api.nvim_create_augroup("OpenTerminal", { clear = true})
vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  group = "OpenTerminal",
  pattern = "term://*",
  command = "startinsert"
})

vim.api.nvim_create_augroup("Linting", { clear = true})
vim.api.nvim_create_autocmd({ "BufWritePost", "FileType" }, {
  group = "Linting",
  pattern = "*",
  callback = function(ev) require("lint").try_lint() end
})

vim.api.nvim_create_augroup("Whitespace", { clear = true})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "Whitespace",
  pattern = "*",
  command = "if !&binary | call format#TrimWhitespace() | endif"
})
