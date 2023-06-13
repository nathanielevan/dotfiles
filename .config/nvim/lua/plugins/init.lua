local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(install_path) then
    LAZY_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
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
    { 'sainnhe/gruvbox-material',
        config = function()
            require('plugins.config.gruvbox-material')
        end,
    },
    { 'nvim-tree/nvim-web-devicons',
        lazy = true,
    },
    { 'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('plugins.config.nvim-treesitter')
        end,
    },
    { 'lewis6991/gitsigns.nvim',
        config = function()
            require('plugins.config.gitsigns')
        end,
    },
    { 'nvim-tree/nvim-tree.lua',
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        dependencies = 'nvim-tree/nvim-web-devicons',
        init = function()
            require('core.keymaps').nvimtree()
        end,
        config = function()
            require('plugins.config.nvim-tree')
        end,
    },
    { 'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        dependencies = 'nvim-lua/plenary.nvim',
        init = function()
            require('core.keymaps').telescope()
        end,
        config = function()
            require('plugins.config.telescope')
        end,
    },
    { 'goolord/alpha-nvim',
        config = function()
            require('plugins.config.alpha-nvim')
        end,
    },
    { 'williamboman/mason.nvim',
        config = function()
            require('plugins.config.lsp.mason')
        end,
    },
    { 'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        config = function()
            require('plugins.config.lsp.mason-lspconfig')
        end,
    },
    { 'neovim/nvim-lspconfig',
        dependencies = 'williamboman/mason-lspconfig.nvim',
        config = function()
            require('plugins.config.lsp')
        end,
    },
    { 'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            { 'L3MON4D3/LuaSnip',
                dependencies = 'rafamadriz/friendly-snippets',
                config = function()
                    require('core.keymaps').luasnip()
                    require('plugins.config.luasnip')
                end,
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            require('plugins.config.nvim-cmp')
        end,
    },
},
{
    git = {
        timeout = 120,
    },
    ui = {
        border = "rounded",
    }
})

if LAZY_BOOTSTRAP then
    lazy.sync()
end
