-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Enable editorconfig
vim.g.editorconfig = false

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup {
  { import = 'plugins' },
}

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { '*.go' },
--   callback = function()
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
vim.keymap.set('n', '<leader>ef', 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')
--   end,
-- })

vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

vim.opt.foldmethod = 'expr'
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
vim.opt.colorcolumn = '80'
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]

local disabled_built_ins = {
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  -- 'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

vim.cmd("let $NEOVIM_LISTEN_ADDRESS = '" .. vim.fn.serverlist()[1] .. "'")

vim.api.nvim_create_user_command('Wwf', function(opts)
  local custom_path = opts.args
  local filename = vim.fn.expand '%:t' -- Get the current file's name
  if filename == '' and not custom_path then
    error 'No file name.'
    return
  end
  local path = custom_path or filename
  require('conform').setup { format_on_save = nil }
  vim.cmd('write ' .. path)
  require('conform').setup(require('plugins.conform').opts)
end, { desc = 'Write the current file without conform formatting', nargs = '?', complete = 'dir' })

---@param to '"c"'|'"s"'|'"a"'|'"camel"'|'"snake"'|'"auto"'
local function switch_case(to)
  to = to or 'auto'
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand '<cword>'
  local word_start = vim.fn.matchstrpos(vim.fn.getline '.', '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  -- camelCase to snake_case
  if to:match '^[as]' ~= nil and word:find '[a-z][A-Z]' then
    local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
    return
  end

  -- snake_case
  if to:match '^[ac]' ~= nil and word:find '_[a-z]' then
    local camel_case_word = word:gsub('(_)([a-z])', function(_, l)
      return l:upper()
    end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
    return
  end
end
vim.api.nvim_create_user_command('SwitchCase', function(opts)
  local to = opts.args
  if to == '' then
    to = 'auto'
  end
  switch_case(to)
end, {
  desc = 'Switch variable casing. camelCase to snake_case and vice-versa.',
  nargs = '?',
  complete = function()
    return { 'auto', 'camel', 'snake' }
  end,
})

local function diff_with_saved()
  local buf = vim.api.nvim_get_current_buf()
  if not vim.bo[buf].modified then
    print 'No changes in the buffer.'
    return
  end

  -- Get the current file path
  local file_path = vim.api.nvim_buf_get_name(buf)
  if file_path == '' then
    print 'Buffer is unnamed. Cannot diff with saved file.'
    return
  end

  -- Create a new scratch buffer to hold the saved file contents
  local saved_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(saved_buf, 'buftype', 'nofile')

  -- Read the file contents and set them in the new buffer
  local lines = {}
  local file = io.open(file_path, 'r')
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  else
    print('Failed to open file: ' .. file_path)
    return
  end
  vim.api.nvim_buf_set_lines(saved_buf, 0, -1, false, lines)

  -- Open the saved buffer in a vertical split
  vim.api.nvim_command 'vsplit'
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, saved_buf)

  -- Enable diff mode in both buffers
  vim.api.nvim_buf_set_option(buf, 'diff', true)
  vim.api.nvim_buf_set_option(saved_buf, 'diff', true)
end
vim.api.nvim_create_user_command('DiffSaved', diff_with_saved, {})

vim.keymap.set('n', '<leader>dds', function()
  vim.cmd [[!python manage.py shell < %]]
end, { desc = 'run file with django shell' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format()
end, { desc = 'Format current buffer' })

vim.api.nvim_create_user_command('CursorRef', function()
  local filepath = vim.fn.expand '%'
  local linenr = vim.fn.line '.'
  local ref = filepath .. ':' .. linenr
  vim.fn.setreg('+', ref)
  print(ref)
end, {})

vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- -- Example: Enable spell check for Markdown files
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'markdown',
--   command = 'setlocal spell spelllang=en_us',
-- })
