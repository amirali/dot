local has_catppuccin, catppuccin = pcall(require, 'catppuccin')

if has_catppuccin then
  require'catppuccin'.setup {
    styles = {
      comments = "NONE",
      functions = "bold",
      keywords = "NONE",
      strings = "NONE",
      variables = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "NONE",
          hints = "NONE",
          warnings = "NONE",
          information = "NONE",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = false,
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      hop = false,
    }
  }

  vim.cmd [[colo catppuccin]]
end
