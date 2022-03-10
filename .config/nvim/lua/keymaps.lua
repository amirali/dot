local map = vim.api.nvim_set_keymap -- for all neovims
local default_opts = { noremap = true, silent = true }
local noremap = { noremap = true }
local cmd = vim.cmd

-- leader
vim.g.mapleader = " "

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- map esc to jk and kj
map('i', 'jk', '<Esc>', noremap)
map('i', 'kj', '<Esc>', noremap)

-- disable arrowkeys in normal mode
map('n', '<up>', '<nop>', noremap)
map('n', '<down>', '<nop>', noremap)
map('n', '<left>', '<nop>', noremap)
map('n', '<right>', '<nop>', noremap)

-- terminal
map('n', '`', ':Term<cr>', noremap)
map('t', 'jk', '<C-\\><C-n>', noremap)
map('t', 'kj', '<C-\\><C-n>', noremap)
map('t', '<esc>', '<C-\\><C-n>', noremap)

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- Disable recording macros (jfn)
map('n', 'Q', '<nop>', default_opts)
