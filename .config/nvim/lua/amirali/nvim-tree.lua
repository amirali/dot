local g = vim.g

g.nvim_tree_gitignore = true
g.nvim_tree_quit_on_open = false
g.nvim_tree_indent_markers = true
g.nvim_tree_git_hl = true
g.nvim_tree_highlight_opened_files = true
g.nvim_tree_disable_window_picker = true
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
	view = {
		width = 32,
		auto_resize = true
	},
	filters = {
		dotfiles = true,
		custom = { '.git', 'venv' },
	},
}
