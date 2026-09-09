return {
	repo = "https://github.com/Michal1993r/ai-helper.wezterm",
	setup = function(mod, config)
		mod.apply_to_config(config, {
			type = "ollama",
			ollama_path = "ollama", -- or full path like "/usr/local/bin/ollama"
			model = "qwen3:1.7b", -- or any model you have installed
		})
	end,
}
