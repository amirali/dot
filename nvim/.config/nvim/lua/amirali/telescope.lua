local bind = vim.keymap.set
nnoremap = function(key, fn)
  bind('n', key, fn)
end

local telescope_builtin = require('telescope.builtin')
local telescope_theme = require('telescope.themes').get_ivy({})
nnoremap('<leader><leader>', function() telescope_builtin.find_files(telescope_theme) end)
if vim.g.vscode then
  nnoremap('<20><20>', function() telescope_builtin.find_files(telescope_theme) end)
end
nnoremap('??', function() telescope_builtin.live_grep(telescope_theme) end)
