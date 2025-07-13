return {
  'neovim/nvim-lspconfig',
  opts = {
    diagnostics = {
      virtual_text = {
        prefix = "▪",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "x",
          [vim.diagnostic.severity.HINT] = "*",
          [vim.diagnostic.severity.INFO] = "i",
          [vim.diagnostic.severity.WARN] = "!",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = false,
      float = {
        border = "rounded",
      }
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
            },
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
              checkThirdParty = false,
            },
          },
        },
      },
      clangd = {},
      bashls = {},
      pyright = {},
      -- ts_ls = {},
    },
  },
  config = function(_, opts)
    vim.diagnostic.config(opts.diagnostics)

    -- See :help event-args for description of contents of
    -- the argument the callback function receives
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        require('core.keymaps').lspconfig(args.buf)
      end,
    })
    -- local capabilities = require('blink.cmp').get_lsp_capabilities()
    local capabilities = require('cmp_nvim_lsp.init').default_capabilities()

    for server_name, server_opts in pairs(opts.servers) do
      -- User-defined capabilities should override default capabilities if conflicting
      server_opts = vim.tbl_deep_extend("force",
        { capabilities = vim.deepcopy(capabilities) },
        server_opts)
      -- require("lspconfig")[server_name].setup(server_opts) -- for nvim 0.10 and prior
      vim.lsp.config(server_name, server_opts)
      vim.lsp.enable(server_name)
    end
  end,
}
