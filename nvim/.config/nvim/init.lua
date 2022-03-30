local sources = {
  'settings',
  'keymaps',
  'amirali.packer',
  'amirali.nvim-treesitter',
  'amirali.nvim-tree',
  'amirali.lualine',
  'amirali.alpha-nvim',
  'amirali.gitsigns',
  'amirali.indent-blankline',
  'amirali.nvim-cmp',
  'amirali.nvim-lspconfig',
  'amirali.telescope',
  'amirali.hop',
  -- 'amirali.nord',
  'amirali.catppuccin',
}

for _, source in ipairs(sources) do
  local ok, fault = pcall(require, source)
  if not ok then
    print('Failed to load ' .. source .. '\n' .. fault .. '\n----------')
  end
end
