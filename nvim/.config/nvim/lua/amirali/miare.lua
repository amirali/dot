if vim.fn.getcwd() == vim.fn.expand('~').."/src/miare/django" then
  print "inside miare/django"
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.py"},
    callback = function(ev)
      require('yapf').format()
    end,
  })
  -- add nearest test
  vim.api.nvim_create_user_command(
    'TestFile',
    function (opts)
      vim.cmd("tabnew term://" .. vim.env.VIRTUAL_ENV .. "/bin/python manage.py test --keepdb -s " .. vim.fn.bufname('%'))
    end,
    {}
  )
end
