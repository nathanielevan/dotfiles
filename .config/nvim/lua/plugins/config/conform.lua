return {
  'stevearc/conform.nvim',
  lazy = true,
  -- event = "BufWritePre",
  cmd = "ConformInfo",
  init = require('core.keymaps').conform,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- format_on_save = {
    --   timeout_ms = 1000,
    -- },
  }
}
