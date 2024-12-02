local M = {}
local is_snowing = false

-- プラグインセットアップ
function M.setup(user_config)
	local namespace = vim.api.nvim_create_namespace("snowfall") -- 名前空間を作成
	local utils = require("snowfall.uitls")
	local renderer = require("snowfall.renderer")

	local config = {}
	local defaults = {
		snowflake = {
			path = utils.get_plugin_resource("./assets/nix.png"),
			width = 2,
			height = 2,
		},
		startup = true,
		count = 20,
		update_interval = 100,
	}

	-- メインループ
	local function snowfall_loop()
		if not is_snowing then
			return
		end
		renderer.update_position()
		renderer.draw_snow()
		vim.defer_fn(snowfall_loop, 100)
	end

	local function start_snowfall()
		if not is_snowing then
			is_snowing = true
			snowfall_loop()
		end
	end

	local function stop_snowfall()
		if is_snowing then
			is_snowing = false
		end
		renderer.clear_snow()
	end

	local function register_commands()
		vim.api.nvim_create_user_command("SnowfallStart", start_snowfall, {})
		vim.api.nvim_create_user_command("SnowfallStop", stop_snowfall, {})
	end

	config = vim.tbl_deep_extend("force", defaults, user_config or {})
	renderer.init(namespace, config.snowflake, config.count)
	register_commands()

	if config.startup then
		start_snowfall()
	end
end

return M
