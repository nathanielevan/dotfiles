return {
  'nvim-tree/nvim-tree.lua',
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  init = function()
    require('core.keymaps').nvimtree()
  end,
  opts = {
    -- these options and more are documented in `:help nvim-tree.OPTION_NAME`
    -- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
    view = {
      adaptive_size = false,
      width = 30,
      side = "left",
      signcolumn = "yes",
    },
    renderer = {
      highlight_opened_files = "name",
      indent_markers = {
        enable = true,
      },
      icons = {
        symlink_arrow = " ➛ ",
        show = {
          file = false,
          folder = false,
          folder_arrow = false,
          git = false,
        },
      },
    },
    git = {
      enable = false,
    },
    trash = {
      cmd = "trash-put",
    },
  },
}
