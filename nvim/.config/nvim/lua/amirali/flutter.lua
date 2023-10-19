require('flutter-tools').setup {
  ui = {
    border = 'rounded',
    notification_style = 'native',
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
      project_config = false,
    }
  },
  debugger = {
    enabled = false,
    run_via_dap = false,
    exception_breakpoints = {},
    register_configurations = function(paths)
      require('dap').configurations.dart = {

      }
    end,
  },
  flutter_path = '/opt/homebrew/bin/flutter',
  flutter_lookup_cmd = nil,
  fvm = false,
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = 'Comment',
    prefix = '>',
    enabled = true,
  },
  dev_log = {
    enabled = true,
    notify_errors = false,
    open_cmd = 'tabedit',
  },
  dev_tools = {
    autostart = true,
    auto_open_browser = true,
  },
  outline = {
    open_cmd = '25vnew',
    auto_open = false,
  },
  lsp = {
    color = {
      enabled = true,
      background = true,
      background_color = nil,
      foreground = false,
      virtual_text = true,
      virtual_text_str = '■',
    },
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = 'prompt',
      enableSnippets = true,
      updateImportsOnRename = true,
    }
  }
}

require('telescope').load_extension('flutter')
vim.api.nvim_create_user_command(
  'Flutter',
  function(opts)
    vim.cmd('Telescope flutter commands')
  end,
  {}
)
