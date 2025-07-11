return {
  'mfussenegger/nvim-lint',
  lazy = true,
  init = require('core.keymaps').nvimlint,
  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
  end,
}
