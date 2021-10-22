local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- -------
-- General
-- -------
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.encoding = "utf-8"

-- --
-- UI
-- --
opt.number = true
opt.relativenumber = true
opt.foldmethod = "marker"
opt.colorcolumn = "100"
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = "tab:→ ,eol:↲"

-- ------
-- Search
-- ------
opt.ignorecase = true
opt.smartcase = true

---------------------------------------------
-- Indent
---------------------------------------------
opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
cmd([[
	autocmd FileType html,css,scss,javascript,vue setlocal shiftwidth=2 tabstop=2 expandtab
]]) -- 2 spaces indent for selected files
cmd([[
	autocmd FileType python setlocal expandtab
]]) -- expand tabs to spaces for python files

---------------------------------------------
-- Memory, CPU
---------------------------------------------
opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240

-- colorscheme
opt.termguicolors = true
cmd("colorscheme nord")

-- highlight on yank
exec([[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
	augroup end
]], false)

-- disable new lines auto commenting
cmd("au BufEnter * set fo-=c fo-=r fo-=o")
