vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.equalalways = false
vim.opt.modeline = true
vim.opt.autoread = true
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.history = 700
vim.opt.tabpagemax = 100
vim.opt.ruler = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.pumblend = 5
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.hidden = true
vim.opt.updatetime = 100
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmode = vim.opt.wildmode - "list"
vim.opt.wildmode = vim.opt.wildmode + { "longest", "full" }
vim.opt.colorcolumn = "100"
vim.opt.foldmethod = "marker"

if vim.fn.executable "rg" == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.opt.hidden = true
vim.opt.history = 100
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240

vim.api.nvim_exec(
  [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
	augroup end
]],
  false
)

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
