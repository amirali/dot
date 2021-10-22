vim.opt.list = true

local default_listchars = {
  eol = "↲",
  tab = "» ",
  trail = "·",
  extends = "<",
  precedes = ">",
  conceal = "┊",
  nbsp = "␣",
}

local yaml_listchars = {
  lead = "·",
  eol = "↲",
  tab = "» ",
  trail = "*",
  extends = "<",
  precedes = ">",
  conceal = "┊",
  nbsp = "␣",
}

vim.autocmd {
  "BufEnter",
  "*.yaml,*.yml",
  function()
    vim.opt.listchars = yaml_listchars
  end,
}

vim.autocmd {
  "BufLeave",
  "*.yaml,*.yml",
  function()
    vim.opt.listchars = default_listchars
  end,
}

vim.opt.listchars = default_listchars
