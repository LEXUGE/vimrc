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

require("nvim-surround").setup({
	-- Configuration here, or leave empty to use defaults
})

require("illustrate").setup({
	prompt_caption = true,
	prompt_label = true,
	text_templates = { -- Default code template for each vector type (svg/ai) and each document (tex/md)
		svg = {
			typ = [[#figure(image("$FILE_PATH"), caption: [$CAPTION]) <$LABEL>]],
		},
		ai = {
			typ = [[#figure(image("$FILE_PATH"), caption: [$CAPTION]) <$LABEL>]],
		},
	},
})

require("typst-preview").setup({
	-- Setting this true will enable logging debug information to
	-- `vim.fn.stdpath 'data' .. '/typst-preview/log.txt'`
	debug = false,

	-- Custom format string to open the output link provided with %s
	-- Example: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
	open_cmd = "firefox %s -P tinymist",

	-- Setting this to 'always' will invert black and white in the preview
	-- Setting this to 'auto' will invert depending if the browser has enable
	-- dark mode
	-- Setting this to '{"rest": "<option>","image": "<option>"}' will apply
	-- your choice of color inversion to images and everything else
	-- separately.
	invert_colors = "never",

	-- Whether the preview will follow the cursor in the source file
	follow_cursor = true,

	-- Provide the path to binaries for dependencies.
	-- Setting this will skip the download of the binary by the plugin.
	-- These should be pointing to the nix installed binaries
	dependencies_bin = {
		["tinymist"] = "tinymist",
		["websocat"] = "websocat",
	},

	-- A list of extra arguments (or nil) to be passed to previewer.
	-- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
	extra_args = nil,

	-- This function will be called to determine the root of the typst project
	get_root = function(path_of_main_file)
		local root = os.getenv("TYPST_ROOT")
		if root then
			return root
		end
		return vim.fn.fnamemodify(path_of_main_file, ":p:h")
	end,

	-- This function will be called to determine the main file of the typst
	-- project.
	get_main_file = function(path_of_buffer)
		return path_of_buffer
	end,
})

-- It's required for us to write in vim script I am afraid
vim.cmd([[
" Expand or jump in insert mode
imap <silent><expr> jk luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'jk'

" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Jump backward through snippet tabstops with Shift-Tab (for example)
imap <silent><expr> jh luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'jh'
smap <silent><expr> jh luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'jh'
]])
