local cmd = vim.cmd     	-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       	-- call Vim functions
local g = vim.g         	-- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false

opt.number = true
opt.relativenumber = true
opt.foldmethod = 'expr'
cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
opt.colorcolumn = '100'
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true

cmd [[au BufWritePre * :%s/\s\+$//e]]

exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240

opt.termguicolors = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

cmd [[
  autocmd FileType lua,yaml setlocal shiftwidth=2 tabstop=2
]]

cmd [[
  autocmd FileType go setlocal noexpandtab
]]

opt.completeopt = 'menuone,noselect'

cmd [[command Term :botright vsplit term://$SHELL]]

cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
