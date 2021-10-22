local has_telescope, _ = pcall(require, "telescope")
if not has_telescope then
  return
end
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local repos = require "amirali.repos"
local telescope = require "telescope"
local ivy = require("telescope.themes").get_ivy
local dropdown = require("telescope.themes").get_dropdown
local notheme = function(opts)
  return opts
end
local current_theme = notheme

telescope.setup {
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
    },

    file_ignore_patterns = { "node_modules/.*", ".git/.*", "_site/.*" },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    mappings = {
      n = {
        ["<ESC>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["jk"] = actions.close,
        ["kj"] = actions.close,
      },
      i = {
        ["<C-c>"] = actions.close,
        -- ['<ESC>'] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}

local M = {}

function M.wrap(fn, opts)
  return function()
    fn(current_theme(opts))
  end
end

-- telescope.load_extension('fzy_native')
telescope.load_extension "dap"
-- telescope.load_extension "fzf"
telescope.load_extension "fzy_native"

function M.docs()
  local docs = {}
  for group, group_keys in pairs(__MAPS_DOCS) do
    for k, doc in pairs(group_keys) do
      table.insert(docs, string.format("%s [%s] -> %s", group, k, doc))
    end
  end
  for cmd, doc in pairs(__CMDS_DOCS) do
    table.insert(docs, string.format("%s -> %s", cmd, doc))
  end
  pickers.new(current_theme(), {
    prompt_title = "Docs :)",
    finder = finders.new_table {
      results = docs,
    },
    sorter = conf.generic_sorter(),
    previewer = false,
  }):find()
end

function M.grep_string()
  require("telescope.builtin").grep_string {
    shorten_path = true,
    search = vim.fn.input "Grep String> ",
  }
end

function M.base16_theme_selector()
  local theme_names = require("base16.themes"):names()
  pickers.new(current_theme(), {
    finder = finders.new_table {
      results = theme_names,
    },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local apply = function()
        local theme = action_state.get_selected_entry(prompt_bufnr)[1]
        for k, v in pairs(require "base16.themes") do
          if k == theme then
            v:apply()
          end
        end
      end
      map("i", "<CR>", apply)
      map("n", "<CR>", apply)
      return true
    end,
  }):find()
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(current_theme {
    cwd = vim.fn.expand "%:p:h",
  })
end

function M.projects(path)
  pickers.new(dropdown(), {
    previewer = false,
    finder = finders.new_table {
      results = repos.list_projects { path or "~/src/repos/personal" },
    },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local cd_into = function()
        local dir = action_state.get_selected_entry(prompt_bufnr)[1]
        vim.c.cd(dir)
        actions.close(prompt_bufnr)
      end
      map("i", "<CR>", cd_into)
      map("n", "<CR>", cd_into)
      return true
    end,
  }):find()
end

function M.snapp()
  M.projects "~/src/repos/snapp"
end

function M.installed_plugins()
  require("telescope.builtin").find_files(current_theme {
    cwd = vim.fn.stdpath "data" .. "/site/pack/packer/start/",
    follow = true,
  })
end

function M.edit_configs()
  require("telescope.builtin").find_files(current_theme {
    prompt_title = "> Edit Configs <",
    cwd = "~/src/repos/personal/dotfiles",
  })
end

function M.edit_neovim()
  require("telescope.builtin").find_files(current_theme {
    layout_strategy = "vertical",
    prompt_title = "> Edit Neovim Config <",
    cwd = "~/.config/nvim",
    previewer = false,
  })
end

function M.edit_awesome()
  require("telescope.builtin").find_files(current_theme {
    layout_strategy = "vertical",
    prompt_title = "> Edit Awesome Config <",
    cwd = "~/.config/awesome",
    previewer = false,
  })
end

function M.edit_zsh()
  require("telescope.builtin").find_files(current_theme {
    prompt_title = "> Edit ZSH Config <",
    cwd = "~/src/github.com/amirali/dotfiles/zsh",
    hidden = true,
  })
end

function M.lsp_workspace_symbols()
  require("telescope.builtin").lsp_workspace_symbols {
    query = vim.fn.input "Query LSP Workspace Symbols: ",
  }
end

function M.git_files()
  require("telescope.builtin").git_files(current_theme())
end

function M.buffer_grep()
  require("telescope.builtin").current_buffer_fuzzy_find(dropdown {
    previewer = false,
  })
end

function M.actions(bufnr)
  if not has_telescope then
    vim.api.nvim_err_writeln "Install telescope to use this function"
    return
  end
  if not bufnr then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local telescope_actions = require "telescope.actions"
  local telescope_action_state = require "telescope.actions.state"
  local current_actions = Actions:browser(bufnr)
  pickers.new(dropdown(), {
    prompt_title = "> Actions Browser <",
    finder = finders.new_table {
      results = current_actions,
      entry_maker = function(ob)
        return {
          value = ob[2],
          display = ob[1],
          ordinal = ob[1],
        }
      end,
    },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local run = function()
        local fn = telescope_action_state.get_selected_entry(prompt_bufnr).value
        telescope_actions.close(prompt_bufnr)
        fn(bufnr)
      end
      map("i", "<CR>", run)
      map("n", "<CR>", run)
      return true
    end,
  }):find()
end

function M.quickfix()
  if _G.quickfix_state == "open" then
    vim.c.cclose()
  else
    require("telescope.builtin").quickfix()
  end
end

return setmetatable(M, {
  __index = function(tbl, k)
    R "amirali.telescope"
    if tbl[k] then
      return tbl[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
