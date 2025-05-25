return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = {
        ['https://json.schemastore.org/clang-format.json'] = '/.clang-format',
        ['https://json.schemastore.org/dependabot-2.0.json'] = '/.github/dependabot.{yaml,yml}',
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '/.gitlab-ci.{yaml,yml}',
        ['https://json.schemastore.org/pre-commit-config.json'] = '/.pre-commit-config.{yaml,yml}',
        ['https://json.schemastore.org/pre-commit-hooks.json'] = '/.pre-commit-hooks.{yaml,yml}',
      },
    },
  },
}
