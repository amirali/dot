local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require('packer')

return packer.startup(function()
	use 'wbthomason/packer.nvim' -- packer itself
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
  use {
    'amirali/catppuccin.nvim', -- watch https://github.com/catppuccin/nvim/issues/95
    as = 'catppuccin',
  }
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
	} -- git signs
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  use {
    'amirali/yapf.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('yapf').setup {
        style = '/Users/amirali/src/miare/setup.cfg',
      }
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'phaazon/hop.nvim'
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require'todo-comments'.setup {}
    end,
  }
  use 'ellisonleao/glow.nvim'
  use 'Joorem/vim-haproxy'
  use 'lepture/vim-jinja'
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup({})
    end
  }
  use 'rhysd/vim-wasm'
  use 'terrastruct/d2-vim'
  use 'github/copilot.vim'
  use 'fatih/vim-go'
  use {
    'lukas-reineke/headlines.nvim',
    after = 'nvim-treesitter',
    config = function()
      require("headlines").setup({
          markdown = {
              headline_highlights = {
                  "Headline1",
                  "Headline2",
                  "Headline3",
                  "Headline4",
                  "Headline5",
                  "Headline6",
              },
              codeblock_highlight = "CodeBlock",
              dash_highlight = "Dash",
              quote_highlight = "Quote",
          },
      })
    end,
  }
end)
