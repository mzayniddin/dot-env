return {
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
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
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'catppuccin'
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
