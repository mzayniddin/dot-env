return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '▏', -- Thinner line for less distraction. other: "│", "▏", "┊"
        tab_char = '→', -- Distinct marker for tabs if you mix tabs and spaces
      },
      scope = {
        enabled = true, -- Highlight current scope
        show_start = true, -- Mark the start of the scope
        show_end = false, -- Avoid marking the end
        highlight = 'Comment', -- Use a subtle highlight group (e.g., greyed-out)
      },
      whitespace = {
        remove_blankline_trail = true, -- Cleans up trailing whitespace on blank lines
      },
    },
  },
}
