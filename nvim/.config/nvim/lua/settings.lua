local cmd = vim.cmd     	-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       	-- call Vim functions
local g = vim.g         	-- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false

opt.number = true
opt.relativenumber = true
opt.foldmethod = 'expr'
cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
opt.colorcolumn = '100'
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true

cmd [[au BufWritePre * :%s/\s\+$//e]]

exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240

opt.termguicolors = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

cmd [[
  autocmd FileType lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- set yaml.ansible filetype (https://github.com/pearofducks/ansible-vim/blob/master/ftdetect/ansible.vim)
cmd [[
  function! s:isAnsible()
    let filepath = expand("%:p")
    let filename = expand("%:t")
    if filepath =~ '\v/(tasks|roles|handlers)/.*\.ya?ml$' | return 1 | en
    if filepath =~ '\v/(group|host)_vars/' | return 1 | en
    let s:ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'
    if exists("g:ansible_ftdetect_filename_regex")
      let s:ftdetect_filename_regex = g:ansible_ftdetect_filename_regex
    endif

    if filename =~ s:ftdetect_filename_regex | return 1 | en

    let shebang = getline(1)
    if shebang =~# '^#!.*/bin/env\s\+ansible-playbook\>' | return 1 | en
    if shebang =~# '^#!.*/bin/ansible-playbook\>' | return 1 | en

    return 0
  endfunction

  augroup ansible_vim_ftyaml_ansible
    au!
    au BufNewFile,BufRead * if s:isAnsible() | set ft=yaml.ansible | en
  augroup END
  augroup ansible_vim_fthosts
    au!
    au BufNewFile,BufRead hosts set ft=ansible_hosts
  augroup END
]]

cmd [[
  autocmd FileType go setlocal noexpandtab
]]

opt.completeopt = 'menuone,noselect'

cmd [[command Term :botright vsplit term://$SHELL]]

cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

local disabled_built_ins = {
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
