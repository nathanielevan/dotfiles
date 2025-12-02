return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    -- A list of parser names, or "all"
    ensure_installed = { "c_sharp", "css", "dockerfile", "html",
                         "javascript", "json", "lua", "markdown",
                         "markdown_inline", "powershell", "php",
                         "python", "scss", "sql", "typescript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of languages that will be disabled
      -- NOTE: these are the names of the parsers and not the filetype.
      disable = { "csv", "dart" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    -- Indentation based on treesitter for the `=` operator. NOTE: This is an experimental feature.
    indent = {
      enable = false,
      disable = { "" }
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
