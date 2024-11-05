return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '<C-p>',
            jump_next = '<C-n>',
            accept = '<c-y>',
            refresh = 'gr',
            open = '<M-CR>',
          },
        },
      }
    end,
  }
