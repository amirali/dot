local nnoremap = function(key, fn)
  vim.keymap.set('n', key, fn)
end
local inoremap = function(key, fn)
  vim.keymap.set('i', key, fn)
end
local vnoremap = function(key, fn)
  vim.keymap.set('v', key, fn)
end
local tnoremap = function(key, fn)
  vim.keymap.set('t', key, fn)
end

-- leader
vim.g.mapleader = " "

-- Open new tab w/ netrw
nnoremap('<c-n>', ':tabnew +Ex<cr>')

-- clear search highlighting
nnoremap('<leader>c', ':nohl<cr>')

-- map esc to jk and kj
inoremap('jk', '<esc>')
inoremap('kj', '<esc>')

-- terminal
nnoremap('`', ':Term<cr>')
tnoremap('jk', '<c-\\><c-n>')
tnoremap('kj', '<c-\\><c-n>')
tnoremap('<esc>', '<c-\\><c-n>')

-- Disable recording macros (jfn)
nnoremap('Q', '<nop>')

-- map hop bindings
nnoremap('<leader>j', ":lua require'hop'.hint_words()<cr>")
nnoremap('<leader>l', ":lua require'hop'.hint_lines()<cr>")

-- temp cargo run
local cargo_run = function()
  print("hello from rust")
  map('n', '<leader>run', ':!cargo run<cr>', noremap)
end
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.rs"},
  callback = cargo_run,
})

return {
  nnoremap = function(key, fn)
    vim.keymap.set('n', key, fun)
  end,
  inoremap = function(key, fn)
    vim.keymap.set('i', key, fun)
  end,
  vnoremap = function(key, fn)
    vim.keymap.set('v', key, fun)
  end,
  tnoremap = function(key, fn)
    vim.keymap.set('t', key, fun)
  end,
}
