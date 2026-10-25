return {
  'kokusenz/deltaview.nvim',
  config = function()
    require('deltaview').setup {
      -- disable nerd font icons if uninstalled (defaults to true)
      use_nerdfonts = false,

      -- will show the delta style line numbers in the statuscolumn.
      line_numbers = false,

      -- override the picker for :DeltaMenu. If nil, auto-detects in order:
      -- fzf-lua -> telescope -> vim.ui.select
      fzf_picker = nil, -- 'fzf-lua' | 'telescope' | 'ui_select' | nil

      -- custom keybindings
      keyconfig = {
        -- global keybind to toggle DeltaMenu
        dm_toggle_keybind = '<leader>dm',

        -- global keybind to toggle DeltaView (and exit diff if open)
        dv_toggle_keybind = '<leader>dl',

        -- global keybind to toggle Delta (and exit diff if open)
        d_toggle_keybind = '<leader>da',

        -- navigate between hunks in a diff
        next_hunk = '<Tab>',
        prev_hunk = '<S-Tab>',

        -- open help legend
        help_legend = 'd?',
      },
    }

    -- for configuration of how the diff buffers look
    require('delta').setup {
      -- default lines of context around each hunk.
      context = 3,

      highlighting = {
        -- minimum Levenshtein similarity (0.0–1.0) for two lines to be
        -- paired for word-level highlighting. The lower the number, the
        -- less similar two lines have to be to get word level
        -- highlighting. Matches delta's --max-line-distance option.
        max_similarity_threshold = 0.6,
      },

      -- Highlight group definitions, separated by background type.
      -- Each group accepts `fg`, `bg`, and `default` (boolean).
      -- When `default = true` the group will not override default colors
      -- To write a custom color, include default = false
      -- the examples have default = false, but the colors are the defaults
      highlight_groups = {
        dark = {
          DeltaDiffAddedLine = {
            bg = '#002800', -- dark green background
            default = false,
          },
          DeltaDiffRemovedLine = {
            bg = '#3f0001', -- dark red background
            default = false,
          },
          DeltaDiffAddedWord = {
            bg = '#006000', -- brighter green
            default = false,
          },
          DeltaDiffRemovedWord = {
            bg = '#901011', -- brighter red
            default = false,
          },
          DeltaTitle = {
            fg = '#24acd4', -- light blue
            default = false,
          },
          DeltaLineNrAdded = {
            fg = '#008400', -- darker green for added line numbers
            default = false,
          },
          DeltaLineNrRemoved = {
            fg = '#800202', -- darker red for removed line numbers
            default = false,
          },
          DeltaLineNrContext = {
            fg = '#444444', -- darker gray for context line numbers
            default = false,
          },
        },
        light = {
          DeltaDiffAddedLine = {
            bg = '#cfffd0', -- light green background
            default = false,
          },
          DeltaDiffRemovedLine = {
            bg = '#ffdee2', -- light red background
            default = false,
          },
          DeltaDiffAddedWord = {
            bg = '#9df0a2', -- darker green (word level)
            default = false,
          },
          DeltaDiffRemovedWord = {
            bg = '#ffc1bf', -- darker red (word level)
            default = false,
          },
          DeltaTitle = {
            fg = '#0088aa', -- darker blue for light backgrounds
            default = false,
          },
          DeltaLineNrAdded = {
            fg = '#008400', -- darker green for added line numbers
            default = false,
          },
          DeltaLineNrRemoved = {
            fg = '#800202', -- darker red for removed line numbers
            default = false,
          },
          DeltaLineNrContext = {
            fg = '#444444', -- darker gray for context line numbers
            default = false,
          },
        },
      },
    }
  end,
}
