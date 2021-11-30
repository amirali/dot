require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
	},
  ensure_installed = {
    'python',
    'go',
    'gomod',
    'lua',
    'yaml',
    'dockerfile',
    'toml',
    'json',
    'regex',
    'vue',
    'vim',
  }
}
