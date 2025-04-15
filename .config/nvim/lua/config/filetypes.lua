vim.filetype.add({
  extension = {
    sarif = 'json',
    dita = 'xml',
    ovf = 'xml',
  },
  filename = {
    ['poetry.lock'] = 'toml',
    ['svalbard.lock'] = 'toml',
    ['uv.lock'] = 'toml',
    ['Mudlark.lock'] = 'yaml',
  },
})

--- Recognise various archives
vim.api.nvim_create_augroup('ArchiveFiles', { clear = true })
vim.api.nvim_create_autocmd('BufReadCmd', {
  group = 'ArchiveFiles',
  pattern = {'*.nupkg'},
  command = "call zip#Browse(expand('<amatch>'))",
})
vim.api.nvim_create_autocmd('BufReadCmd', {
  group = 'ArchiveFiles',
  pattern = '*.ova',
  command = "call tar#Browse(expand('<amatch>'))",
})
