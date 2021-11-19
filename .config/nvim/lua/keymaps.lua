local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- map esc to jk and kj
map('i', 'jk', '<Esc>', {noremap = true})
map('i', 'kj', '<Esc>', {noremap = true})

-- disable arrowkeys in normal mode
map('n', '<up>', '<nop>', {noremap = true})
map('n', '<down>', '<nop>', {noremap = true})
map('n', '<left>', '<nop>', {noremap = true})
map('n', '<right>', '<nop>', {noremap = true})

-- terminal
map('n', '<C-t>', ':term<cr>', {noremap = true})

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file
