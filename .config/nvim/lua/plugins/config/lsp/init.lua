local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

require('plugins.config.lsp.handlers').setup()

local servers = { "lua_ls", "clangd", "dartls" }

for _, server in pairs(servers) do
    local opts = {
        on_attach = require('plugins.config.lsp.handlers').on_attach,
        capabilities = require('plugins.config.lsp.handlers').capabilities(),
    }
    local has_server_opts, server_opts = pcall(require, "plugins.config.lsp.servers." .. server)
    if has_server_opts then
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end
    lspconfig[server].setup(opts)
end
