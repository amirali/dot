local hls = vim.fn.getcompletion("", "highlight")

local function convert_hl_map_to_hi_inst(name, hl_map)
	output = { "hi", name }
	if hl_map.foreground then
		table.insert(output, string.format('guifg="#%x"', hl_map.foreground))
	end
	if hl_map.background then
		table.insert(output, string.format('guibg="#%x"', hl_map.background))
	end
	if #output < 3 then
		return
	end
	return table.concat(output, " ")
end

local insts = {}
for i, hl in ipairs(hls) do
	local hl_map = vim.api.nvim_get_hl_by_name(hl, true)
	local inst = convert_hl_map_to_hi_inst(hl, hl_map)
	if inst ~= nil then
		table.insert(insts, inst)
	end
end

vim.api.nvim_buf_set_lines(116, 0, -1, false, insts)
