local status_ok, nvim_lsp_inst = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

nvim_lsp_inst.setup {
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

