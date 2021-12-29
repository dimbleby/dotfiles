vim.diagnostic.config({virtual_text = false})

require('lint').linters_by_ft = {
  sh = {'shellcheck'},
  dockerfile = {'hadolint'},
  python = {'flake8', 'mypy'},
  vim = {'vint'},
  yaml = {'yamllint'},
}
