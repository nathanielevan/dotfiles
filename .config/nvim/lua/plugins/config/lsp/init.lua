return {
  {
    'neovim/nvim-lspconfig',
    opts = {
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
    config = function(_, opts)
      vim.diagnostic.config(opts)

      -- See :help event-args for description of contents of
      -- the argument the callback function receives
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          require('core.keymaps').lspconfig(args.buf)
        end,
      })
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      local capabilities = require('cmp_nvim_lsp.init').default_capabilities()
      local servers = { "lua_ls", "clangd", "bashls", "pyright" }
      for _, server in pairs(servers) do
        local has_server_opts, server_opts = pcall(require, "plugins.config.lsp.servers." .. server)
        if not has_server_opts then
          server_opts = {}
        end

        -- User-defined capabilities should override default capabilities if conflicting
        server_opts = vim.tbl_deep_extend("force",
          { capabilities = vim.deepcopy(capabilities) },
          server_opts)

        -- require("lspconfig")[server].setup(server_opts) -- for nvim 0.10 and prior
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
    end,
  },
  { import = "plugins.config.lsp.mason" }
}
