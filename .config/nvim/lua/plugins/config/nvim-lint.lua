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
    -- Override built-in linters or define custom linters here
    -- linters = {
    -- },
  },
  config = function(_, opts)
    local lint = require("lint")
    for linter_name, linter_opts in pairs(opts.linters) do
      lint.linters[linter_name] = vim.tbl_deep_extend("force", lint.linters[linter_name] or {}, linter_opts)
    end
    lint.linters_by_ft = opts.linters_by_ft
  end,
}
