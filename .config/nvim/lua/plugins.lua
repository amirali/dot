vim.cmd [[packadd packer.nvim]]

local personal_plugins_path = os.getenv "HOME" .. "/src/github.com/amirali/"

local fuzzy_finder = "telescope"

require("packer").startup {
  function(_use)
    local function use(opts)
      local base = personal_plugins_path
      local path
      if type(opts) == "string" then
        path = opts
      else
        path = opts[1]
      end
      local name = vim.split(path, "/")[2]
      if vim.fn.isdirectory(base .. name) ~= 0 then
        if type(opts) == "table" then
          opts[1] = base .. name
        elseif type(opts) == "string" then
          opts = { base .. name }
        end
        _use(opts)
      else
        _use(opts)
      end
    end

    -- Plugin Manager
    use { "wbthomason/packer.nvim" }

    -- Missing stdlib for neovim
    use { "nvim-lua/plenary.nvim" }

    use { "amirrezaask/sitruuna.vim" }

    -- Colorscheme
    use { "shaunsingh/nord.nvim" }

    use {
      "amirrezaask/nline.nvim",
    }

    if fuzzy_finder == "telescope" then
      use { "nvim-lua/popup.nvim" }
      use { "nvim-telescope/telescope.nvim" }
      use { "nvim-telescope/telescope-fzy-native.nvim" }
      use { "nvim-telescope/telescope-dap.nvim" }
      use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    elseif fuzzy_finder == "fzf" then
      use { "junegunn/fzf" }
      use { "junegunn/fzf.vim" }
      use { "ojroques/nvim-lspfuzzy" }
    end

    -- Vim Surround text objects
    use { "tpope/vim-surround" }

    -- Vim JSON tools
    use { "tpope/vim-jdaddy", ft = "json" }
    use { "elzr/vim-json" }

    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup {
          signs = {
            add = { text = "|", numhl = "GitSignsAddNr" },
            change = { text = "|", numhl = "GitSignsChangeNr" },
            delete = { text = "_", numhl = "GitSignsDeleteNr" },
            topdelete = { text = "‾", numhl = "GitSignsDeleteNr" },
            changedelete = { text = "~-", numhl = "GitSignsChangeNr" },
          },
          numhl = false,
          current_line_blame = false,
          current_line_blame_opts = {
            delay = 800,
            virt_text_pos = "eol",
          },
        }
      end,
    }

    use { "tpope/vim-commentary" }

    -- LSP {{{
    use { "neovim/nvim-lspconfig" }
    use { "nvim-lua/lsp_extensions.nvim" }
    use { "onsails/lspkind-nvim" }
    use { "nvim-lua/lsp-status.nvim" }
    -- }}}

    -- Highlight colors
    use {
      "norcalli/nvim-colorizer.lua",
      branch = "color-editor",
      config = function()
        function ColorPicker()
          _PICKER_ASHKAN_KIANI_COPYRIGHT_2020_LONG_NAME_HERE_ = nil
          require("colorizer").color_picker_on_cursor()
        end
        vim.cmd [[ autocmd BufEnter * ColorizerAttachToBuffer ]]
        vim.cmd [[ command! ColorPicker lua ColorPicker ]]
      end,
    }

    -- File Explorer
    use {
      "tamago324/lir.nvim",
    }

    -- Languages {{{
    use { "honza/dockerfile.vim" }
    use { "cespare/vim-toml" }
    use { "chr4/nginx.vim" }
    use { "justinmk/vim-syntax-extra" }
    use { "Glench/Vim-Jinja2-Syntax" }
    -- }}}

    -- Define same action for different Languages and projects
    use { "amirrezaask/actions.nvim" }

    -- Completion {{{
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-path"
    -- }}}

    -- Treesitter {{{
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/playground" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    use { "JoosepAlviste/nvim-ts-context-commentstring" }
    -- }}}

    -- Debugger Adapter Protocol {{{
    use { "mfussenegger/nvim-dap" }
    use { "theHamsta/nvim-dap-virtual-text" }
    -- }}}

    -- Icons {{{
    use { "kyazdani42/nvim-web-devicons" }
    use { "yamatsum/nvim-nonicons" }
    -- }}}

    -- Highlight todo and etc...
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
        vim.map {
          ["<M-e>"] = ":TodoTelescope<CR>",
        }
      end,
    }

    -- beautify text :)
    use { "godlygeek/tabular" }

    -- Nvim Lua dev & docs {{{
    use { "tjdevries/nlua.nvim" }
    use { "milisims/nvim-luaref" }
    use { "nanotee/luv-vimdocs" }
    -- }}}

    -- :Messages
    use "tpope/vim-scriptease"

    -- better inc/dec
    use {
      "monaqa/dial.nvim",
      config = function()
        vim.cmd [[
					nmap <C-a> <Plug>(dial-increment)
					nmap <C-x> <Plug>(dial-decrement)
					vmap <C-a> <Plug>(dial-increment)
					vmap <C-x> <Plug>(dial-decrement)
					vmap g<C-a> <Plug>(dial-increment-additional)
					vmap g<C-x> <Plug>(dial-decrement-additional)
				]]
      end,
    }
    use {
      "antoinemadec/FixCursorHold.nvim",
      run = function()
        vim.g.curshold_updatime = 1000
      end,
    }
    use {
      "ollykel/v-vim",
      config = function()
        vim.g.v_autofmt_bufwritepre = true
      end,
    }
    use {
      "amirali/yapf.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("yapf").setup {
          command = "yapf",
          style = "/home/amirali/src/repos/miare/setup.cfg",
        }
      end,
    }
  end,
}
