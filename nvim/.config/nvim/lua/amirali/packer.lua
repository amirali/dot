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
  -- flutter
  use {
    'akinsho/flutter-tools.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }
  use {
    'folke/noice.nvim',
    requires = { 'rcarriga/nvim-notify', 'MunifTanjim/nui.nvim' },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  }
  use {
    'tpope/vim-dadbod',
    requires = { 'kristijanhusak/vim-dadbod-ui', 'kristijanhusak/vim-dadbod-completion' }
  }
  use {
    'folke/trouble.nvim',
    requires = {'nvim-tree/nvim-web-devicons'},
  }
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim'
    },
  }
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
  }
  use {
    '~/src/github.com/amirali/neotest-python',
  }
end)
