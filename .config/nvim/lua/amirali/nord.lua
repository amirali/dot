vim.g.nord_italic = false
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false

-- require('nord').set()
local has_nord, _ = pcall(require, 'nord')
if has_nord then
  vim.cmd [[colo nord]]
end
