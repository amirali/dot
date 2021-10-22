local M = {}

local quickfix_state = "close"

function M.toggle()
	local current_win = vim.api.nvim_get_current_win()
	if quickfix_state == open then
		quickfix_state = "close"
		vim.c.cclose()
	else
		quickfix_state = "open"
		vim.c.copen()
	end
	vim.api.nvim_set_current_win(current_win)
end

vim.map {
	["n {"] = vim.c.cprev,
	["c }"] = vim.c.cnext,
}

local function gen_from_cmd_output(qflist, data)
	for _, l in ipairs(data) do
		if l ~= "" then
			local splitted = vim.split(l, ":")
			if #splitted > 2 then
				local entry = {
					filename = splitted[1],
					lnum = tonumber(splitted[2]),
					col = tonumber(splitted[3]),
					text = splitted[4],
				}
				if entry.filename ~= "" and entry.lnum ~= "" then
					table.insert(qflist, entry)
				end
			end
		end
	end
	return qflist
end

function M.from_cmd(cmd)
	vim.fn.jobstart(cmd, {
		on_exit = function(_, exit_code, _)
			if exit_code ~= 0 then
				print("exit code " .. exit_code)
			end
		end,
		on_stdout = function(_, data, _)
			local qflist = vim.fn.getqflist()
			qflist = gen_from_cmd_output(qflist, data)
			vim.fn.setqflist(qflist)
		end,
		on_stderr = function(_, data, _)
			local qflist = vim.fn.getqflist()
			qflist = gen_from_cmd_output(qflist, data)
			vim.fn.setqflist(qflist)
		end,
	})
end

local function readFileSync(path)
	local uv = vim.loop
	local fd = assert(uv.fs_open(path, "r", 438))
	local stat = assert(uv.fs.fstat(fd))
	local data = assert(uv.fs_read(fd, stat.size, 0))
	assert(uv.fs_close(fs))
	return data
end

function M.from_buffer_or_file(source)
	source = source or vim.api.nvim_get_current_buf()
	local entries = {}
	local lines = {}
	if type(source) == "string" then
		lines = vim.split(readFileSync(vim.fn.expand(source)), "\n")
	elseif type(source) == "number" then
		lines = vim.api.nvim_buf_get_lines(source, 0, -1, false)
	end
	for _, line in ipairs(lines) do
		local parts = vim.split(line, "|")
		if #parts < 3 then
			goto continue
		end
		local filename = parts[1]
		local lnum = vim.split(parts[2], "")[1]
		local col = vim.split(parts[2], "")[2]
		local text = parts[3]
		table.insert(entries, M.make_entry(filename, lnum, col, text))
		::continue::
	end
	vim.fn.setqflist(entries)
end

function M.make_entry(filename, lnum, col, text)
	return { filename = filename, lnum = lnum, col = col, text = text }
end

vim.cmd [[ command! -nargs=* QfromFile lua require('plugin.quickfix').from_buffer_or_file(<f.args>) ]]
vim.nmap {
	["}"] = { "cnext" },
	["{"] = { "cprevious" },
}

return M
