local Job = require "plenary.job"
local Path = require "plenary.path"
local Stylua = {}
local cached_configs = {}

local lspconfig_util = require "lspconfig.util"
local root_finder = lspconfig_util.root_pattern ".git"

-- @param bufnr: number
function Stylua:get_config_path(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr)
	if cached_configs[path] == nil then
		local file_path = Path:new(path)
		local root_path = Path:new(root_finder(path))
		
		local file_parents = file_path:parents()
		local root_parents = root_path:parents()

		local relative_diff = #file_parents - #root_parents
		for index, dir in ipairs(file_parents) do
			if index > relative_diff then
				break
			end
			
			local stylua_path = Path:new { dir, "stylua.toml" }
			if stylua_path:exists() then
				cached_configs[path] = stylua_path:absolute()
				break
			end

			stylua_path = Path:new { dir, ".stylua.toml" }
			if stylua_path:exists() then
				cached_configs[path] = stylua_path:absolute()
				break
			end

			stylua_path = Path:new { os.getenv 'HOME', ".stylua.toml" }
			if stylua_path:exists() then
				cached_configs[path] = stylua_path:absolute()
				break
			end
		end
	end

	return cached_configs[path]
end

-- @param bufnr: number
function Stylua:run(bufnr)
	local config_path = self:get_config_path(bufnr)
	local job = Job:new {
		"stylua",
		"--config-path",
		config_path,
		"-",
		writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
	}
	local output = job:sync()

	if job.code ~= 0 then
		print "can't format"
		return
	end
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
end

return Stylua
