return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    require('neogit').setup {}

    local group = vim.api.nvim_create_augroup('GitlabMR', { clear = true })

    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'NeogitPushComplete',
      callback = function()
        local branch = vim.trim(vim.fn.system 'git branch --show-current')

        if branch == 'dev' then
          return
        end

        vim.system({ 'glab', 'mr', 'view' }, { text = true }, function(view)
          local cmd

          if view.code == 0 then
            cmd = { 'glab', 'mr', 'view', '--web' }
          else
            cmd = {
              'glab',
              'mr',
              'create',
              '--target-branch',
              'dev',
              '--fill',
              '--web',
            }
          end

          vim.schedule(function()
            vim.system(cmd, { detach = true })
          end)
        end)
      end,
    })
  end,

  tag = 'v2.0.0',

  keys = {
    { '<leader>g', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
  },
}
