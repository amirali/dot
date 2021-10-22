local Job = require "plenary.job"
local M = {}

function M.format(bufnr)
	bufnr = bufnr or 0
	vim.c.write()
	local job = Job:new {
		"goimports",
		vim.api.nvim_buf_get_name(0),
	}
	local output = job:sync()

	if job.code ~= 0 then
		return
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
end

return M
