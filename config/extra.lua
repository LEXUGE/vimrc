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
