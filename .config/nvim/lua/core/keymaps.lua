-- Relevant help entries:
-- :help vim.keymap for keymapping functions
-- :help :map-modes for list of modes to map keys to

-- Keybinds for switching between window splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window split" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to lower window split" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to upper window split" })
-- CTRL-l is bound to :redraw by default
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window split" })

-- Keybinds for resizing window splits
vim.keymap.set('n', '<C-A-h>', '<C-w><', { desc = "Decrease current window width" })
vim.keymap.set('n', '<C-A-j>', '<C-w>-', { desc = "Decrease current window height" })
vim.keymap.set('n', '<C-A-k>', '<C-w>+', { desc = "Increase current window height" })
vim.keymap.set('n', '<C-A-l>', '<C-w>>', { desc = "Increase current window width" })

-- Clear the last used search pattern
vim.keymap.set('n', '<C-_>', ':let @/ = ""<CR>', { silent = true, desc = "Clear last search pattern" })

-- Delete an open buffer
-- Explanation: move to a previous buffer (:bp) and delete (:bd) the buffer before (#, "alternate buffer")
vim.keymap.set('n', '<leader>dd', ':bp|bd #<CR>', { silent = true, desc = "Delete current buffer" })

-- Esc to go to normal mode from terminal mode
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { desc = "Go to normal mode" })

-- Toggle NERDTree
-- vim.api.nvim_set_keymap('n', '<leader>f', ':Lexplore<CR>', { noremap = true, silent = true })

-- Remap NetrwRefresh so it doesn't override <C-r>
-- vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>NetrwRefresh', { unique = true })

-- List buffers with <leader>b
-- vim.api.nvim_set_keymap('n', '<leader>b', ':buffers<CR>:buffer ', {})

-- Diagnostics-related keybinds (for LSP diagnostics, etc)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { silent = true, desc = "Show diagnostic in floating window" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist,
  { silent = true, desc = "Add buffer diagnostics to the location list" })
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "LSP: Move to the previous diagnostic" })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "LSP: Move to the next diagnostic" })
-- vim.diagnostic.goto_prev() and vim.diagnostic.goto_next() has been deprecated since version 0.11 (see: neovim/neovim#26745), replace with:
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -vim.v.count1, float = true }) end,
  { silent = true, desc = "Jump to previous diagnostic" })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = vim.v.count1, float = true }) end,
  { silent = true, desc = "Jump to next diagnostic" })

local M = {}

M.gitsigns = function(bufnr)
  local gitsigns = require("gitsigns")
  local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', { silent = true, buffer = bufnr }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gitsigns.nav_hunk('next')
    end
  end)
  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gitsigns.nav_hunk('prev')
    end
  end)

  -- Actions
  map('n', '<leader>hs', gitsigns.stage_hunk)
  map('n', '<leader>hr', gitsigns.reset_hunk)

  map('v', '<leader>hs', function()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end)

  map('v', '<leader>hr', function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end)

  map('n', '<leader>hS', gitsigns.stage_buffer)
  map('n', '<leader>hR', gitsigns.reset_buffer)
  map('n', '<leader>hp', gitsigns.preview_hunk)
  map('n', '<leader>hi', gitsigns.preview_hunk_inline)

  map('n', '<leader>hb', function()
    gitsigns.blame_line({ full = true })
  end)

  map('n', '<leader>hd', gitsigns.diffthis)

  map('n', '<leader>hD', function()
    gitsigns.diffthis('~')
  end)

  map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
  map('n', '<leader>hq', gitsigns.setqflist)

  -- Toggles
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  map('n', '<leader>tw', gitsigns.toggle_word_diff)

  -- Text object
  map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
end

M.nvimtree = function()
  -- we bind these keys to commands because nvim-tree
  -- is lazy-loaded to trigger through these commands
  vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { silent = true, desc = "nvim-tree: Toggle open/close" })
  vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>', { silent = true, desc = "nvim-tree: Focus window" })
  -- 'g?' to show default mappings for nvim-tree
end

M.lspconfig = function(bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', { silent = true, buffer = bufnr }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Neovim sets this option by default since v0.10.4 (see: neovim@ddd92a7)
  map('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
  map('n', 'gd', vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
  map('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Display hover information in floating window" })
  map('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP: Go to implementation" })
  map('n', '<space>sh', vim.lsp.buf.signature_help, { desc = "LSP: Displays signature information in floating window" })
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = "LSP: Add folder at path to workspace folders" })
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
    { desc = "LSP: Remove folder at path from workspace folders" })
  map('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { desc = "LSP: List workspace folders" })
  map('n', '<space>D', vim.lsp.buf.type_definition, { desc = "LSP: Jumps to definition of type" })
  map('n', '<space>rn', vim.lsp.buf.rename, { desc = "LSP: Rename all references" })
  map('n', '<space>ca', vim.lsp.buf.code_action, { desc = "LSP: Select available code action" })
  map('n', 'gr', vim.lsp.buf.references, { desc = "LSP: List all references" })
  map('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end,
    { desc = "LSP: Format buffer using attached LSP client" })
end

M.nvimcmp = function()
  local cmp = require('cmp')
  return {
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }
end

M.telescope = function()
  -- we bind these keys to commands because nvim-telescope
  -- is lazy-loaded to trigger through these commands
  vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>',
    { silent = true, desc = 'Telescope: list files in working directory' })
  vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>',
    { silent = true, desc = 'Telescope: live grep (requires ripgrep)' })
  vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true, desc = 'Telescope: list open buffers' })
  vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>',
    { silent = true, desc = 'Telescope: list previously open files' })
end

M.mason = function()
  return {
    -- Keymap to expand a package
    toggle_package_expand = "<CR>",
    -- Keymap to install the package under the current cursor position
    install_package = "i",
    -- Keymap to reinstall/update the package under the current cursor position
    update_package = "<C-u>",
    -- Keymap to check for new version for the package under the current cursor position
    check_package_version = "c",
    -- Keymap to update all installed packages
    update_all_packages = "U",
    -- Keymap to check which installed packages are outdated
    check_outdated_packages = "C",
    -- Keymap to uninstall a package
    uninstall_package = "X",
    -- Keymap to cancel a package installation
    cancel_installation = "<C-c>",
    -- Keymap to apply language filter
    apply_language_filter = "<C-f>",
  }
end

M.luasnip = function()
  local ls = require('luasnip')
  vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })
end

return M
