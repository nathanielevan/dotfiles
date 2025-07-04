local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(install_path) then
  LAZY_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    install_path,
  })
end

vim.opt.rtp:prepend(install_path)

local status_ok, lazy = pcall(require, "lazy")

if not status_ok then
  print "Unable to load lazy.nvim"
  return
end

lazy.setup({
  spec = {
    { import = "plugins.config" }
  },
  git = {
    timeout = 120,
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  }
})

if LAZY_BOOTSTRAP then
  lazy.sync()
end
