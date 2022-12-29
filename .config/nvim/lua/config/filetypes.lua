vim.filetype.add({
  extension = {
    sarif = 'json',
    dita = 'xml',
    ovf = 'xml',
  },
  filename = {
    ['poetry.lock'] = 'toml',
    ['svalbard.lock'] = 'toml',
    ['Mudlark.lock'] = 'yaml',
  },
})
