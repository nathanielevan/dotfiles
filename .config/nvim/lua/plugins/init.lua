local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
end

vim.cmd('packadd packer.nvim')
local status_ok, packer = pcall(require, "packer")

if not status_ok then
    print "Unable to load packer"
    return
end

packer.init {
    git = {
        clone_timeout = 600,
    },
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

function lazy_load(plugin, timer)
    if plugin then
        local timer = timer or 0
        vim.defer_fn(function()
            require("packer").loader(plugin)
        end, timer)
    end
end

return packer.startup(function(use)
    use { 'lewis6991/impatient.nvim' }
    use { 'nvim-lua/plenary.nvim',
        module = 'plenary',
    }
    use { 'nathom/filetype.nvim' }
    use { 'wbthomason/packer.nvim' }
    use { 'dstein64/vim-startuptime' }
    use { 'sainnhe/gruvbox-material',
        event = "VimEnter",
        config = "require('plugins.config.gruvbox-material')",
    }
    use { 'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
    }
    use { 'nvim-treesitter/nvim-treesitter',
        event = { 'BufRead', 'BufNewFile' },
        run = ':TSUpdate',
        config = "require('plugins.config.nvim-treesitter')",
    }
    use { 'lewis6991/gitsigns.nvim',
        opt = true,
        setup = function()
            lazy_load('gitsigns.nvim')
        end,
        config = "require('plugins.config.gitsigns')",
    }
    use { 'kyazdani42/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        setup = "require('core.keymaps').nvimtree()",
        config = "require('plugins.config.nvim-tree')",
    }
    use { 'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        setup = "require('core.keymaps').telescope()",
        config = "require('plugins.config.telescope')",
    }
    use { 'goolord/alpha-nvim',
        config = "require('plugins.config.alpha-nvim')",
    }
    use { 'williamboman/mason.nvim',
        config = "require('plugins.config.lsp.mason')",
    }
    use { 'williamboman/mason-lspconfig.nvim',
        after = 'mason.nvim',
        config = "require('plugins.config.lsp.mason-lspconfig')",
    }
    use { 'neovim/nvim-lspconfig',
        after = 'mason-lspconfig.nvim',
        config = "require('plugins.config.lsp')"
    }
    use { 'rafamadriz/friendly-snippets',
        event = "InsertEnter",
    }
    use { 'hrsh7th/nvim-cmp',
        after = 'friendly-snippets',
        config = "require('plugins.config.nvim-cmp')",
    }
    use { 'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        after = 'nvim-cmp',
        config = "require('plugins.config.luasnip')",
    }
    use { 'saadparwaiz1/cmp_luasnip',
        after = 'LuaSnip',
    }
    use { 'hrsh7th/cmp-nvim-lua',
        after = 'nvim-cmp',
    }
    use { 'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp',
    }
    use { 'hrsh7th/cmp-buffer',
        after = 'nvim-cmp',
    }
    use { 'hrsh7th/cmp-path',
        after = 'nvim-cmp',
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
