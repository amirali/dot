return   {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]]

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'go', 'python', 'lua', 'gleam', 'javascript', 'typescript', 'markdown', 'make' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  }

