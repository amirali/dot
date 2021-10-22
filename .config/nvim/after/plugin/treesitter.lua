local has_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")
if not has_treesitter then
  return
end

treesitter.setup {
  ensure_installed = {
    "go",
    "lua",
    "python",
    "rust",
    "query",
    "toml",
    "php",
    "yaml",
    "json",
    "dockerfile",
    "c",
    "gomod",
    "html",
    "bash",
  },
  context_commentstring = {
    enable = true,
    config = {
      c = "// %s",
      lua = "-- %s",
    },
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        -- ['ac'] = '@class.outer',
        -- ['ic'] = '@class.inner',
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ad"] = "@comment.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        -- @frame.inner"
        -- @frame.outer
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",
        -- @scopename.inner
        -- @statement.outer
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- mappings for incremental selection (visual mappings)
      init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
      node_incremental = "<M-w>", -- increment to the upper named parent
      scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "<M-C-w>", -- decrement to the previous node
    },
  },
}
