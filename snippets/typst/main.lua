local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1, ""))
	end
end

return {
	s(
		{ name = "Inline Maths", trig = "mm", snippetType = "autosnippet" },
		fmta("$<>$", {
			d(1, get_visual),
		})
	),

	s(
		{ name = "Display Maths", trig = "dm", snippetType = "autosnippet" },
		fmta("$ <> $", {
			d(1, get_visual),
		})
	),

	s(
		{ name = "Import Preamble", trig = "_pre", snippetType = "autosnippet" },
		fmt(
			[[
	#import "/preamble.typ": *
	#show: setup.with("{1}")
	]],
			{ d(1, get_visual) }
		)
	),

	s(
		{ name = "Figure", trig = "_fig", snippetType = "autosnippet" },
		fmt(
			[[
			#figure(
			  image("{1}"),
			  caption: [{2}],
			) <{3}>
			]],
			{
				i(1, "path.jpg"),
				d(2, get_visual),
				d(3, get_visual),
			}
		)
	),

	s(
		{ name = "Useful packages", trig = "_pkg", snippetType = "autosnippet" },
		t({
			'#import "@preview/physica:0.9.4": *',
		})
	),

	s(
		{ name = "Import shorthands", trig = "_short", snippetType = "autosnippet" },
		t({
			"#let vb(body) = $bold(upright(body))$",
			"#let ii = sym.dotless.i",
			"#let al = sym.angle.l",
			"#let ar = sym.angle.r",
			"#let cdot = sym.dot.c",
			'#let span = text("span")',
			'#let img = text("Im")',
			'#let ker = text("Ker")',
			"#let tp = sym.times.circle",
			"#let conj(body) = $overline(body)$",
			"#let inv(body) = $body^(-1)$",
			"#let spinup = $arrow.t$",
			"#let spindown = $arrow.b$",
			"#let pm = $plus.minus$",
			"#let mp = $minus.plus$",
			"#let ft(body, out) = $cal(F)[body](out)$",
			"#let invft(body, out) = $cal(F)^(-1)[body](out)$",
			"#let op(body) = $hat(body)$",
			"#let vecop(body) = $underline(hat(body))$",
		})
	),
}
