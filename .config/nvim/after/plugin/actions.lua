local has_actions, actions = pcall(require, "actions")
local Job = require "plenary.job"
if not has_actions then
  return
end

local lsp = require "amirali.lsp"
local utils = require "actions.utils"

local function floating_window_opts(opts)
  local base = {
    height_pct = 50,
    width_pct = 70,
  }
  if opts then
    for k, v in pairs(opts) do
      base[k] = v
    end
  end
  return base
end

actions:setup {
  mappings = {
    ["n ,ab"] = "build",
    ["n ,at"] = "test_all",
    ["n ,tt"] = "test_this",
    ["n ,ar"] = "run",
    ["n ,af"] = "format",
  },
  {
    predicate = utils.make_language_predicate "vim",
    actions = {
      run = function(bufnr)
        vim.cmd [[ so % ]]
      end,
    },
  },
  {
    predicate = utils.compose(
      utils.make_language_predicate "lua",
      utils.make_path_predicate "plugins.lua"
    ),
    actions = {
      run = function(bufnr)
        vim.c.luafile(vim.api.nvim_buf_get_name(bufnr))
        vim.cmd [[ PackerInstall ]]
      end,
    },
  },
  {
    predicate = utils.make_language_predicate "lua",
    actions = {
      run = function(bufnr)
        vim.c.luafile(vim.api.nvim_buf_get_name(bufnr))
      end,
      format = function(bufnr)
        require("amirali.stylua"):run(bufnr)
      end,
    },
  },
  {
    predicate = utils.make_language_predicate "go",
    actions = {
      format = function(bufnr)
        require("amirali.go").format(bufnr)
      end,
      build = function(_)
        vim.cmd [[ vnew | term go build ]]
      end,
      test_all = function(_)
        vim.cmd [[ vnew | term go test -v ./... ]]
      end,
      test_this = function(_)
        local function go_current_test()
          local linenr = vim.fn.search("func \\(Test\\|Example\\)", "bcnW")
          if linenr == 0 then
            return
          end
          local linetext = vim.fn.getline(linenr)
          local test_name = vim.split(linetext, " ")[2]
          local start, _ = string.find(test_name, "%(")
          test_name = string.sub(test_name, 1, start - 1)
          return test_name
        end
        local current_test = go_current_test()
        vim.cmd(string.format([[ vnew | term go test -v -run %s ]], current_test))
      end,
    },
  },
}

vim.cmd [[ autocmd BufWritePre * lua Actions:exec(0, 'format') ]]
