local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    return
end

luasnip.config.set_config {
    history = true,
    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
}

require("luasnip.loaders.from_vscode").lazy_load()
