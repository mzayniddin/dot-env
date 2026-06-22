return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- The actively developed rewrite. Uses a different API than the legacy `master` branch.
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- Parsers to keep installed. `ts.install` fetches any that are missing,
    -- and the `build = ':TSUpdate'` step keeps them up to date on plugin update.
    -- (On the `main` branch there is no `ensure_installed`/`auto_install` option.)
    ts.install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'javascript',
      'tsx',
      'typescript',
      'css',
      'glsl',
      'hlsl',
      'wgsl',
    }

    -- Filetypes that should NOT use the treesitter indentexpr
    -- (Ruby's indentation relies on Vim's regex engine).
    local indent_disable = { ruby = true }

    -- Enable highlighting + indentation for any buffer whose filetype has a
    -- parser available. This replaces the old `master`-branch `highlight` and
    -- `indent` opts, which the `main` branch ignores.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end
        -- Only start when a parser is actually installed/available.
        if not pcall(vim.treesitter.start, args.buf, lang) then
          return
        end
        if not indent_disable[ft] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
