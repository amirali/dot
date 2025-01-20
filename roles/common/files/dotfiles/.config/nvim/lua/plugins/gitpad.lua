return {
  'yujinyuz/gitpad.nvim',
  opts = {
    on_attach = function(bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>wq<CR>', { noremap = true, silent = true })
    end,
    floating_win_opts = {
      relative = 'editor',
      style = '',
      border = 'single',
      focusable = true,
    },
  },
  keys = {
    {
      '<leader>pp',
      function()
        require('gitpad').toggle_gitpad() -- or require('gitpad').toggle_gitpad({ title = 'Project notes' })
      end,
      desc = 'gitpad project',
    },
    {
      '<leader>pb',
      function()
        require('gitpad').toggle_gitpad_branch() -- or require('gitpad').toggle_gitpad_branch({ title = 'Branch notes' })
      end,
      desc = 'gitpad branch',
    },
  },
}
