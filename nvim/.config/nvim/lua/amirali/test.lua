require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = {'django'},
      python = "venv/bin/python",
    }),
  }
})
