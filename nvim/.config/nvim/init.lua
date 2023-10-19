local sources = {
  'settings',
  'amirali.keymaps',
  'amirali.packer',
  'amirali.nvim-treesitter',
  'amirali.lualine',
  'amirali.gitsigns',
  'amirali.indent-blankline',
  'amirali.nvim-cmp',
  'amirali.nvim-lspconfig',
  'amirali.telescope',
  'amirali.hop',
  'amirali.miare',
  'amirali.flutter',
  'amirali.dap',
  'amirali.test',
  -- 'amirali.catppuccin',
}

for _, source in ipairs(sources) do
  local ok, fault = pcall(require, source)
  if not ok then
    print('Failed to load ' .. source .. '\n' .. fault .. '\n----------')
  end
end

vim.g.nord_italic = false
vim.g.nord_bold = false
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_uniform_diff_background = true
require('nord').set()
