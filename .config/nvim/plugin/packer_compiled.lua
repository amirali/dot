-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/amirali/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/amirali/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/amirali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/amirali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/amirali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["Vim-Jinja2-Syntax"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/Vim-Jinja2-Syntax"
  },
  ["actions.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/actions.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\n´\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ã\2\t\t\t\t\tnmap <C-a> <Plug>(dial-increment)\n\t\t\t\t\tnmap <C-x> <Plug>(dial-decrement)\n\t\t\t\t\tvmap <C-a> <Plug>(dial-increment)\n\t\t\t\t\tvmap <C-x> <Plug>(dial-decrement)\n\t\t\t\t\tvmap g<C-a> <Plug>(dial-increment-additional)\n\t\t\t\t\tvmap g<C-x> <Plug>(dial-decrement-additional)\n\t\t\t\t\bcmd\bvim\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  ["dockerfile.vim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/dockerfile.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nù\3\0\0\5\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\2\18virt_text_pos\beol\ndelay\3†\6\nsigns\1\0\2\nnumhl\1\23current_line_blame\1\17changedelete\1\0\2\nnumhl\21GitSignsChangeNr\ttext\a~-\14topdelete\1\0\2\nnumhl\21GitSignsDeleteNr\ttext\b‚Äæ\vdelete\1\0\2\nnumhl\21GitSignsDeleteNr\ttext\6_\vchange\1\0\2\nnumhl\21GitSignsChangeNr\ttext\6|\badd\1\0\0\1\0\2\nnumhl\18GitSignsAddNr\ttext\6|\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lir.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/lir.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["luv-vimdocs"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/luv-vimdocs"
  },
  ["nginx.vim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nginx.vim"
  },
  ["nline.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nline.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nÑ\1\0\0\3\0\4\0\b+\0\0\0007\0\0\0006\0\1\0'\2\2\0B\0\2\0029\0\3\0B\0\1\1K\0\1\0\27color_picker_on_cursor\14colorizer\frequire8_PICKER_ASHKAN_KIANI_COPYRIGHT_2020_LONG_NAME_HERE_ú\1\1\0\3\0\6\0\v3\0\0\0007\0\1\0006\0\2\0009\0\3\0'\2\4\0B\0\2\0016\0\2\0009\0\3\0'\2\5\0B\0\2\1K\0\1\0+ command! ColorPicker lua ColorPicker 1 autocmd BufEnter * ColorizerAttachToBuffer \bcmd\bvim\16ColorPicker\0\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luaref"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-luaref"
  },
  ["nvim-nonicons"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-nonicons"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["sitruuna.vim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/sitruuna.vim"
  },
  tabular = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\ns\0\0\3\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\0\1\n<M-e>\23:TodoTelescope<CR>\bmap\bvim\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["v-vim"] = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\26v_autofmt_bufwritepre\6g\bvim\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/v-vim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-jdaddy"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/opt/vim-jdaddy"
  },
  ["vim-json"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-json"
  },
  ["vim-scriptease"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-scriptease"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-syntax-extra"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["yapf.nvim"] = {
    config = { "\27LJ\2\nt\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\nstyle,/home/amirali/src/repos/miare/setup.cfg\fcommand\tyapf\nsetup\tyapf\frequire\0" },
    loaded = true,
    path = "/home/amirali/.local/share/nvim/site/pack/packer/start/yapf.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: yapf.nvim
time([[Config for yapf.nvim]], true)
try_loadstring("\27LJ\2\nt\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\nstyle,/home/amirali/src/repos/miare/setup.cfg\fcommand\tyapf\nsetup\tyapf\frequire\0", "config", "yapf.nvim")
time([[Config for yapf.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nÑ\1\0\0\3\0\4\0\b+\0\0\0007\0\0\0006\0\1\0'\2\2\0B\0\2\0029\0\3\0B\0\1\1K\0\1\0\27color_picker_on_cursor\14colorizer\frequire8_PICKER_ASHKAN_KIANI_COPYRIGHT_2020_LONG_NAME_HERE_ú\1\1\0\3\0\6\0\v3\0\0\0007\0\1\0006\0\2\0009\0\3\0'\2\4\0B\0\2\0016\0\2\0009\0\3\0'\2\5\0B\0\2\1K\0\1\0+ command! ColorPicker lua ColorPicker 1 autocmd BufEnter * ColorizerAttachToBuffer \bcmd\bvim\16ColorPicker\0\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: v-vim
time([[Config for v-vim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\26v_autofmt_bufwritepre\6g\bvim\0", "config", "v-vim")
time([[Config for v-vim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\ns\0\0\3\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\0\1\n<M-e>\23:TodoTelescope<CR>\bmap\bvim\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\n´\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ã\2\t\t\t\t\tnmap <C-a> <Plug>(dial-increment)\n\t\t\t\t\tnmap <C-x> <Plug>(dial-decrement)\n\t\t\t\t\tvmap <C-a> <Plug>(dial-increment)\n\t\t\t\t\tvmap <C-x> <Plug>(dial-decrement)\n\t\t\t\t\tvmap g<C-a> <Plug>(dial-increment-additional)\n\t\t\t\t\tvmap g<C-x> <Plug>(dial-decrement-additional)\n\t\t\t\t\bcmd\bvim\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nù\3\0\0\5\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\2\18virt_text_pos\beol\ndelay\3†\6\nsigns\1\0\2\nnumhl\1\23current_line_blame\1\17changedelete\1\0\2\nnumhl\21GitSignsChangeNr\ttext\a~-\14topdelete\1\0\2\nnumhl\21GitSignsDeleteNr\ttext\b‚Äæ\vdelete\1\0\2\nnumhl\21GitSignsDeleteNr\ttext\6_\vchange\1\0\2\nnumhl\21GitSignsChangeNr\ttext\6|\badd\1\0\0\1\0\2\nnumhl\18GitSignsAddNr\ttext\6|\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType json ++once lua require("packer.load")({'vim-jdaddy'}, { ft = "json" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
