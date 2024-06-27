vim.g.mapleader = " "
vim.g.maplocalleader = " "

local tl_actions = require("telescope.actions")
local tl_action_state = require("telescope.actions.state")
local fb_utils = require("telescope._extensions.file_browser.utils")

local fb_open_using = function(finder)
	return function(prompt_buf)
		-- gets selections based off tab-selected multi-select entries
		local selections = fb_utils.get_selected_files(prompt_buf, false)
		local search_dirs = vim.tbl_map(function(path)
			return path:absolute()
		end, selections)

		-- if nothing is multi-selected, just use the current `path` value
		if vim.tbl_isempty(search_dirs) then
			local current_finder = tl_action_state.get_current_picker(prompt_buf).finder
			search_dirs = { current_finder.path }
		end
		tl_actions.close(prompt_buf)
		finder({ search_dirs = search_dirs })
	end
end
