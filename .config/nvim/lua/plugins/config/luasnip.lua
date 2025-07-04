return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  dependencies = 'rafamadriz/friendly-snippets',
  opts = {
    history = true,
    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
  },
  config = function(_, opts)
    require('luasnip').setup(opts)
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
