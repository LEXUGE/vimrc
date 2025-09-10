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

-- vim.api.nvim_create_augroup("TypstAutocmds", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.typ",
-- 	callback = function(opts)
-- 		if vim.bo[opts.buf].filetype == "typst" then
-- 			local servers = require("typst-preview.servers")
-- 			servers.remove_all()
-- 			-- NOTE: I don't know why defer_fn will make it work
-- 			-- This supposedly will make it run in the next event loop
-- 			vim.defer_fn(function()
-- 				vim.cmd("TypstPreview")
-- 			end, 0)
-- 		end
-- 	end,
-- 	group = "TypstAutocmds",
-- })

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

-- Undo a trigger
local untrigger = function()
	-- get the snippet
	local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
	-- get its trigger
	local trig = snip.trigger
	-- replace that region with the trigger
	local node_from, node_to = snip.mark:pos_begin_end_raw()
	vim.api.nvim_buf_set_text(0, node_from[1], node_from[2], node_to[1], node_to[2], { trig })
	-- reset the cursor-position to ahead the trigger
	vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
end

vim.keymap.set({ "i", "s" }, "<c-c>", function()
	if require("luasnip").in_snippet() then
		untrigger()
		require("luasnip").unlink_current()
	end
end, {
	desc = "Undo a snippet",
})
