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

return {
	s(
		{ name = "mathcal convert", trig = "([%w])cal", worldTrig = false, regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return "cal(" .. snip.captures[1] .. ")"
		end),
		{ condition = in_mathzone }
	),

	s(
		{ name = "vector convert", trig = "([%w])vb", worldTrig = false, regTrig = true, snippetType = "autosnippet" },
		f(function(_, snip)
			return "vb(" .. snip.captures[1] .. ")"
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
		fmta("<>^(<>)", {
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
		fmta("<>_(<>)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Fraction", trig = "ff", snippetType = "autosnippet" },
		fmta("(<>)/(<>)", {
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Sqrt", trig = "sqrt", snippetType = "autosnippet" },
		fmta("sqrt(<>)", { d(1, get_visual) }),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Indefinite Integral", trig = "inti", snippetType = "autosnippet" },
		fmta("integral <> dd(<>)", {
			d(1, get_visual),
			i(2, "x"),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Definite Integral", trig = "intd", snippetType = "autosnippet" },
		fmta("integral_(<>)^(<>) <> dd(<>)", {
			i(1),
			i(2),
			d(3, get_visual),
			i(4, "x"),
		}),
		{ condition = in_mathzone }
	),

	s({ name = "hbar", trig = "hb", snippetType = "autosnippet" }, t("hbar"), { condition = in_mathzone }),

	s({ name = "Subset", trig = "sub", snippetType = "autosnippet" }, { t("subset") }, { condition = in_mathzone }),

	s(
		{ name = "Subset Eq", trig = "esub", snippetType = "autosnippet" },
		{ t("subseteq") },
		{ condition = in_mathzone }
	),

	s(
		{ name = "Limit", trig = "lim", snippetType = "autosnippet" },
		fmta("lim_(<> ->> <>) <>", {
			i(1, "x"),
			i(2),
			d(3, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Text", trig = "txt", snippetType = "autosnippet" },
		fmta("#[<>]", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Where", trig = "(, )whr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>#[where ] <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Tilde", trig = "~", wordTrig = false, snippetType = "autosnippet" },
		fmta("tilde(<>)", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Hat", trig = "hat", wordTrig = false, snippetType = "autosnippet" },
		fmta("hat(<>)", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Bar", trig = "bar", swordTrig = false, nippetType = "autosnippet" },
		fmta("overline(<>)", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Cancel", trig = "cnl", snippetType = "autosnippet" },
		fmta("cancel(<>)", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Overbrace", trig = "ovb", snippetType = "autosnippet" },
		fmta("overbrace(<>, <>)", {
			d(1, get_visual),
			i(2, "comment"),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ name = "Underbrace", trig = "udb", snippetType = "autosnippet" },
		fmta("underbrace(<>, <>)", {
			d(1, get_visual),
			i(2, "comment"),
		}),
		{ condition = in_mathzone }
	),
}
