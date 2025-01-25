-- NOTE: These must be setup before subsequent plugins and key bindings use the "<Leader>" and "<LocalLeader>" notation.
-- Otherwise they are gonna be replaced by backslash.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- These are needed because later keybinding would use them.
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

vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "firefox --new-window " . shellescape(a:url) . " &"
            silent call system(cmd)
         endfunction
      ]])
