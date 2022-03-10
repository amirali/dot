require('indent_blankline').setup {
  show_first_indent_level = false,
  buftype_exclude = {
    'terminal',
    'nofile'
  },
  filetype_exclude = {
    'help',
    'git',
    'markdown',
    'text',
    'terminal',
    'lspinfo',
    'packer'
  },
}
