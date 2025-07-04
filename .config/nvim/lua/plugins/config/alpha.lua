return {
  'goolord/alpha-nvim',
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[      ___                                    ___      ]],
      [[     /__/\          ___        ___          /__/\     ]],
      [[     \  \:\        /__/\      /  /\        |  |::\    ]],
      [[      \  \:\       \  \:\    /  /:/        |  |:|:\   ]],
      [[  _____\__\:\       \  \:\  /__/::\      __|__|:|\:\  ]],
      [[ /__/::::::::\  ___  \__\:\ \__\/\:\__  /__/::::| \:\ ]],
      [[ \  \:\~~\~~\/ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/ ]],
      [[  \  \:\  ~~~  \  \:\|  |:|     \__\::/  \  \:\       ]],
      [[   \  \:\       \  \:\__|:|     /__/:/    \  \:\      ]],
      [[    \  \:\       \__\::::/      \__\/      \  \:\     ]],
      [[     \__\/           ~~~~                   \__\/     ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "New file", ":enew<CR>"),
      dashboard.button("LDR f o", "Recently opened files", ":Telescope oldfiles<CR>"),
      dashboard.button("LDR f f", "Find file", ":Telescope find_files<CR>"),
      dashboard.button("LDR f g", "Find text", ":Telescope live_grep<CR>"),
      dashboard.button("u", "Sync plugins", ":Lazy sync<CR>"),
      dashboard.button("q", "Quit", ":qa<CR>"),
    }

    local function footer()
      local plugins = require("lazy").stats().count
      local v = vim.version()
      return string.format("%d plugins installed | NVIM v%d.%d.%d", plugins, v.major, v.minor, v.patch)
    end

    dashboard.section.footer.val = footer()

    return dashboard.config
  end,
}
