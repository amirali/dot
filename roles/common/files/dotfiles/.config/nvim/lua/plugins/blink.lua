return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
    'nvim-tree/nvim-web-devicons',
    'onsails/lspkind.nvim',
    'xzbdmw/colorful-menu.nvim',
  },

  -- use a release tag to download pre-built binaries
  version = '2.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    signature = { enabled = true },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = true,
      kind_icons = {
        -- different icons of the corresponding source
        Text = '󰦨', -- `buffer`
        Snippet = '󰞘', -- `snippets`
        File = '', -- `path`
        Folder = '󰉋',
        Method = '󰊕',
        Function = '󰡱',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰀫',
        Class = '󰜁',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Color = '󰏘',
        Reference = '',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰅲',
      },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = { auto_show = false },
      menu = {
        -- draw = {
        --   components = {
        --     kind_icon = {
        --       text = function(ctx)
        --         local icon = ctx.kind_icon
        --         if vim.tbl_contains({ 'Path' }, ctx.source_name) then
        --           local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
        --           if dev_icon then
        --             icon = dev_icon
        --           end
        --         else
        --           icon = require('lspkind').symbolic(ctx.kind, {
        --             mode = 'symbol',
        --           })
        --         end
        --
        --         return icon .. ctx.icon_gap
        --       end,
        --
        --       -- Optionally, use the highlight groups from nvim-web-devicons
        --       -- You can also add the same function for `kind.highlight` if you want to
        --       -- keep the highlight groups in sync with the icons.
        --       highlight = function(ctx)
        --         local hl = ctx.kind_hl
        --         if vim.tbl_contains({ 'Path' }, ctx.source_name) then
        --           local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
        --           if dev_icon then
        --             hl = dev_hl
        --           end
        --         end
        --         return hl
        --       end,
        --     },
        --   },
        -- },
        border = {
          -- { '┏', 'FloatBorder' },
          -- { '━', 'FloatBorder' },
          -- { '┓', 'FloatBorder' },
          -- { '┃', 'FloatBorder' },
          -- { '┛', 'FloatBorder' },
          -- { '━', 'FloatBorder' },
          -- { '┗', 'FloatBorder' },
          -- { '┃', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
          { '', 'FloatBorder' },
        },
        draw = {
          padding = 1,
          gap = 2,
          columns = { { 'kind_icon' }, { 'label', 'kind', gap = 2 } },
          components = {
            label = {
              width = { fill = true },
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
            label_description = { width = { fill = true } },
            kind_icon = {
              text = function(ctx)
                local MiniIcons = require 'mini.icons'
                local source = ctx.item.source_name
                local label = ctx.item.label
                local icon = source == 'LSP' and MiniIcons.get('lsp', ctx.kind)
                  or source == 'copilot' and MiniIcons.get('filetype', source)
                  or source == 'Path' and (label:match '%.[^/]+$' and MiniIcons.get('file', label) or MiniIcons.get(
                    'directory',
                    ctx.item.label
                  ))
                  or ctx.kind_icon

                return icon .. ' '
              end,
            },
          },
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      per_filetype = {
        sql = { 'snippets', 'dadbod', 'buffer' },
      },
      -- add vim-dadbod-completion to your completion providers
      providers = {
        lsp = {
          name = 'lsp',
        },
        dadbod = { name = 'dadbod', module = 'vim_dadbod_completion.blink' },
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          score_offset = 100,
          async = true,
          opts = {
            kind_icon = ' ', ---@type string | false
          },
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
