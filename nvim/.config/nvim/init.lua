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
  'amirali.catppuccin',
}

for _, source in ipairs(sources) do
  local ok, fault = pcall(require, source)
  if not ok then
    print('Failed to load ' .. source .. '\n' .. fault .. '\n----------')
  end
end
