local has_nline, nline = pcall(require, "nline")
if not has_nline then
  return
end

local vim = require "nline.parts.vim"
local git = require "nline.parts.git"
local lsp = require "nline.parts.lsp"
local wrappers = require "nline.wrappers"
local icons = require "nline.parts.icons"

local tj = {
  vim.mode {
    texts = {
      normal = "Normal",
      visual = "Visual",
      visual_block = "VisualBlock",
      insert = "Insert",
      insert_complete = "IComplete",
      command = "Command",
      terminal = "Terminal",
    },
  },
  vim.space(),
  icons.git_branch,
  vim.space(),
  git.branch(),

  vim.seperator(),

  icons.file,
  vim.space(),
  vim.filename { shorten = true },
  vim.modified(),

  vim.seperator(),

  -- wrappers.square_brackets(lsp.current_function()),
  wrappers.square_brackets(git.changes()),
  wrappers.square_brackets(lsp.diagnostics()),
  -- lsp.progress(),
  wrappers.square_brackets(vim.line() .. vim.space() .. vim.colon() .. vim.col()),
  vim.filetype(),
}
local me = {
  vim.modified(),
  vim.filename { shorten = false } { hl = "NormalMode" },

  vim.seperator(),

  wrappers.square_brackets(git.branch()),
  wrappers.square_brackets(lsp.current_function()),
  wrappers.square_brackets(git.changes()),
  wrappers.square_brackets(lsp.diagnostics()),
  -- lsp.progress(),
  wrappers.square_brackets(vim.line() .. vim.space() .. vim.colon() .. vim.col()),
  vim.filetype(),
}
nline.make(tj)
