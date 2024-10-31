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
