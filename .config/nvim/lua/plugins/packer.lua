local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require('packer')

return packer.startup(function()
	use 'wbthomason/packer.nvim' -- packer itself
	use 'kyazdani42/nvim-tree.lua' -- file explorer
	use 'lukas-reineke/indent-blankline.nvim' -- indention guide
	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	} -- autopair
	use 'kyazdani42/nvim-web-devicons' -- devicons
	use 'nvim-treesitter/nvim-treesitter' -- treesitter
	use 'shaunsingh/nord.nvim' -- colorscheme 'nord'
	use 'neovim/nvim-lspconfig' -- lsp
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'saadparwaiz1/cmp_luasnip',
		},
	} -- autocompletion
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true},
	} -- statusline
	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup()
		end
	} -- git signs
	use {
	'goolord/alpha-nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.dashboard'.opts)
		end
	}
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  use {
    'amirali/yapf.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('yapf').setup {
        style = '/home/amirali/src/repos/miare/setup.cfg',
      }
    end,
  }
end)
