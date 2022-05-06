local g = vim.g

g.nvim_tree_git_hl = true
g.nvim_tree_highlight_opened_files = true
g.nvim_tree_respect_buf_cwd = true
g.nvim_tree_width_allow_resize = true
g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1
}
g.nvim_tree_icons = {
	default = "‣ "
}
require('nvim-tree').setup {
	open_on_setup = true,
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
	view = {
		width = 32,
	},
	filters = {
		dotfiles = true,
		custom = { '.git', 'venv' },
	},
  actions = {
    open_file = {
      window_picker = {
        enable = true
      },
      quit_on_open = false,
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}
