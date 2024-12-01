local M = {}

local snowflakes = {}
local utils = require("snowfall.uitls")
local image_api = require("image")
local namespace_id

-- 雪の結晶を初期化
function M.init(namespace, snowflake, count)
	namespace_id = namespace
	local lines, cols = utils.get_screen_size()
	for _ = 1, count do
		local x = math.random(0, cols - snowflake.width)
		local y = math.random(-lines, 0)
		local image =
			image_api.from_file(snowflake.path, { x = x, y = y, width = snowflake.width, height = snowflake.height })
		if not image then
			vim.api.nvim_err_writeln("Failed to load image: " .. snowflake.path)
			return
		end
		image:render()
		table.insert(snowflakes, { x = x, y = y, image = image })
	end
end

-- 雪を更新
function M.update_position()
	local lines, _ = utils.get_screen_size()
	for _, flake in ipairs(snowflakes) do
		flake.y = flake.y + 1
		if flake.y >= lines then -- 画面を超えたらリセット
			flake.y = 0
			flake.x = math.random(0, vim.o.columns - 1) -- 0ベースで列を再生成
		end
	end
end

-- 画面に雪を描画
function M.draw_snow()
	vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)
	for _, flake in ipairs(snowflakes) do
		if flake then
			flake.image:move(flake.x, flake.y)
		end
	end
end

function M.clear_snow()
	for _, flake in ipairs(snowflakes) do
		flake.image:clear()
	end
end

return M
