return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    require('neogit').setup {}
  end,

  tag = 'v2.0.0',

  keys = {
    { '<leader>g', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
  },
}
