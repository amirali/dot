vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>dO", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>dlp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

require("nvim-dap-virtual-text").setup({})
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
