return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        completion = {
          completeopt = "menuone,noselect",
        },
        mapping = cmp.mapping.preset.insert(require('core.keymaps').nvimcmp()),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'nvim_lua' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        performance = {
          max_view_entries = 100,
        }
      }
    end,
  },
}
