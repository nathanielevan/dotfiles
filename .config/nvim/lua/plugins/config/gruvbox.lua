return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000, -- load this plugin before all the other start plugins
  opts = {
    terminal_colors = true,     -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,     -- invert background for search, diffs, statuslines and errors
    contrast = "",      -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
      StatusLine = { fg = "#282828", bg = "#a89984" },
    },
    dim_inactive = false,
    transparent_mode = true,
  },
  config = function(_, opts)
    require('gruvbox').setup(opts)
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
