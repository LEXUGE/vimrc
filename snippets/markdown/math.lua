-- These are the default luasnip abbreviations. I explicitly
-- declare them just for the sake of complaining LSP.
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local mathzone = require("detect-mathzone")
local in_mathzone = mathzone.in_mathzone

local get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

-- brackets
local brackets = {
	a = { "\\langle", "\\rangle" },
	b = { "[", "]" },
	c = { "\\{", "\\}" },
	m = { "|", "|" },
	p = { "(", ")" },
}

-- For reference:
--
-- local function fn(
--     args,     -- text from i(2) in this example i.e. { { "456" } }
--     parent,   -- parent snippet or parent node
--     l_delim,  -- user_args from opts.user_args
--     r_delim   -- user_args from opts.user_args
-- )
--     return '[' .. l_delim .. args[1][1] .. r_delim .. ']'
-- end
--
--     s({ name = "trig", trig = "trig", snippetType="autosnippet" },
--         fmta(
--             "<>--i(1) <> i(2)--<>--i(2) i(0)--<>",
--             {
--                 i(1),
--                 f(
--                     fn,  -- callback (args, parent, user_args) -> string
--                     {2}, -- node indice(s) whose text is passed to fn, i.e. i(2)
--                     { user_args = { "(", ")" }} -- opts
--                 ),
--                 i(2),
--                 i(0)
--             }
--         )
--     ),

return {
	s(
		{
			trig = "lr([abcmp])",
			name = "left right",
			dscr = "left right delimiters",
			regTrig = true,
			hidden = true,
			snippetType = "autosnippet",
		},
		fmta("\\left<> <> \\right<><>", {
			f(function(_, snip)
				cap = snip.captures[1] or "p"
				return brackets[cap][1]
			end),
			d(1, get_visual),
			f(function(_, snip)
				cap = snip.captures[1] or "p"
				return brackets[cap][2]
			end),
			i(0),
		}),
		{ condition = in_mathzone, show_condition = in_mathzone }
	),

	s(
		{ name = "mathbb convert", trig = "([%w])bb", worldTrig = false, regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return "\\mathbb{" .. snip.captures[1] .. "}"
		end),
		{ condition = in_mathzone }
	),

	s(
		{ name = "mathcal convert", trig = "([%w])cal", worldTrig = false, regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return "\\mathcal{" .. snip.captures[1] .. "}"
		end),
		{ condition = in_mathzone }
	),

	s(
		{ name = "mathbf convert", trig = "([%w])bf", worldTrig = false, regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return "\\mathbf{" .. snip.captures[1] .. "}"
		end),
		{ condition = in_mathzone }
	),

	s(
		{
			name = "Superscript",
			trig = "([%w%)%]%}])^",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
		},
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{
			name = "Subscript",
			trig = "([%w%)%]%}])_",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
		},
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Fraction", trig = "ff", snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", {
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Sqrt", trig = "sqrt", snippetType = "autosnippet" },
		fmta("\\sqrt{<>}", { d(1, get_visual) }),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Indefinite Integral", trig = "inti", snippetType = "autosnippet" },
		fmta("\\int <> \\,\\mathrm{d}^{<>} <>", {
			d(1, get_visual),
			i(2),
			i(3, "x"),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Definite Integral", trig = "intd", snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>} <> \\,\\mathrm{d}^{<>} <>", {
			i(1),
			i(2),
			d(3, get_visual),
			i(4),
			i(5, "x"),
		}),
		{ condition = in_mathzone }
	),

	-- TODO: We should figure out how to use physics package to enhance these experience
	s(
		{ name = "Total Derivative", trig = "dd", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{\\mathrm{d} <>}{\\mathrm{d} <>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Partial Derivative", trig = "pdv", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{\\partial <>}{\\partial <>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Boxed", trig = "box", snippetType = "autosnippet" },
		fmta("\\boxed{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Natural Logarithm", trig = "ln", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\ln{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s({ name = "hbar", trig = "hb", snippetType = "autosnippet" }, t("\\hbar"), { condition = in_mathzone }),

	s({ name = "Infinity", trig = "inf", snippetType = "autosnippet" }, { t("\\infty") }, { condition = in_mathzone }),

	s(
		{ name = "Limit", trig = "lim", snippetType = "autosnippet" },
		fmta("\\lim_{<> \\to <>} <>", {
			i(1, "x"),
			i(2),
			d(3, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s({ name = "Implies", trig = "=>", snippetType = "autosnippet" }, { t("\\implies") }, { condition = in_mathzone }),

	s({ name = "to", trig = "->", snippetType = "autosnippet" }, { t("\\to") }, { condition = in_mathzone }),

	s({ name = "maps to", trig = "|->", snippetType = "autosnippet" }, { t("\\mapsto") }, { condition = in_mathzone }),

	s(
		{ name = "Annotated Implies", trig = "aimp", snippetType = "autosnippet" },
		fmta("\\xRightarrow[<>]{<>}", {
			i(1),
			d(2, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Text", trig = "txt", snippetType = "autosnippet" },
		fmta("\\text{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Annotated Equals Sign", trig = "aeq", snippetType = "autosnippet" },
		fmta("\\overset{<>}{=}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "In Set", trig = "inset", snippetType = "autosnippet" },
		fmta("\\in \\mathbb{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Where", trig = "(, )whr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\text{ where } <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Tilde", trig = "~", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\tilde{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Hat", trig = "hat", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\hat{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Bar", trig = "bar", swordTrig = false, nippetType = "autosnippet" },
		fmta("\\bar{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Tag", trig = "tg", snippetType = "autosnippet" },
		fmta("\\tag{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Cancel", trig = "cnl", snippetType = "autosnippet" },
		fmta("\\cancel{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
}
