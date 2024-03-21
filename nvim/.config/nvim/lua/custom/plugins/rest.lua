return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    ft = 'http',
    config = function()
      require("rest-nvim").setup({
        --- Get the same options from Packer setup
     })
    end,
    tag = 'v1.2.1',
  }
}
