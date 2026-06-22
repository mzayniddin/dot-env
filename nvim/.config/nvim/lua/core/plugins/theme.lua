return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Load before all other start plugins so highlights are set first.
    lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        -- Enable integrations so catppuccin owns these plugins' highlight groups.
        -- Without these, the plugins set their own default colors at startup and
        -- the statusline / some UI elements look slightly off until re-applied.
        integrations = {
          mini = { enabled = true },
          gitsigns = true,
          neotree = true,
          alpha = true,
          indent_blankline = { enabled = true },
          telescope = { enabled = true },
          which_key = true,
          native_lsp = { enabled = true },
          treesitter = true,
          cmp = true,
          mason = true,
        },
      }
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = true },
        },
      }
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require 'alpha.themes.startify'

      startify.section.header.val = {

        [[                                                                             ]],
        [[                                                                             ]],
        [[                                                                             ]],
        [[         ████ ██████           █████      ██                         ]],
        [[        ███████████             █████                                 ]],
        [[        █████████ ███████████████████ ███   ███████████       ]],
        [[       █████████  ███    █████████████ █████ ██████████████       ]],
        [[      █████████ ██████████ █████████ █████ █████ ████ █████       ]],
        [[    ███████████ ███    ███ █████████ █████ █████ ████ █████      ]],
        [[   ██████  █████████████████████ ████ █████ █████ ████ ██████     ]],
        [[                                                                             ]],
        [[                                                                             ]],
      }

      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = 'devicons'
      require('alpha').setup(startify.config)
    end,
  },
}
