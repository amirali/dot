local has_lir, lir = pcall(require, "lir")
if not has_lir then
  return
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
if has_devicons then
  devicons.setup {
    override = {
      lir_folder_icon = {
        icon = "",
        color = "#7ebae4",
        name = "LirFolderNode",
      },
    },
  }
end

local actions = require "lir.actions"
lir.setup {
  show_hidden_files = true,
  devicons_enable = true,

  mappings = {
    ["<CR>"] = actions.edit,
    ["<BS>"] = actions.up,

    ["q"] = actions.quit,
    ["K"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["D"] = actions.delete,
    ["R"] = actions.rename,
    ["Y"] = actions.yank_path,
    ["S"] = actions.split,
    ["V"] = actions.vsplit,
    ["T"] = actions.tabedit,
  },
}

-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(
    0,
    "x",
    "J",
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )

  vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
end

vim.cmd [[ augroup LirSettings ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd FileType lir :lua LirSettings() ]]
vim.cmd [[ augroup END ]]
