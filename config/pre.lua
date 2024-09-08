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

local zotero_cite = function()
	-- Pick a format based on the filetype
	local filetype = vim.bo.filetype
	local format
	if filetype == "typst" then
		format = "typst"
	elseif filetype:match(".*tex") then
		format = "latex"
	else
		format = "mmd" -- MultiMarkdown
	end

	local api_call = "http://127.0.0.1:23119/better-bibtex/cayw?format=" .. format

	-- Use vim.fn.system instead of system()
	local ref = vim.fn.system("curl -s " .. vim.fn.shellescape(api_call))

	-- Remove any trailing newlines
	ref = ref:gsub("\n$", "")

	return ref
end

-- Display the entry as full paths to the files relative to the current working directory.
require("telescope-tabs").setup({
	entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
		local entry_string = table.concat(
			vim.tbl_map(function(v)
				return vim.fn.fnamemodify(v, ":.")
			end, file_paths),
			", "
		)
		return string.format("%d: %s%s", tab_id, entry_string, is_current and " <" or "")
	end,
})
