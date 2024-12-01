local M = {}

-- スクリーンサイズを取得
function M.get_screen_size()
	return vim.o.lines, vim.o.columns
end

local function get_plugin_path()
	local info = debug.getinfo(1, "S") -- 現在のスクリプトの情報を取得
	local script_path = info.source:sub(2) -- パス部分を抽出 (先頭の "@" を除去)
	return vim.fn.fnamemodify(script_path, ":p:h:h:h")
end

function M.get_plugin_resource(file)
	local plugin_path = get_plugin_path()
	return plugin_path .. "/" .. file
end

return M
