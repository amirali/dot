should_attach_to_buffers = { 'gitcommit' }

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false, -- help
          auto_refresh = true,
          -- keymap = {
          --   jump_prev = '<C-p>',
          --   jump_next = '<C-n>',
          --   accept = '<C-y>',
          --   refresh = 'gr',
          --   open = '<M-CR>',
          -- },
          layout = {
            position = 'bottom', -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          -- keymap = {
          --   accept = '<C-y>',
          --   accept_word = false,
          --   accept_line = false,
          --   next = '<C-n>',
          --   prev = '<C-p>',
          --   dismiss = '<C-]>',
          -- },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        -- nes = {
        --   enabled = true, -- requires copilot-lsp as a dependency
        --   auto_trigger = false,
        --   keymap = {
        --     accept_and_goto = false,
        --     accept = '<C-\\>',
        --     dismiss = false,
        --   },
        -- },
        logger = {
          file = vim.fn.stdpath 'log' .. '/copilot-lua.log',
          file_log_level = vim.log.levels.OFF,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = 'off', -- "off" | "debug" | "verbose"
          trace_lsp_progress = false,
          log_lsp_messages = false,
        },

        copilot_node_command = '/home/amirali/.config/nvm/versions/node/v24.17.0/bin/node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
      -- { 'copilotlsp-nvim/copilot-lsp' },
    },
    build = 'make tiktoken',
    opts = {},
  },
  -- {
  --   'ray-x/copilot-agent.nvim',
  --   -- build = ':CopilotAgentInstall',
  --   opts = function()
  --     require('copilot_agent').setup {
  --       -- lsp = { enabled = true }, -- auto-starts the helper LSP from setup(); call start_lsp() only for explicit/delayed startup
  --     }
  --   end,
  -- },
}
